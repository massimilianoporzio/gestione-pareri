"""Test Forms module.

Questo modulo fornisce test per le forms custom di accounts.
"""

from django.contrib.auth import get_user_model
from django.test import RequestFactory, TestCase

from accounts.forms import (
    CustomAuthenticationForm,
    CustomUserChangeForm,
    CustomUserCreationForm,
)

User = get_user_model()


class TestCustomAuthenticationForm(TestCase):
    """Test suite per CustomAuthenticationForm."""

    def setUp(self):
        """Setup."""
        self.factory = RequestFactory()
        self.valid_email = "test@aslcn1.it"
        self.invalid_email = "test@gmail.com"
        self.password = "securepassword"
        self.user = User.objects.create_user(
            email=self.valid_email,
            password=self.password,
            is_staff=True,
        )

    def test_empty_username_raises(self):
        """Test empty username raises."""
        form = CustomAuthenticationForm(data={"username": "", "password": self.password})
        self.assertFalse(form.is_valid())
        self.assertIn("non può essere vuoto", str(form.errors))

    def test_invalid_email_format_raises(self):
        """Test invalid email format raises."""
        form = CustomAuthenticationForm(data={"username": "notanemail", "password": self.password})
        self.assertFalse(form.is_valid())
        self.assertIn("indirizzo email valido", str(form.errors))

    def test_invalid_email_domain_raises(self):
        """Test invalid email domain raises."""
        form = CustomAuthenticationForm(data={"username": self.invalid_email, "password": self.password})
        self.assertFalse(form.is_valid())
        # Cerca solo le parti chiave del messaggio, ignorando gli escape HTML
        self.assertIn("deve essere", str(form.errors))
        self.assertIn("@aslcn1.it", str(form.errors))

    def test_empty_password_raises(self):
        """Test empty password raises."""
        form = CustomAuthenticationForm(data={"username": self.valid_email, "password": ""})
        self.assertFalse(form.is_valid())
        self.assertIn("La password non può essere vuota", str(form.errors))

    def test_wrong_password_raises(self):
        """Test wrong password raises."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": "wrongpass"},
            request=self.factory.post("/"),
        )
        self.assertFalse(form.is_valid())
        self.assertIn("corretti per un account di staff", str(form.errors))

    def test_successful_authentication(self):
        """Test successful authentication."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": self.password},
            request=self.factory.post("/"),
        )
        self.assertTrue(form.is_valid())
        self.assertEqual(form.cleaned_data["username"], self.valid_email)
        self.assertEqual(form.get_user(), self.user)


class TestCustomUserCreationForm(TestCase):
    """Test suite per CustomUserCreationForm."""

    def test_passwords_must_match(self):
        """Test passwords must match."""
        form = CustomUserCreationForm(
            data={
                "email": "new@aslcn1.it",
                "first_name": "New",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "abc123",
                "password2": "xyz789",
            }
        )
        self.assertFalse(form.is_valid())
        self.assertIn("Le password non corrispondono", str(form.errors))

    def test_successful_user_creation(self):
        """Test successful user creation."""
        form = CustomUserCreationForm(
            data={
                "email": "new@aslcn1.it",
                "first_name": "New",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "abc123",
                "password2": "abc123",
            }
        )
        self.assertTrue(form.is_valid())
        user = form.save()
        self.assertEqual(user.email, "new@aslcn1.it")
        self.assertTrue(user.check_password("abc123"))


class TestCustomUserChangeForm(TestCase):
    """Test suite per CustomUserChangeForm."""

    def test_change_form_fields(self):
        """Test change form fields."""
        user = User.objects.create_user(
            email="change@aslcn1.it",
            password="pass",
            first_name="Change",
            last_name="User",
            gender="F",
            is_staff=True,
            is_active=True,
        )
        form = CustomUserChangeForm(instance=user)
        fields = form.fields.keys()
        expected_fields = {
            "email",
            "first_name",
            "last_name",
            "gender",
            "is_staff",
            "is_active",
            "groups",
            "user_permissions",
            "password",
        }
        self.assertEqual(set(fields), expected_fields)


class TestCustomUserCreationFormExtra(TestCase):
    """Test suite per TestCustomUserCreationFormExtra."""

    def test_clean_password2_returns_when_matching(self):
        """Test clean password2 returns when matching."""
        form = CustomUserCreationForm(
            data={
                "email": "match@aslcn1.it",
                "first_name": "Match",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "samepass",
                "password2": "samepass",
            }
        )
        self.assertTrue(form.is_valid())
        self.assertEqual(form.clean_password2(), "samepass")

    def test_save_with_commit_false_does_not_persist_but_sets_password(self):
        """Test save with commit false does not persist but sets password."""
        form = CustomUserCreationForm(
            data={
                "email": "nosave@aslcn1.it",
                "first_name": "No",
                "last_name": "Save",
                "gender": "F",
                "is_staff": False,
                "is_active": True,
                "password": "commitpass",
                "password2": "commitpass",
            }
        )
        self.assertTrue(form.is_valid())
        user = form.save(commit=False)
        # Instance is not persisted yet
        self.assertIsNone(getattr(user, "pk", None))
        # Password must be set (hashed) on the instance
        self.assertTrue(user.check_password("commitpass"))


class TestCustomUserChangeFormExtra(TestCase):
    """Test suite per TestCustomUserChangeFormExtra."""

    def test_password_field_is_readonly_hash(self):
        """Test password field is readonly hash."""
        user = User.objects.create_user(
            email="hash@aslcn1.it",
            password="initpass",
            first_name="Hash",
            last_name="Tester",
            gender="M",
            is_staff=True,
            is_active=True,
        )
        form = CustomUserChangeForm(instance=user)
        field = form.fields.get("password")
        self.assertIsNotNone(field)
        self.assertEqual(field.__class__.__name__, "ReadOnlyPasswordHashField")

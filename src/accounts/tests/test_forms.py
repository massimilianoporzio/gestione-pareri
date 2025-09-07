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
    """Test suite for TestCustomAuthenticationForm."""

    def test_clean_username_missing_direct(self):
        """Chiama direttamente clean con username mancante."""
        form = CustomAuthenticationForm(
            data={"username": "", "password": self.password}
        )
        form.is_valid()
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_invalid_email_format_direct(self):
        """Chiama direttamente clean con email non valida."""
        form = CustomAuthenticationForm(
            data={"username": "notanemail", "password": self.password}
        )
        form.is_valid()
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_invalid_email_domain_direct(self):
        """Chiama direttamente clean con dominio non valido."""
        form = CustomAuthenticationForm(
            data={"username": self.invalid_email, "password": self.password}
        )
        form.is_valid()
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_password_missing_direct(self):
        """Chiama direttamente clean con password mancante."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": ""}
        )
        form.is_valid()
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_authentication_failed_direct(self):
        """Chiama direttamente clean con autenticazione fallita."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": "wrongpass"},
            request=self.factory.post("/"),
        )
        form.is_valid()
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_authentication_success_direct(self):
        """Chiama direttamente clean con autenticazione riuscita."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": self.password},
            request=self.factory.post("/"),
        )
        form.is_valid()
        result = form.clean()
        self.assertEqual(result["username"], self.valid_email)

    """Test suite for TestCustomAuthenticationForm."""

    def test_get_user_none_if_not_authenticated(self):
        """get_user deve restituire None se non autenticato."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": "wrongpass"},
            request=self.factory.post("/"),
        )
        form.is_valid()
        self.assertIsNone(form.get_user())

    """Test suite for TestCustomAuthenticationForm."""

    def test_authentication_form_init_with_request(self):
        """Test __init__ with request argument."""
        request = self.factory.get("/")
        form = CustomAuthenticationForm(request=request)
        self.assertEqual(form.request, request)
        self.assertIsNone(form.user_cache)

    def test_get_user_returns_none_before_auth(self):
        """Test get_user returns None before authentication."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": self.password}
        )
        self.assertIsNone(form.get_user())

    def test_clean_successful_authentication(self):
        """Test clean returns cleaned_data on success."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": self.password},
            request=self.factory.post("/"),
        )
        self.assertTrue(form.is_valid())
        cleaned = form.clean()
        self.assertEqual(cleaned["username"], self.valid_email)

    def test_clean_password_missing(self):
        """Test clean raises error if password missing."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": ""}
        )
        self.assertFalse(form.is_valid())
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_invalid_email_format(self):
        """Test clean raises error for invalid email format."""
        form = CustomAuthenticationForm(
            data={"username": "notanemail", "password": self.password}
        )
        self.assertFalse(form.is_valid())
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_invalid_email_domain(self):
        """Test clean raises error for invalid email domain."""
        form = CustomAuthenticationForm(
            data={"username": self.invalid_email, "password": self.password}
        )
        self.assertFalse(form.is_valid())
        with self.assertRaises(Exception):
            form.clean()

    def test_clean_wrong_password(self):
        """Test clean raises error for wrong password."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": "wrongpass"},
            request=self.factory.post("/"),
        )
        self.assertFalse(form.is_valid())
        with self.assertRaises(Exception):
            form.clean()

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
        form = CustomAuthenticationForm(
            data={"username": "", "password": self.password}
        )
        self.assertFalse(form.is_valid())
        self.assertIn("non può essere vuoto", str(form.errors))

    def test_invalid_email_format_raises(self):
        """Test invalid email format raises."""
        form = CustomAuthenticationForm(
            data={"username": "notanemail", "password": self.password}
        )
        self.assertFalse(form.is_valid())
        self.assertIn("indirizzo email valido", str(form.errors))

    def test_invalid_email_domain_raises(self):
        """Test invalid email domain raises."""
        form = CustomAuthenticationForm(
            data={"username": self.invalid_email, "password": self.password}
        )
        self.assertFalse(form.is_valid())
        # Cerca solo le parti chiave del messaggio, ignorando gli escape HTML
        self.assertIn("deve essere", str(form.errors))
        self.assertIn("@aslcn1.it", str(form.errors))

    def test_empty_password_raises(self):
        """Test empty password raises."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": ""}
        )
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
    """Test suite for TestCustomUserCreationForm."""

    def test_save_direct_commit_true(self):
        """Chiama direttamente save con commit=True."""
        form = CustomUserCreationForm(
            data={
                "email": "directtrue@aslcn1.it",
                "first_name": "DirectTrue",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "pass123",
                "password2": "pass123",
            }
        )
        form.is_valid()
        user = form.save(commit=True)
        self.assertIsNotNone(user.pk)
        self.assertTrue(user.check_password("pass123"))

    def test_save_direct_commit_false(self):
        """Chiama direttamente save con commit=False."""
        form = CustomUserCreationForm(
            data={
                "email": "directfalse@aslcn1.it",
                "first_name": "DirectFalse",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "pass123",
                "password2": "pass123",
            }
        )
        form.is_valid()
        user = form.save(commit=False)
        self.assertIsNone(user.pk)
        self.assertTrue(user.check_password("pass123"))

    """Test suite for TestCustomUserCreationForm."""

    def test_clean_password2_missing_fields(self):
        """Test clean_password2 con uno o entrambi i campi mancanti."""
        # password2 mancante
        form = CustomUserCreationForm(
            data={
                "email": "missing@aslcn1.it",
                "first_name": "Missing",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "abc123",
            }
        )
        self.assertFalse(form.is_valid())
        # password mancante
        form2 = CustomUserCreationForm(
            data={
                "email": "missing2@aslcn1.it",
                "first_name": "Missing2",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password2": "abc123",
            }
        )
        self.assertFalse(form2.is_valid())

    def test_save_commit_true(self):
        """Test save con commit=True salva l'utente."""
        form = CustomUserCreationForm(
            data={
                "email": "committrue@aslcn1.it",
                "first_name": "CommitTrue",
                "last_name": "User",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "pass123",
                "password2": "pass123",
            }
        )
        self.assertTrue(form.is_valid())
        user = form.save(commit=True)
        self.assertIsNotNone(user.pk)
        self.assertTrue(user.check_password("pass123"))

    """Test suite for TestCustomUserCreationForm."""

    def test_save_commit_false(self):
        """Test save with commit=False does not persist user."""
        form = CustomUserCreationForm(
            data={
                "email": "commitfalse@aslcn1.it",
                "first_name": "Commit",
                "last_name": "False",
                "gender": "M",
                "is_staff": True,
                "is_active": True,
                "password": "pass123",
                "password2": "pass123",
            }
        )
        self.assertTrue(form.is_valid())
        user = form.save(commit=False)
        self.assertIsNone(user.pk)
        self.assertTrue(user.check_password("pass123"))

    def test_meta_fields(self):
        """Test Meta fields are correct."""
        form = CustomUserCreationForm()
        meta_fields = set(form._meta.fields)
        expected = {
            "email",
            "first_name",
            "last_name",
            "gender",
            "is_staff",
            "is_active",
            "groups",
        }
        self.assertTrue(expected.issubset(meta_fields))

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
    """Test suite for TestCustomUserChangeForm."""

    def test_meta_fields(self):
        """Test Meta fields are correct for change form."""
        form = CustomUserChangeForm()
        meta_fields = set(form._meta.fields)
        expected = {
            "email",
            "first_name",
            "last_name",
            "gender",
            "is_staff",
            "is_active",
            "groups",
            "user_permissions",
        }
        self.assertTrue(expected.issubset(meta_fields))

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

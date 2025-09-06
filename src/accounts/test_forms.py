"""Test Forms module.

Questo modulo fornisce funzionalità per test forms.
"""

import pytest
from django import forms
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.test import RequestFactory

from accounts.forms import (
    CustomAuthenticationForm,
    CustomUserChangeForm,
    CustomUserCreationForm,
)

User = get_user_model()


@pytest.mark.django_db
class TestCustomAuthenticationForm:
    def setup_method(self):
        """Setup method."""
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
        with pytest.raises(ValidationError) as exc:
            form.clean()
        assert "non può essere vuoto" in str(exc.value)

    def test_invalid_email_format_raises(self):
        """Test invalid email format raises."""
        form = CustomAuthenticationForm(
            data={"username": "notanemail", "password": self.password}
        )
        with pytest.raises(ValidationError) as exc:
            form.clean()
        assert "indirizzo email valido" in str(exc.value)

    def test_invalid_email_domain_raises(self):
        """Test invalid email domain raises."""
        form = CustomAuthenticationForm(
            data={"username": self.invalid_email, "password": self.password}
        )
        with pytest.raises(ValidationError) as exc:
            form.clean()
        assert "deve essere '@aslcn1.it'" in str(exc.value)

    def test_empty_password_raises(self):
        """Test empty password raises."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": ""}
        )
        with pytest.raises(ValidationError) as exc:
            form.clean()
        assert "La password non può essere vuota" in str(exc.value)

    def test_wrong_password_raises(self):
        """Test wrong password raises."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": "wrongpass"},
            request=self.factory.post("/"),
        )
        with pytest.raises(ValidationError) as exc:
            form.clean()
        assert "corretti per un account di staff" in str(exc.value)

    def test_successful_authentication(self):
        """Test successful authentication."""
        form = CustomAuthenticationForm(
            data={"username": self.valid_email, "password": self.password},
            request=self.factory.post("/"),
        )
        cleaned = form.clean()
        assert cleaned["username"] == self.valid_email
        assert form.get_user() == self.user


@pytest.mark.django_db
class TestCustomUserCreationForm:
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
        with pytest.raises(forms.ValidationError) as exc:
            form.clean_password2()
        assert "Le password non corrispondono" in str(exc.value)

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
        assert form.is_valid()
        user = form.save()
        assert user.email == "new@aslcn1.it"
        assert user.check_password("abc123")


@pytest.mark.django_db
class TestCustomUserChangeForm:
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
        assert set(fields) == expected_fields

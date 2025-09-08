# Create your models here.
"""Models module.

Questo modulo fornisce funzionalità per models.
"""

from concurrency.fields import IntegerVersionField
from crum import get_current_user
from django.conf import settings
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.core.exceptions import ValidationError
from django.db import models
from django.utils.translation import gettext_lazy as _


# Manager personalizzato per il tuo CustomUser
class CustomUserManager(BaseUserManager):
    """Custom user manager for CustomUser model.

    Handles user creation with email validation and domain requirements.
    """

    def full_clean(self, email):
        """Full clean.

        Args:
            email: Descrizione di email

        Returns:
            Descrizione del valore restituito
        """
        # Validazione dominio aziendale
        if not email.endswith("@aslcn1.it"):
            raise ValidationError(
                _("Il dominio dell'indirizzo email deve essere '@aslcn1.it'.")
            )

    def create_user(self, email, password=None, **extra_fields):
        """Create and return a user with email and password.

        Args:
            email: User's email address
            password: User's password (optional)
            **extra_fields: Additional fields for the user

        Returns:
            CustomUser: The created user instance
        """
        if not email:
            raise ValueError(_("L'indirizzo email deve essere impostato"))
        # Aggiungi la validazione qui
        self.full_clean(email)
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        """Create and return a superuser with email and password.

        Args:
            email: Superuser's email address
            password: Superuser's password (optional)
            **extra_fields: Additional fields for the superuser

        Returns:
            CustomUser: The created superuser instance
        """
        # Aggiungi la validazione qui
        self.full_clean(email)
        # Imposta i campi necessari per un superuser
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault(
            "is_active", True
        )  # I superuser dovrebbero essere attivi per default

        if extra_fields.get("is_staff") is not True:
            raise ValueError(_("Superuser deve avere is_staff=True."))
        if extra_fields.get("is_superuser") is not True:
            raise ValueError(_("Superuser deve avere is_superuser=True."))

        # Chiama il metodo create_user del manager, passando l'email
        return self.create_user(email, password, **extra_fields)


class CustomUser(AbstractUser):
    """Custom user model extending AbstractUser.

    Uses email as the primary identifier and includes additional fields
    for gender and audit tracking with domain validation.
    """

    # Rimuovi il campo username se vuoi usare solo l'email per l'autenticazione
    # Non è necessario rimuoverlo esplicitamente, ma puoi renderlo non obbligatorio
    # o semplicemente non usarlo.
    # Se vuoi che l'email sia l'UNICO campo per l'autenticazione, devi impostare:
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []  # Campi richiesti oltre a USERNAME_FIELD e password

    email = models.EmailField(
        _("indirizzo email aziendale"), unique=True
    )  # pragma: no cover
    username = models.CharField(
        _("nome utente"), max_length=150, unique=True, blank=True, null=True
    )  # pragma: no cover
    GENDER_CHOICES = [
        ("M", "Maschio"),
        ("F", "Femmina"),
    ]
    gender = models.CharField(
        max_length=1,
        choices=GENDER_CHOICES,
        blank=True,  # Rendi il campo facoltativo
        null=True,  # Permetti valori NULL nel database
        verbose_name=_("genere"),
    )  # pragma: no cover

    # Aggiungi qui eventuali altri campi personalizzati
    version = IntegerVersionField()  # pragma: no cover

    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="created_%(class)s_set",
    )  # pragma: no cover
    created_by_fullname = models.CharField(
        max_length=150, blank=True
    )  # pragma: no cover
    updated_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="updated_%(class)s_set",
    )  # pragma: no cover
    updated_by_fullname = models.CharField(
        max_length=150, blank=True
    )  # pragma: no cover

    created_at = models.DateTimeField(
        _("created at"),
        auto_now_add=True,
    )  # pragma: no cover
    updated_at = models.DateTimeField(
        _("updated at"), auto_now=True
    )  # pragma: no cover

    def __str__(self):
        """Return the full name of the user."""
        return self.get_full_name()

    # Assegna il manager personalizzato al tuo modello utente
    objects = CustomUserManager()

    @property
    def email_prefix_display(self):
        """Restituisce la parte dell'email prima della @ per la visualizzazione."""
        if self.email:
            return self.email.split("@")[0]
        return ""

    def get_short_name(self):
        """Restituisce il prefisso dell'email come nome breve."""
        return self.email_prefix_display

    @property
    def nome_utente(self):
        """Restituisce il nome completo dell'utente."""
        if self.first_name and self.last_name:
            return f"{self.first_name} {self.last_name}"
        elif self.first_name:
            return self.first_name
        elif self.last_name:
            return self.last_name
        return self.get_short_name()

    def clean(self):
        """Validate the model instance."""
        super().clean()
        # Validazione dominio aziendale
        if self.email and not self.email.endswith("@aslcn1.it"):
            raise ValidationError(
                _("Il dominio dell'indirizzo email deve essere '@aslcn1.it'.")
            )

    def save(self, *args, **kwargs):
        """Save the user instance."""
        if not self.username and self.email:
            self.username = self.email_prefix_display
        user = get_current_user()
        if user and not user.is_anonymous:
            # Se il record è nuovo (non ha ancora una chiave primaria)
            if not self.pk:
                self.created_by = user
                self.created_by_fullname = (
                    user.nome_utente if hasattr(user, "nome_utente") else str(user)
                )
            # L'utente che ha fatto l'ultima modifica è sempre l'utente corrente
            self.updated_by = user
            self.updated_by_fullname = (
                user.nome_utente if hasattr(user, "nome_utente") else str(user)
            )

        super().save(*args, **kwargs)

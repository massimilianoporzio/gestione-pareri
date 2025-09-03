"""Admin module.

Questo modulo fornisce funzionalità per admin.
"""

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .forms import CustomUserChangeForm, CustomUserCreationForm
from .models import CustomUser


@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    """Admin interface for CustomUser model."""

    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser

    list_display = (
        "email",
        "first_name",
        "last_name",
        "is_staff",
        "is_active",
        "date_joined",
    )

    list_filter = (
        "is_staff",
        "is_active",
        "date_joined",
        "is_superuser",
        "gender",
        "groups",
    )

    fieldsets = (
        (None, {"fields": ("email", "password")}),
        ("Informazioni personali", {"fields": ("first_name", "last_name", "gender")}),
        (
            "Permessi",
            {
                "fields": (
                    "is_active",
                    "is_staff",
                    "is_superuser",
                    "groups",
                    "user_permissions",
                )
            },
        ),
        ("Date importanti", {"fields": ("last_login", "date_joined")}),
        ("Audit", {"fields": ("created_by", "updated_by"), "classes": ("collapse",)}),
    )

    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": (
                    "email",
                    "password",
                    "password2",
                    "first_name",
                    "last_name",
                    "gender",
                    "is_staff",
                    "is_active",
                    "groups",
                ),
            },
        ),
    )

    search_fields = ("email", "first_name", "last_name")
    ordering = ("email",)

    readonly_fields = ("created_by", "updated_by", "date_joined", "last_login")
    filter_horizontal = ("groups", "user_permissions")

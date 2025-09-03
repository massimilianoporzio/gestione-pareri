"""Settings per test locali con SQLite."""

from home.settings.dev import *  # noqa: F403, F401

# Database per test - Solo SQLite
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3", 
        "NAME": ":memory:",
    }
}

# Password hashers più veloci per i test
PASSWORD_HASHERS = [
    "django.contrib.auth.hashers.MD5PasswordHasher",
]

# Cache dummy per test
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.dummy.DummyCache",
    }
}

# Email backend per test
EMAIL_BACKEND = "django.core.mail.backends.locmem.EmailBackend"

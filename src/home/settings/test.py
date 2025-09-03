"""Impostazioni di Django per l'ambiente di test."""

from decouple import config

from home.settings.base import *  # noqa: F403, F401

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# ALLOWED_HOSTS
ALLOWED_HOSTS = ["localhost", "127.0.0.1"]

# WhiteNoise per servire file statici in test/staging
MIDDLEWARE.insert(1, "whitenoise.middleware.WhiteNoiseMiddleware")  # noqa: F405

# Configurazione WhiteNoise
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"

# WhiteNoise settings per test
WHITENOISE_USE_FINDERS = True  # Consente di servire file da STATICFILES_DIRS
WHITENOISE_AUTOREFRESH = True  # Auto-refresh in test per development-like experience

# Database per test - SQLite in memoria per velocità o PostgreSQL per test completi
if config("USE_POSTGRESQL_TEST", default=False, cast=bool):
    # PostgreSQL per test completi (più lenti ma più realistici)
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.postgresql",
            "NAME": config("DB_NAME_TEST", default="gestione_pareri_test"),
            "USER": config("DB_USER_TEST", default="gestione_pareri_test"),
            "PASSWORD": config("DB_PASSWORD_TEST"),
            "HOST": config("DB_HOST", default="localhost"),
            "PORT": config("DB_PORT", default="5432"),
            "OPTIONS": {
                # PostgreSQL options (nessun charset necessario)
            },
        }
    }
else:
    # SQLite in memoria per test veloci (default)
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": ":memory:",
        }
    }

# Configurazione di logging per i test - solo console
LOGGING["root"]["level"] = "WARNING"  # noqa: F405
# In ambiente di test, utilizziamo solo la console per il logging
for logger_name in LOGGING["loggers"]:  # noqa: F405
    if "handlers" in LOGGING["loggers"][logger_name]:  # noqa: F405
        LOGGING["loggers"][logger_name]["handlers"] = ["console"]  # noqa: F405

# Configurazioni di cache per i test
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.dummy.DummyCache",
    }
}

# Configura l'email backend per i test
EMAIL_BACKEND = "django.core.mail.backends.locmem.EmailBackend"

# Disabilita la protezione CSRF per i test
MIDDLEWARE = [m for m in MIDDLEWARE if m != "django.middleware.csrf.CsrfViewMiddleware"]  # noqa: F405

# Password hashers più veloci per i test
PASSWORD_HASHERS = [
    "django.contrib.auth.hashers.MD5PasswordHasher",
]

# Configurazione dei file statici e media per i test
STATIC_URL = "/static/"
MEDIA_URL = "/media/"
MEDIA_ROOT = REPO_DIR / "media"  # noqa: F405

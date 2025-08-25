"""
Impostazioni di Django per l'ambiente di sviluppo.
"""

from home.settings.base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# ALLOWED_HOSTS
ALLOWED_HOSTS = ["localhost", "127.0.0.1"]

# Configurazione di logging per lo sviluppo
LOGGING["root"]["level"] = "DEBUG"  # noqa: F405
LOGGING["loggers"]["django"]["level"] = "INFO"  # noqa: F405
# In sviluppo, utilizziamo solo la console per il logging
for logger_name in LOGGING["loggers"]:  # noqa: F405
    if "handlers" in LOGGING["loggers"][logger_name]:  # noqa: F405
        LOGGING["loggers"][logger_name]["handlers"] = ["console"]  # noqa: F405

# Database di sviluppo
# Puoi utilizzare SQLite per lo sviluppo o sovrascrivere per usare PostgreSQL/MySQL
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",  # noqa: F405
    }
}

# Configurazioni per la sicurezza delle email in sviluppo
EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"

# Static e Media files in sviluppo
STATIC_URL = "/static/"
STATIC_ROOT = REPO_DIR / "staticfiles"  # noqa: F405
MEDIA_URL = "/media/"
MEDIA_ROOT = REPO_DIR / "mediafiles"  # noqa: F405

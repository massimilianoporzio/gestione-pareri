"""Impostazioni di Django per l'ambiente di produzione."""

import os

from decouple import config

from home.settings.base import *  # noqa: F403, F401

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False


# Parse comma-separated values for hosts and origins
def parse_list(val, separator=","):
    """Analizza una stringa separata da delimitatori e la converte in lista.

    Args:
        val (str): La stringa da analizzare
        separator (str, optional): Il separatore da utilizzare. Default: ","

    Returns:
        list: Lista di valori ripuliti dagli spazi
    """
    return [x.strip() for x in val.split(separator) if x.strip()]


# ALLOWED_HOSTS configuration
ALLOWED_HOSTS = parse_list(config("DJANGO_ALLOWED_HOSTS", default=".onrender.com,.example.com"))

# CSRF trusted origins configuration
CSRF_TRUSTED_ORIGINS = []
# Add https:// prefix to each domain if not already present
origins = parse_list(config("DJANGO_CSRF_TRUSTED_ORIGINS", default=".onrender.com,.example.com"))
CSRF_TRUSTED_ORIGINS = [
    f"https://{origin}" if not origin.startswith(("http://", "https://")) else origin for origin in origins
]

# Database di produzione
# Configura il database di produzione, ad esempio PostgreSQL
# Se stiamo eseguendo un test, usa SQLite invece di PostgreSQL
if os.environ.get("DJANGO_TEST_DB", "0") == "1":
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": ":memory:",  # Database in memoria
        }
    }
else:
    DATABASES = {
        "default": {
            "ENGINE": config("DB_ENGINE", default="django.db.backends.postgresql"),
            "NAME": config("DB_NAME", default="deploy_django"),
            "USER": config("DB_USER", default="postgres"),
            "PASSWORD": config("DB_PASSWORD", default=""),
            "HOST": config("DB_HOST", default="localhost"),
            "PORT": config("DB_PORT", default="5432"),
            "CONN_MAX_AGE": config("DB_CONN_MAX_AGE", default=600, cast=int),
        }
    }

# Configurazione di sicurezza per la produzione
SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")
SECURE_SSL_REDIRECT = config("DJANGO_SECURE_SSL_REDIRECT", default=True, cast=bool)
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
SECURE_HSTS_SECONDS = 60 * 60 * 24 * 30  # 30 giorni
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True
SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_BROWSER_XSS_FILTER = True
X_FRAME_OPTIONS = "DENY"

# Email configuration
EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
EMAIL_HOST = config("EMAIL_HOST", default="smtp.gmail.com")
EMAIL_PORT = config("EMAIL_PORT", default=587, cast=int)
EMAIL_USE_TLS = config("EMAIL_USE_TLS", default=True, cast=bool)
EMAIL_HOST_USER = config("EMAIL_HOST_USER", default="")
EMAIL_HOST_PASSWORD = config("EMAIL_HOST_PASSWORD", default="")
DEFAULT_FROM_EMAIL = config("DEFAULT_FROM_EMAIL", default="noreply@example.com")

# Static e Media files in produzione
STATIC_URL = "/static/"
STATIC_ROOT = REPO_DIR / "staticfiles"  # noqa: F405
MEDIA_URL = "/media/"
MEDIA_ROOT = REPO_DIR / "mediafiles"  # noqa: F405

# Configurazione del logging per produzione
LOGGING["handlers"]["file"]["level"] = "INFO"  # noqa: F405
LOGGING["root"]["level"] = "WARNING"  # noqa: F405
LOGGING["loggers"]["django"]["level"] = "WARNING"  # noqa: F405

# In produzione, aggiungiamo il file handler a tutti i logger
LOGGING["root"]["handlers"] = ["file", "console"]  # noqa: F405
for logger_name in LOGGING["loggers"]:  # noqa: F405
    if "handlers" in LOGGING["loggers"][logger_name]:  # noqa: F405
        # Manteniamo mail_admins dove è presente, aggiungiamo file e console
        handlers = LOGGING["loggers"][logger_name]["handlers"]  # noqa: F405
        if "mail_admins" in handlers:
            LOGGING["loggers"][logger_name]["handlers"] = ["file", "mail_admins", "console"]  # noqa: F405
        else:
            LOGGING["loggers"][logger_name]["handlers"] = ["file", "console"]  # noqa: F405

# Cache configuration
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.redis.RedisCache",
        "LOCATION": config("REDIS_URL", default="redis://127.0.0.1:6379/1"),
    }
}

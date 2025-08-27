"""Impostazioni di Django per l'ambiente di produzione."""

import os

from decouple import Csv, config

from home.settings.base import *  # noqa: F403, F401

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

# WhiteNoise per servire file statici in produzione
MIDDLEWARE.insert(1, "whitenoise.middleware.WhiteNoiseMiddleware")  # noqa: F405

# Configurazione WhiteNoise per produzione
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"

# WhiteNoise settings per produzione
WHITENOISE_USE_FINDERS = False  # Non usare finders in produzione
WHITENOISE_AUTOREFRESH = False  # Disabilita auto-refresh in produzione
WHITENOISE_MAX_AGE = 31536000  # Cache files for 1 year (31536000 seconds)

# Servire anche i media files con WhiteNoise (solo se non usi un CDN)
# Nota: In produzione è meglio usare un CDN per i media files
WHITENOISE_USE_FINDERS = False
WHITENOISE_STATIC_PREFIX = "/static/"


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


# ALLOWED_HOSTS configuration (deve essere sempre impostato via variabile d'ambiente)
ALLOWED_HOSTS = parse_list(config("DJANGO_ALLOWED_HOSTS"))

# CSRF trusted origins configuration (deve essere sempre impostato via variabile d'ambiente)
origins = parse_list(config("DJANGO_CSRF_TRUSTED_ORIGINS"))
CSRF_TRUSTED_ORIGINS = config("CSRF_TRUSTED_ORIGINS", cast=Csv(), default=None)
if CSRF_TRUSTED_ORIGINS is None:
    CSRF_TRUSTED_ORIGINS = []
    for host in ALLOWED_HOSTS:
        # Skip empty, localhost, or wildcard hosts
        if not host or host in ["localhost", "127.0.0.1"] or host.startswith("."):
            continue
        # Remove port if present
        host_no_port = host.split(":")[0]
        # Add https:// prefix if not present
        if host_no_port.startswith("http://") or host_no_port.startswith("https://"):
            origin = host_no_port
        else:
            origin = f"https://{host_no_port}"
        CSRF_TRUSTED_ORIGINS.append(origin)

# Database di produzione
# Configura il database di produzione, ad esempio PostgreSQL
# Se stiamo eseguendo un test, usa SQLite invece di PostgreSQL
if os.environ.get("DJANGO_TEST_DB", "0") == "1" or not config("DB_NAME", default=""):
    # Usa SQLite se non è configurato PostgreSQL o se è un test
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": REPO_DIR / "db_prod.sqlite3",  # noqa: F405
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
MEDIA_ROOT = REPO_DIR / "media"  # noqa: F405

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

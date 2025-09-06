"""Impostazioni di Django per l'ambiente di staging/pre-produzione."""

from decouple import config

from home.settings.base import *  # noqa: F403, F401

# SECURITY WARNING: don't run with debug turned on in staging!
DEBUG = config("DJANGO_DEBUG_STAGING", default=False, cast=bool)

# ALLOWED_HOSTS per staging
ALLOWED_HOSTS = [
    "localhost",
    "127.0.0.1",
    "staging.gestione-pareri.local",
    "*.staging.local",
]

# WhiteNoise per servire file statici in staging
MIDDLEWARE.insert(1, "whitenoise.middleware.WhiteNoiseMiddleware")  # noqa: F405

# Configurazione WhiteNoise per staging
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"

# WhiteNoise settings per staging
WHITENOISE_USE_FINDERS = True  # Consente di servire file da STATICFILES_DIRS per debug
WHITENOISE_AUTOREFRESH = True  # Auto-refresh in staging per testing

# Database per staging - Sempre PostgreSQL per essere identico a produzione
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": config("DB_NAME_STAGING", default="gestione_pareri_staging"),
        "USER": config("DB_USER_STAGING", default="gestione_pareri_staging"),
        "PASSWORD": config("DB_PASSWORD_STAGING"),
        "HOST": config("DB_HOST", default="localhost"),
        "PORT": config("DB_PORT", default="5432"),
        "CONN_MAX_AGE": config("DB_CONN_MAX_AGE", default=600, cast=int),
    }
}

# Configurazione di logging per staging - Console + File
LOGGING["handlers"]["file"]["level"] = "INFO"  # noqa: F405
LOGGING["root"]["level"] = "INFO"  # noqa: F405
LOGGING["loggers"]["django"]["level"] = "INFO"  # noqa: F405

# In staging, usiamo sia console che file per il logging
LOGGING["root"]["handlers"] = ["file", "console"]  # noqa: F405
for logger_name in LOGGING["loggers"]:  # noqa: F405
    if "handlers" in LOGGING["loggers"][logger_name]:  # noqa: F405
        # Manteniamo mail_admins dove è presente per staging
        handlers = LOGGING["loggers"][logger_name]["handlers"]  # noqa: F405
        if "mail_admins" in handlers:
            LOGGING["loggers"][logger_name]["handlers"] = [
                "file",
                "mail_admins",
                "console",
            ]  # noqa: F405
        else:
            LOGGING["loggers"][logger_name]["handlers"] = ["file", "console"]  # noqa: F405

# Configurazioni di cache per staging
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.redis.RedisCache",
        "LOCATION": config(
            "REDIS_URL", default="redis://127.0.0.1:6379/2"
        ),  # Database Redis diverso da prod
    }
}

# Email backend per staging - Può usare SMTP reale o console
EMAIL_BACKEND = config(
    "EMAIL_BACKEND_STAGING", default="django.core.mail.backends.console.EmailBackend"
)

# Static e Media files per staging
STATIC_URL = "/static/"
STATIC_ROOT = REPO_DIR / "staticfiles_staging"  # noqa: F405
MEDIA_URL = "/media/"
MEDIA_ROOT = REPO_DIR / "media_staging"  # noqa: F405

# Configurazioni di sicurezza per staging (simili a prod ma meno rigide)
SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")
SECURE_SSL_REDIRECT = config(
    "DJANGO_SECURE_SSL_REDIRECT_STAGING", default=False, cast=bool
)
SESSION_COOKIE_SECURE = config(
    "DJANGO_SESSION_COOKIE_SECURE_STAGING", default=False, cast=bool
)
CSRF_COOKIE_SECURE = config(
    "DJANGO_CSRF_COOKIE_SECURE_STAGING", default=False, cast=bool
)

# Meno restrittive per testing
SECURE_HSTS_SECONDS = 0  # Disabilita HSTS in staging
SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_BROWSER_XSS_FILTER = True
X_FRAME_OPTIONS = "DENY"

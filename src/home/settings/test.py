"""
Impostazioni di Django per l'ambiente di test.
"""

from home.settings.base import LOGGING, MIDDLEWARE

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# ALLOWED_HOSTS
ALLOWED_HOSTS = ["localhost", "127.0.0.1"]

# Utilizza un database in memoria per i test
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

"""WSGI config for home project.

It exposes the WSGI callable as a module-level variable named ``application``.

The settings module is determined by the DJANGO_ENV environment variable:
- DJANGO_ENV=dev -> home.settings.dev
- DJANGO_ENV=test -> home.settings.test
- DJANGO_ENV=prod -> home.settings.prod

For more information on this file, see
https://docs.djangoproject.com/en/5.2/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

# Determine settings module based on DJANGO_ENV
django_env = os.environ.get("DJANGO_ENV", "dev")
settings_module = f"home.settings.{django_env}"

os.environ.setdefault("DJANGO_SETTINGS_MODULE", settings_module)

application = get_wsgi_application()

#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""

# pylint: disable=import-outside-toplevel
import os
import sys


def main():
    """Run administrative tasks."""
    # Determina l'ambiente da utilizzare
    from decouple import config

    django_env = config("DJANGO_ENV", default="dev")

    # Imposta il modulo delle impostazioni direttamente per l'ambiente specifico
    settings_module = f"home.settings.{django_env}"
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", settings_module)

    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == "__main__":
    main()

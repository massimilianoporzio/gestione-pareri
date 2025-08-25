"""Django settings manager - Carica l'ambiente appropriato in base alla variabile d'ambiente."""

# pylint: disable=all  # Disabilita tutti i controlli pylint in questo file che usa wildcard import
# flake8: noqa: F401, F403  # Disabilita i controlli flake8 per wildcard import

import os
import sys
from pathlib import Path

from decouple import config

# Determina quale file di impostazioni caricare
DJANGO_ENV = config("DJANGO_ENV", default="dev")

# Imposta il modulo di impostazioni corrente
settings_module = f"home.settings.{DJANGO_ENV}"

# Per script di gestione come manage.py, assicurati che il modulo di impostazioni sia corretto
if "DJANGO_SETTINGS_MODULE" not in os.environ:
    os.environ["DJANGO_SETTINGS_MODULE"] = settings_module
elif (
    "home.settings" in os.environ["DJANGO_SETTINGS_MODULE"] and os.environ["DJANGO_SETTINGS_MODULE"] != settings_module
):
    # Se DJANGO_SETTINGS_MODULE è già impostato ma è diverso, aggiorniamo DJANGO_ENV per coerenza
    module_parts = os.environ["DJANGO_SETTINGS_MODULE"].split(".")
    if len(module_parts) >= 3:
        DJANGO_ENV = module_parts[-1]
        print(
            f"DJANGO_ENV aggiornato a '{DJANGO_ENV}' in base a DJANGO_SETTINGS_MODULE",
            file=sys.stderr,
        )

try:
    if DJANGO_ENV == "dev":
        from home.settings.dev import *
    elif DJANGO_ENV == "test":
        from home.settings.test import *
    elif DJANGO_ENV == "prod":
        from home.settings.prod import *
    else:
        from home.settings.dev import *

        print(
            f"Warning: Unknown environment {DJANGO_ENV}, using development settings",
            file=sys.stderr,
        )
except ImportError as e:
    # Fallback alle impostazioni di base in caso di errore
    from home.settings.base import *  # noqa: F401, F403

    print(f"Error loading settings for {DJANGO_ENV}: {e}", file=sys.stderr)
    print("Falling back to base settings", file=sys.stderr)

# Mostra quale file di impostazioni è stato caricato, ma solo quando DEBUG è attivo
# Usiamo locals().get() per evitare l'errore F405 con le importazioni da asterisco
if "DEBUG" in locals() and locals().get("DEBUG", False):
    settings_path = Path(settings_module.replace(".", "/")).with_suffix(".py")
    print(f"Using settings: {settings_path}", file=sys.stderr)

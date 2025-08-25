"""
Check Settings module.

Questo modulo fornisce funzionalità per check settings.
"""

import os
import sys
from pathlib import Path

# Aggiungi il percorso della directory src per importare le impostazioni Django
project_root = Path(__file__).resolve().parent.parent
sys.path.append(str(project_root / "src"))

import django  # noqa: E402
from django.conf import settings  # noqa: E402

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "home.settings")
django.setup()

print(f"Ambiente caricato: {os.environ.get('DJANGO_ENV', 'non impostato')}")
print(f"DEBUG: {settings.DEBUG}")

# Verifica che DATABASES e default siano configurati
if hasattr(settings, "DATABASES") and "default" in settings.DATABASES:
    print(f"DATABASE: {settings.DATABASES['default']['ENGINE']}")
else:
    print("DATABASE: Non configurato")

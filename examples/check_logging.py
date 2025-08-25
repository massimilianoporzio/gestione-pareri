"""
Script di controllo per il sistema di logging.
Questo script verifica quale formatter è attualmente in uso e mostra il colore per ogni livello.
"""

import logging
import os
import sys
from pathlib import Path

# Aggiungi il percorso della directory src per importare le impostazioni Django
project_root = Path(__file__).resolve().parent.parent
sys.path.append(str(project_root / "src"))

# Setup di base per Django (necessario per caricare le impostazioni)
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "home.settings")

# Dobbiamo importare Django dopo aver impostato l'ambiente
# pylint: disable=wrong-import-position
import django
from django.conf import settings

# pylint: enable=wrong-import-position

# Configura Django
django.setup()

# Stampa informazioni sul formatter attualmente in uso
print("\n==== CONFIGURAZIONE LOGGING ====")
console_handler = settings.LOGGING["handlers"]["console"]
formatter_name = console_handler["formatter"]
formatter_config = settings.LOGGING["formatters"].get(formatter_name, {})

print(f"- Formatter in uso: {formatter_name}")
print(f"- Configurazione: {formatter_config}")
print(f"- DEBUG: {settings.DEBUG}")
print(f"- USE_COLORAMA: {getattr(settings, 'USE_COLORAMA', False)}")

# Crea un logger di test
logger = logging.getLogger("test.logging")

print("\n==== TEST LIVELLI DI LOG ====")
print("(Verifica che tutti i seguenti messaggi siano colorati correttamente)")

# Testa tutti i livelli di log
logger.debug("TEST DEBUG - Questo dovrebbe essere CIANO")
logger.info("TEST INFO - Questo dovrebbe essere VERDE")
logger.warning("TEST WARNING - Questo dovrebbe essere GIALLO")
logger.error("TEST ERROR - Questo dovrebbe essere ROSSO")
logger.critical("TEST CRITICAL - Questo dovrebbe essere ROSSO BRILLANTE")

print("\n==== FINE TEST ====")

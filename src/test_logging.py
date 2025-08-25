"""
Script per testare la configurazione di logging nei diversi ambienti.

Uso:
    - DJANGO_ENV=dev python test_logging.py
    - DJANGO_ENV=test python test_logging.py
    - DJANGO_ENV=prod python test_logging.py
    - DJANGO_LOGS_DIR=/percorso/personalizzato DJANGO_ENV=dev python test_logging.py
"""

import logging
import os
import sys
from pathlib import Path

import django

# Prima di configurare Django, controlla le variabili d'ambiente
print("\n=== VERIFICA INIZIALE DELLE VARIABILI D'AMBIENTE ===")
django_env = os.environ.get("DJANGO_ENV", "non impostato")
django_logs_dir = os.environ.get("DJANGO_LOGS_DIR", "non impostato")
print(f"DJANGO_ENV (prima dell'inizializzazione): {django_env}")
print(f"DJANGO_LOGS_DIR (prima dell'inizializzazione): {django_logs_dir}")

# Configurazione di Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "home.settings")
django.setup()

# Importa le impostazioni
from django.conf import settings  # noqa: E402

# Ottieni il logger root
logger = logging.getLogger()

# Ottieni un logger personalizzato
custom_logger = logging.getLogger("custom")


def test_logging():
    """Testa la configurazione di logging."""
    env = os.environ.get("DJANGO_ENV", "non impostato")

    print(f"\n--- Test di logging nell'ambiente: {env} ---")
    print(f"DEBUG: {settings.DEBUG}")

    # Mostra le variabili d'ambiente DJANGO_*
    print("\nVariabili d'ambiente:")
    for key, value in sorted(os.environ.items()):
        if key.startswith("DJANGO_"):
            print(f"  {key} = {value}")

    print(f"\nDJANGO_LOGS_DIR: {os.environ.get('DJANGO_LOGS_DIR', 'non impostato')}")

    # Mostra la configurazione dei logger
    print("\nConfigurazione di logging:")
    print(f"Root logger level: {logger.level}")
    print(f"Root logger handlers: {[h.__class__.__name__ for h in logger.handlers]}")

    django_logger = logging.getLogger("django")
    print(f"Django logger level: {django_logger.level}")
    print(f"Django logger handlers: {[h.__class__.__name__ for h in django_logger.handlers]}")

    # Aggiungi un handler al logger personalizzato
    if not custom_logger.handlers:
        handler = logging.StreamHandler(sys.stdout)
        custom_logger.addHandler(handler)

    # Invia messaggi di log a diversi livelli
    print("\nInvio messaggi di log...")
    custom_logger.debug("Questo è un messaggio di DEBUG")
    custom_logger.info("Questo è un messaggio di INFO")
    custom_logger.warning("Questo è un messaggio di WARNING")
    custom_logger.error("Questo è un messaggio di ERROR")

    logger.debug("Root logger: Questo è un messaggio di DEBUG")
    logger.info("Root logger: Questo è un messaggio di INFO")
    logger.warning("Root logger: Questo è un messaggio di WARNING")
    logger.error("Root logger: Questo è un messaggio di ERROR")

    django_logger.debug("Django logger: Questo è un messaggio di DEBUG")
    django_logger.info("Django logger: Questo è un messaggio di INFO")
    django_logger.warning("Django logger: Questo è un messaggio di WARNING")
    django_logger.error("Django logger: Questo è un messaggio di ERROR")

    print("\nControlla il file di log in ambiente di produzione:")

    # Prima parte: informazioni sulla directory dei log
    try:
        print("\nInformazioni sulla directory dei log:")

        # Mostra informazioni sulla directory dei log configurata in base.py
        if hasattr(settings, "LOGS_DIR_PATH"):
            print(f"LOGS_DIR_PATH da settings: {settings.LOGS_DIR_PATH}")
            print(f"Tipo: {type(settings.LOGS_DIR_PATH)}")

        # Mostra la directory dei log effettiva
        if hasattr(settings, "LOGS_DIR"):
            logs_dir = settings.LOGS_DIR
            print(f"LOGS_DIR da settings: {logs_dir}")
            print(f"Tipo: {type(logs_dir)}")
            print(f"Esiste: {logs_dir.exists()}")
        else:
            # Altrimenti, usa il percorso base del progetto
            base_dir = Path(__file__).resolve().parent.parent
            logs_dir = base_dir / "logs"
            print(f"Directory dei log di fallback: {logs_dir}")
            print(f"Esiste: {logs_dir.exists()}")
    except Exception as e:
        print(f"Errore nell'analisi della directory dei log: {e}")
        logs_dir = Path(__file__).resolve().parent.parent / "logs"

    # Seconda parte: informazioni sul file di log
    try:
        # Verifica il file di log
        log_file = logs_dir / "django.log"
        print(f"File di log: {log_file}")
        print(f"Esiste: {log_file.exists()}")

        # Mostra informazioni sul file di log se in ambiente di produzione
        if env == "prod" and log_file.exists():
            print(f"Dimensione del file di log: {log_file.stat().st_size} bytes")
            try:
                with open(log_file, encoding="utf-8") as f:
                    last_lines = f.readlines()[-10:]  # ultime 10 righe
                    print("\nUltime righe del file di log:")
                    for line in last_lines:
                        print(f"  {line.strip()}")
            except Exception as e:
                print(f"Errore nella lettura del file di log: {e}")
        elif env == "prod":
            print("Il file di log non esiste ancora.")
    except Exception as e:
        print(f"Errore nell'accesso al file di log: {e}")

    print("\n--- Fine del test ---")


if __name__ == "__main__":
    test_logging()

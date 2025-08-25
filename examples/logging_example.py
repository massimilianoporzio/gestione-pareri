"""
Esempio di utilizzo del sistema di logging configurato per Django.
Questo script dimostra come utilizzare i diversi livelli di log disponibili
nel progetto Django configurato con colorlog.

Per eseguire:
1. Usando uv (consigliato): uv run python examples/logging_example.py
2. Usando l'ambiente virtuale:
   - Attiva il virtualenv: .venv/Scripts/activate (Windows) o source .venv/bin/activate (Linux/macOS)
   - Esegui: python examples/logging_example.py

Output atteso in modalità DEBUG (con colori):
+---------------------------------------------------------------------------+
| DEBUG    2025-08-25 16:43:05 examples.logging Questo è un messaggio DEBUG |
| INFO     2025-08-25 16:43:05 examples.logging Questo è un messaggio INFO  |
| WARNING  2025-08-25 16:43:05 examples.logging Questo è un avviso          |
| ERROR    2025-08-25 16:43:05 examples.logging Questo è un errore          |
| CRITICAL 2025-08-25 16:43:05 examples.logging Questo è un errore critico  |
+---------------------------------------------------------------------------+

I livelli hanno colori diversi:
- DEBUG: ciano
- INFO: verde
- WARNING: giallo
- ERROR: rosso
- CRITICAL: sfondo rosso, testo bianco
"""

import logging
import os
import sys
import time
from pathlib import Path

# Aggiungi il percorso della directory src per importare le impostazioni Django
project_root = Path(__file__).resolve().parent.parent
sys.path.append(str(project_root / "src"))

# Setup di base per Django (necessario per caricare le impostazioni)
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "home.settings")

# Dobbiamo importare Django dopo aver impostato l'ambiente
import django  # pylint: disable=wrong-import-position
from django.conf import settings  # pylint: disable=wrong-import-position

# Configura Django
django.setup()

# Ora possiamo usare il sistema di logging configurato in settings.py
logger = logging.getLogger("examples.logging")


def demo_basic_logging():
    """Dimostra i livelli di log di base."""
    print("\n=== Demo livelli di log di base ===")

    logger.debug("Questo è un messaggio di DEBUG - visibile solo in modalità sviluppo")
    logger.info("Questo è un messaggio di INFO - mostra informazioni generali")
    logger.warning("Questo è un messaggio di WARNING - segnala situazioni potenzialmente problematiche")
    logger.error("Questo è un messaggio di ERROR - segnala errori che impediscono il corretto funzionamento")
    logger.critical("Questo è un messaggio di CRITICAL - segnala errori critici che richiedono attenzione immediata")


def demo_exception_logging():
    """Dimostra come registrare eccezioni con traceback completo."""
    print("\n=== Demo logging di eccezioni ===")

    try:
        # Genera un errore di esempio
        _ = 1 / 0  # Errore di divisione per zero
    except ZeroDivisionError:
        # logger.exception include automaticamente il traceback completo
        logger.exception("Errore catturato con traceback completo")


def demo_performance_logging(iterations=1000):
    """Dimostra come registrare metriche di performance."""
    print("\n=== Demo logging di performance ===")

    logger.info("Avvio test di performance con %s iterazioni", iterations)

    start_time = time.time()

    # Simulazione di un'operazione
    total = 0
    for i in range(iterations):
        total += i
        if i % 250 == 0 and i > 0:
            logger.debug("Progresso: %s/%s iterazioni completate", i, iterations)

    elapsed = time.time() - start_time
    logger.info("Test completato in %.4f secondi, risultato: %s", elapsed, total)


def demo_structured_logging():
    """Dimostra come usare il logging strutturato con contesti extra."""
    print("\n=== Demo logging strutturato ===")

    # Aggiungere informazioni extra ai log
    extra = {
        "user_id": 12345,
        "ip_address": "192.168.1.1",
        "action": "login",
    }

    # Usa il parametro extra per aggiungere contesto
    logger.info("Azione utente completata", extra=extra)

    # Esempio con contesto per un'operazione database
    db_extra = {
        "query_time": 0.0532,
        "rows_affected": 10,
        "table": "users",
    }
    logger.info("Query database completata", extra=db_extra)


def print_help():
    """Mostra informazioni su come interpretare l'output."""
    print("\n" + "=" * 70)
    print(" INFORMAZIONI SUL LOGGING ".center(70, "="))
    print("=" * 70)

    print(f"\nDEBUG è {'ATTIVO' if settings.DEBUG else 'DISATTIVATO'}")
    print("- Se DEBUG è ATTIVO: i log colorati appariranno in console")
    print("- Se DEBUG è DISATTIVATO: i log verranno salvati nel file logs/django.log")

    print("\nPer cambiare la modalità DEBUG:")
    print("1. Modifica il file .env e imposta DJANGO_DEBUG=1 o DJANGO_DEBUG=0")
    print("2. Riavvia l'applicazione")

    print("\nPer verificare i log salvati su file:")
    print(f"Controlla il file: {project_root / 'logs' / 'django.log'}")

    print("\n" + "=" * 70 + "\n")


if __name__ == "__main__":
    print_help()

    print("Inizio demo di logging...")
    demo_basic_logging()
    demo_exception_logging()
    demo_performance_logging(500)
    demo_structured_logging()

    print("\nDemo completata! Controlla i log generati.")

    if not django.conf.settings.DEBUG:
        print(f"I log sono stati salvati nel file: {project_root / 'logs' / 'django.log'}")
    else:
        print("I log colorati sono stati mostrati nella console qui sopra.")

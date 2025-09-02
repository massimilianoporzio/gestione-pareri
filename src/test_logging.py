"""Script per testare la configurazione di logging nei diversi ambienti.

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

# Per i test in ambiente di produzione, impostiamo un database SQLite temporaneo
# per evitare di connetterci a PostgreSQL
if django_env == "prod":
    os.environ["DJANGO_TEST_DB"] = "1"  # Segnala che stiamo usando un DB di test

# Configurazione di Django
django_env = os.environ.get("DJANGO_ENV", "dev")
SETTINGS_MODULE = f"home.settings.{django_env}"
os.environ.setdefault("DJANGO_SETTINGS_MODULE", SETTINGS_MODULE)
django.setup()

# Importa le impostazioni
# noqa: E402
# NOSONAR
# @SuppressWarnings("python:S1542")
from django.conf import settings  # noqa: E402

# Ottieni il logger root
logger = logging.getLogger()

# Ottieni un logger personalizzato
custom_logger = logging.getLogger("custom")


def print_environment_info():
    """Stampa le informazioni sull'ambiente di esecuzione."""
    env = os.environ.get("DJANGO_ENV", "non impostato")
    print(f"\n--- Test di logging nell'ambiente: {env} ---")
    print(f"DEBUG: {settings.DEBUG}")

    print("\nVariabili d'ambiente:")
    for key, value in sorted(os.environ.items()):
        if key.startswith("DJANGO_"):
            print(f"  {key} = {value}")

    print(f"\nDJANGO_LOGS_DIR: {os.environ.get('DJANGO_LOGS_DIR', 'non impostato')}")
    return env


def print_logger_configuration():
    """Stampa la configurazione dei logger."""
    print("\nConfigurazione di logging:")
    print(f"Root logger level: {logger.level}")
    print(f"Root logger handlers: {[h.__class__.__name__ for h in logger.handlers]}")

    django_logger = logging.getLogger("django")
    print(f"Django logger level: {django_logger.level}")
    print(f"Django logger handlers: {[h.__class__.__name__ for h in django_logger.handlers]}")
    return django_logger


def setup_custom_logger():
    """Configura il logger personalizzato se necessario."""
    if not custom_logger.handlers:
        handler = logging.StreamHandler(sys.stdout)
        custom_logger.addHandler(handler)


def send_test_messages(django_logger):
    """Invia messaggi di test a tutti i logger."""
    print("\nInvio messaggi di log...")

    # Messaggi al logger personalizzato
    for level, message in [
        ("debug", "Questo è un messaggio di DEBUG"),
        ("info", "Questo è un messaggio di INFO"),
        ("warning", "Questo è un messaggio di WARNING"),
        ("error", "Questo è un messaggio di ERROR"),
    ]:
        getattr(custom_logger, level)("Custom logger: %s", message)

    # Messaggi al root logger
    for level, message in [
        ("debug", "Root logger: Questo è un messaggio di DEBUG"),
        ("info", "Root logger: Questo è un messaggio di INFO"),
        ("warning", "Root logger: Questo è un messaggio di WARNING"),
        ("error", "Root logger: Questo è un messaggio di ERROR"),
    ]:
        getattr(logger, level)(message)

    # Messaggi al django logger
    for level, message in [
        ("debug", "Django logger: Questo è un messaggio di DEBUG"),
        ("info", "Django logger: Questo è un messaggio di INFO"),
        ("warning", "Django logger: Questo è un messaggio di WARNING"),
        ("error", "Django logger: Questo è un messaggio di ERROR"),
    ]:
        getattr(django_logger, level)(message)


def write_production_test_log(env, django_logger):
    """Scrive un log di test specifico per l'ambiente di produzione."""
    if env != "prod":
        return None

    print("\nVerifica della scrittura dei log in ambiente di produzione:")
    test_id = f"test-{os.getpid()}"
    test_message = f"TEST-LOG-ENTRY-{test_id}"
    django_logger.error(test_message)

    import time

    time.sleep(0.5)
    return test_message


def _get_logs_dir_from_settings():
    """Ottiene la directory dei log dalle impostazioni Django."""
    if hasattr(settings, "LOGS_DIR_PATH"):
        print(f"LOGS_DIR_PATH da settings: {settings.LOGS_DIR_PATH}")
        print(f"Tipo: {type(settings.LOGS_DIR_PATH)}")

    if hasattr(settings, "LOGS_DIR"):
        logs_dir = settings.LOGS_DIR
        print(f"LOGS_DIR da settings: {logs_dir}")
        print(f"Tipo: {type(logs_dir)}")
        print(f"Esiste: {logs_dir.exists()}")
        return logs_dir

    return None


def _get_fallback_logs_dir():
    """Ottiene la directory dei log di fallback."""
    base_dir = Path(__file__).resolve().parent.parent
    logs_dir = base_dir / "logs"
    print(f"Directory dei log di fallback: {logs_dir}")
    print(f"Esiste: {logs_dir.exists()}")
    return logs_dir


def get_logs_directory():
    """Ottiene la directory dei log configurata."""
    try:
        print("\nInformazioni sulla directory dei log:")

        # Prova a ottenere dalle impostazioni
        logs_dir = _get_logs_dir_from_settings()
        if logs_dir:
            return logs_dir

        # Directory di fallback
        return _get_fallback_logs_dir()

    except (AttributeError, OSError) as e:
        print(f"Errore nell'analisi della directory dei log: {e}")
        return Path(__file__).resolve().parent.parent / "logs"


def verify_log_file_content(env, logs_dir, test_message):
    """Verifica il contenuto del file di log."""
    try:
        log_file = logs_dir / "django.log"
        print(f"File di log: {log_file}")
        print(f"Esiste: {log_file.exists()}")

        if env == "prod" and log_file.exists() and test_message:
            _check_test_message_in_log(log_file, test_message)
        elif env == "prod":
            print("❌ ERRORE: Il file di log non esiste. Verifica la configurazione!")

    except OSError as e:
        print(f"Errore nell'accesso al file di log: {e}")


def _read_log_file_content(log_file):
    """Legge il contenuto del file di log."""
    try:
        with open(log_file, encoding="utf-8") as f:
            return f.read()
    except OSError as e:
        print(f"Errore nella lettura del file di log: {e}")
        return None


def _verify_message_in_content(log_content, test_message, log_file):
    """Verifica se il messaggio è presente nel contenuto del log."""
    if test_message in log_content:
        print("\n✅ SUCCESSO: Il messaggio di test è stato scritto nel file di log!")
        _show_last_log_lines(log_file)
        return True
    return False


def _handle_message_not_found(log_content):
    """Gestisce il caso in cui il messaggio di test non è stato trovato."""
    print("❌ ERRORE: Il messaggio di test non è stato trovato nel file di log!")
    print("Contenuto parziale del file di log:")
    print(log_content[-500:])


def _check_test_message_in_log(log_file, test_message):
    """Controlla se il messaggio di test è presente nel file di log."""
    import time

    max_attempts = 3
    for attempt in range(max_attempts):
        log_content = _read_log_file_content(log_file)
        if log_content is None:
            break

        if _verify_message_in_content(log_content, test_message, log_file):
            break

        if attempt < max_attempts - 1:
            print(f"Tentativo {attempt + 1}: Messaggio di test non trovato, attendo...")
            time.sleep(1)
        else:
            _handle_message_not_found(log_content)


def _show_last_log_lines(log_file):
    """Mostra le ultime righe del file di log."""
    try:
        with open(log_file, encoding="utf-8") as f:
            last_lines = f.readlines()[-10:]

        print("\nUltime righe del file di log:")
        for line in last_lines:
            print(f"  {line.strip()}")
    except OSError as e:
        print(f"Errore nella lettura delle ultime righe: {e}")


def test_logging():
    """Testa la configurazione di logging."""
    # 1. Informazioni ambiente
    env = print_environment_info()

    # 2. Configurazione logger
    django_logger = print_logger_configuration()

    # 3. Setup logger personalizzato
    setup_custom_logger()

    # 4. Invio messaggi di test
    send_test_messages(django_logger)

    # 5. Test specifico per produzione
    test_message = write_production_test_log(env, django_logger)

    # 6. Verifica directory log
    print("\nControlla il file di log in ambiente di produzione:")
    logs_dir = get_logs_directory()

    # 7. Verifica contenuto file log
    verify_log_file_content(env, logs_dir, test_message)

    print("\n--- Fine del test ---")


if __name__ == "__main__":
    test_logging()

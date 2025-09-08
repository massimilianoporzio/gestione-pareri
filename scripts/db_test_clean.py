#!/usr/bin/env python3
"""
Script per pulizia e ricreazione del database di test PostgreSQL.
Carica le variabili da .env e gestisce drop/create in modo robusto.
"""

import os
import subprocess
import sys
from pathlib import Path

from decouple import Config, RepositoryEnv

# Carica .env dalla root del progetto
ROOT = Path(__file__).parent.parent
ENV_PATH = ROOT / ".env"
if not ENV_PATH.exists():
    print(f"File .env non trovato: {ENV_PATH}")
    sys.exit(1)
config = Config(repository=RepositoryEnv(str(ENV_PATH)))

# Recupera variabili
DB_NAME = config("DB_NAME_TEST", default=None)
DB_USER = config("DB_USER_TEST", default=None)
DB_PASSWORD = config("DB_PASSWORD_TEST", default=None)
DB_HOST = config("DB_HOST", default="localhost")
DB_PORT = config("DB_PORT", default="5432")

if not all([DB_NAME, DB_USER, DB_PASSWORD]):
    print("Variabili DB_NAME_TEST, DB_USER_TEST, DB_PASSWORD_TEST mancanti in .env")
    sys.exit(1)


def run_pg_command(cmd, password):
    """Run pg command.

    Args:
        cmd: Descrizione di cmd
        password: Descrizione di password

    Returns:
        Descrizione del valore restituito
    """
    env = os.environ.copy()
    env["PGPASSWORD"] = password
    try:
        subprocess.run(cmd, env=env, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Comando fallito: {' '.join(cmd)}\n{e}")
        return False
    return True


# Cancella tutti i database che iniziano con test_
print("🗑️  Drop di tutti i database test_*")
psql_cmd = [
    "psql",
    "-U",
    DB_USER,
    "-h",
    DB_HOST,
    "-p",
    DB_PORT,
    "-d",
    "postgres",
    "-tAc",
    "SELECT datname FROM pg_database WHERE datname LIKE 'test_%';",
]
env = os.environ.copy()
env["PGPASSWORD"] = DB_PASSWORD
try:
    result = subprocess.run(
        psql_cmd, env=env, check=True, capture_output=True, text=True
    )
    test_dbs = [db.strip() for db in result.stdout.splitlines() if db.strip()]
    for test_db in test_dbs:
        print(f"🗑️  Drop database: {test_db}")
        drop_cmd = ["dropdb", "-U", DB_USER, "-h", DB_HOST, "-p", DB_PORT, test_db]
        run_pg_command(drop_cmd, DB_PASSWORD)
except Exception as e:
    print(f"Errore durante la ricerca/cancellazione dei database test_: {e}")

print(f"🗑️  Drop database di test: {DB_NAME}")
drop_cmd = ["dropdb", "-U", DB_USER, "-h", DB_HOST, "-p", DB_PORT, DB_NAME]
run_pg_command(drop_cmd, DB_PASSWORD)  # Ignora errori se DB non esiste

print(f"🗄️  Create database di test: {DB_NAME}")
create_cmd = ["createdb", "-U", DB_USER, "-h", DB_HOST, "-p", DB_PORT, DB_NAME]
if not run_pg_command(create_cmd, DB_PASSWORD):
    print("Errore nella creazione del database di test.")
    sys.exit(1)

print("✅ Database di test pulito e ricreato.")

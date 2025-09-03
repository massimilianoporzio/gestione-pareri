#!/usr/bin/env python3
"""Generatore di password sicure per PostgreSQL multi-ambiente.

Questo script genera password sicure per tutti gli ambienti PostgreSQL
del progetto gestione-pareri.
"""

import secrets
import string
import sys
from typing import Tuple


def generate_secure_password(length: int = 32) -> str:
    """Genera una password sicura con caratteri alfanumerici e simboli sicuri.
    
    Args:
        length (int): Lunghezza della password (default: 32)
        
    Returns:
        str: Password sicura generata
    """
    # Caratteri sicuri per PostgreSQL (evita problemi con SQL)
    chars = string.ascii_letters + string.digits + '#$%*+-=?@'
    return ''.join(secrets.choice(chars) for _ in range(length))


def generate_all_passwords() -> Tuple[str, str, str, str]:
    """Genera password per tutti gli ambienti.
    
    Returns:
        Tuple[str, str, str, str]: Password per dev, test, staging, prod
    """
    dev_pwd = generate_secure_password(32)      # 32 caratteri per dev
    test_pwd = generate_secure_password(32)     # 32 caratteri per test  
    staging_pwd = generate_secure_password(36)  # 36 caratteri per staging
    prod_pwd = generate_secure_password(40)     # 40 caratteri per prod
    
    return dev_pwd, test_pwd, staging_pwd, prod_pwd


def print_colored_output():
    """Stampa l'output con colori e formattazione."""
    dev_pwd, test_pwd, staging_pwd, prod_pwd = generate_all_passwords()
    
    print("🔐 Generazione password PostgreSQL sicure...\n")
    print("📋 PASSWORD GENERATE PER POSTGRESQL:")
    print("====================================\n")
    
    print("🔧 DEV Environment:")
    print(f"   Username: gestione_pareri_dev")
    print(f"   Password: {dev_pwd}\n")
    
    print("🧪 TEST Environment:")
    print(f"   Username: gestione_pareri_test") 
    print(f"   Password: {test_pwd}\n")
    
    print("🎭 STAGING Environment:")
    print(f"   Username: gestione_pareri_staging") 
    print(f"   Password: {staging_pwd}\n")
    
    print("🚀 PROD Environment:")
    print(f"   Username: gestione_pareri_prod")
    print(f"   Password: {prod_pwd}\n")
    
    print("📝 COMANDI SQL PER APPLICARE LE PASSWORD:")
    print("==========================================")
    print(f"ALTER USER gestione_pareri_dev WITH PASSWORD '{dev_pwd}';")
    print(f"ALTER USER gestione_pareri_test WITH PASSWORD '{test_pwd}';")
    print(f"ALTER USER gestione_pareri_staging WITH PASSWORD '{staging_pwd}';")
    print(f"ALTER USER gestione_pareri_prod WITH PASSWORD '{prod_pwd}';\n")
    
    print("💡 CONFIGURAZIONE .env:")
    print("======================")
    print(f"DB_PASSWORD_DEV={dev_pwd}")
    print(f"DB_PASSWORD_TEST={test_pwd}")
    print(f"DB_PASSWORD_STAGING={staging_pwd}")
    print(f"DB_PASSWORD_PROD={prod_pwd}\n")
    
    print("⚠️  IMPORTANTE: Salva queste password in modo sicuro!")
    print("📖 Vedi docs/database-setup.md per configurazione completa")


def main():
    """Funzione principale."""
    try:
        print_colored_output()
    except Exception as e:
        print(f"❌ Errore nella generazione delle password: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()

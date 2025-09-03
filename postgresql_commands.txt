# Comandi PostgreSQL per Setup Multi-Ambiente
# Guida per configurare PostgreSQL con 4 ambienti (dev, test, staging, prod)

# 1. CONNETTITI A POSTGRESQL
psql -U postgres -h localhost

# 2. AGGIORNA PASSWORD ESISTENTI (usa le password dal comando: just generate-db-passwords)

# DEV password (sostituisci YOUR_DEV_PASSWORD con la password generata):
ALTER USER gestione_pareri_dev WITH PASSWORD 'YOUR_DEV_PASSWORD';

# TEST password (sostituisci YOUR_TEST_PASSWORD con la password generata):
ALTER USER gestione_pareri_test WITH PASSWORD 'YOUR_TEST_PASSWORD';

# PROD password (sostituisci YOUR_PROD_PASSWORD con la password generata):
ALTER USER gestione_pareri_prod WITH PASSWORD 'YOUR_PROD_PASSWORD';

# 3. CREA UTENTE STAGING (sostituisci YOUR_STAGING_PASSWORD con la password generata)
CREATE USER gestione_pareri_staging WITH 
    PASSWORD 'YOUR_STAGING_PASSWORD'
    CREATEDB
    NOSUPERUSER
    NOCREATEROLE;

# 4. CREA DATABASE STAGING
CREATE DATABASE gestione_pareri_staging 
    OWNER gestione_pareri_staging
    ENCODING 'UTF8'
    TEMPLATE template0;

# 5. ASSEGNA PERMESSI
GRANT ALL PRIVILEGES ON DATABASE gestione_pareri_staging TO gestione_pareri_staging;

# 6. VERIFICA RISULTATO
-- Lista tutti gli utenti
\du+

-- Lista database del progetto
SELECT datname as "Database", datowner::regrole as "Owner"
FROM pg_database 
WHERE datname LIKE 'gestione_pareri%'
ORDER BY datname;

# 7. ESCI DA PSQL
\q

# NOTE:
# - Le password vengono generate con: just generate-db-passwords
# - Configurazione .env viene aggiornata automaticamente
# - Vedi docs/database-setup.md per dettagli completi

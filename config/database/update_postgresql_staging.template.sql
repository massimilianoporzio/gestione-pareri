-- Template SQL per aggiornare PostgreSQL con ambiente STAGING
-- QUESTO FILE È UN TEMPLATE - NON CONTIENE PASSWORD REALI
--
-- Per usare questo template:
-- 1. Copia questo file: copy update_postgresql_staging.template.sql update_postgresql_staging.sql
-- 2. Sostituisci i placeholder YOUR_*_PASSWORD con le password generate da: just generate-db-passwords
-- 3. Esegui: psql -U postgres -h localhost -f update_postgresql_staging.sql

\echo 'Aggiornamento PostgreSQL per ambiente STAGING...'
\echo '=================================================='

-- 1. AGGIORNA PASSWORD ESISTENTI
\echo 'Aggiornamento password esistenti...'

-- DEV password (sostituisci YOUR_DEV_PASSWORD)
ALTER USER gestione_pareri_dev WITH PASSWORD 'YOUR_DEV_PASSWORD';

-- TEST password (sostituisci YOUR_TEST_PASSWORD)
ALTER USER gestione_pareri_test WITH PASSWORD 'YOUR_TEST_PASSWORD';

-- PROD password (sostituisci YOUR_PROD_PASSWORD)
ALTER USER gestione_pareri_prod WITH PASSWORD 'YOUR_PROD_PASSWORD';

\echo 'Password esistenti aggiornate OK'

-- 2. CREA NUOVO UTENTE STAGING
\echo 'Creazione utente staging...'

-- STAGING password (sostituisci YOUR_STAGING_PASSWORD)
CREATE USER gestione_pareri_staging WITH
    PASSWORD 'YOUR_STAGING_PASSWORD'
    CREATEDB
    NOSUPERUSER
    NOCREATEROLE;

\echo 'Utente staging creato OK'

-- 3. CREA NUOVO DATABASE STAGING
\echo 'Creazione database staging...'

CREATE DATABASE gestione_pareri_staging
    OWNER gestione_pareri_staging
    ENCODING 'UTF8'
    TEMPLATE template0;

\echo 'Database staging creato OK'

-- 4. ASSEGNA PERMESSI STAGING
\echo 'Assegnazione permessi staging...'

GRANT ALL PRIVILEGES ON DATABASE gestione_pareri_staging TO gestione_pareri_staging;

\echo 'Permessi staging assegnati OK'

-- 5. VERIFICA FINALE
\echo ''
\echo 'Verifica configurazione finale:'
\echo '==============================='

\echo 'Utenti PostgreSQL:'
SELECT usename as "Username",
       usecreatedb as "Can Create DB",
       usesuper as "Superuser"
FROM pg_user
WHERE usename LIKE 'gestione_pareri%'
ORDER BY usename;

\echo ''
\echo 'Database PostgreSQL:'
SELECT datname as "Database",
       datowner::regrole as "Owner"
FROM pg_database
WHERE datname LIKE 'gestione_pareri%'
ORDER BY datname;

\echo ''
\echo 'Setup PostgreSQL completato!'
\echo 'Ora hai 4 ambienti:'
\echo '- DEV:     gestione_pareri_dev'
\echo '- TEST:    gestione_pareri_test'
\echo '- STAGING: gestione_pareri_staging'
\echo '- PROD:    gestione_pareri_prod'

-- IMPORTANTE: Ricorda di eliminare questo file dopo l'uso se contiene password reali!

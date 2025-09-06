# ❓ FAQ

**Come configuro PostgreSQL per tutti gli ambienti?**
Consulta la guida [Environments Guide](environments-guide.md) e usa i comandi just.

**Come gestisco le password?**
Usa sempre `just generate-db-passwords` e salva solo in `.env`.

# 🔗 Cross-link documentazione

Consulta anche:

- [Environments Guide](environments-guide.md)
- [Database Security](database-security.md)

# 🗄️ Setup PostgreSQL Multi-Ambiente (DEV, TEST, STAGING, PROD)

Questa sezione spiega come creare utenti e database separati per ciascun ambiente del progetto, con
i permessi corretti per lo sviluppo e il testing.

## 1. Creazione utenti e database

Accedi a PostgreSQL come superuser (ad esempio il tuo utente macOS con permessi Superuser):

```sh
psql -U massi -d gestione_pareri_dev
```

Esegui questi comandi per ogni ambiente (sostituisci le password con quelle generate):

```sql
-- DEV
CREATE USER gestione_pareri_dev WITH PASSWORD 'YOUR_DEV_PASSWORD' CREATEDB;
CREATE DATABASE gestione_pareri_dev OWNER gestione_pareri_dev ENCODING 'UTF8' TEMPLATE template0;

-- TEST
CREATE USER gestione_pareri_test WITH PASSWORD 'YOUR_TEST_PASSWORD' CREATEDB;
CREATE DATABASE gestione_pareri_test OWNER gestione_pareri_test ENCODING 'UTF8' TEMPLATE template0;

-- STAGING
CREATE USER gestione_pareri_staging WITH PASSWORD 'YOUR_STAGING_PASSWORD' CREATEDB;
CREATE DATABASE gestione_pareri_staging OWNER gestione_pareri_staging ENCODING 'UTF8' TEMPLATE template0;

-- PROD
CREATE USER gestione_pareri_prod WITH PASSWORD 'YOUR_PROD_PASSWORD' CREATEDB;
CREATE DATABASE gestione_pareri_prod OWNER gestione_pareri_prod ENCODING 'UTF8' TEMPLATE template0;
```

## 2. Assegna permessi di creazione database

```sql
ALTER USER gestione_pareri_dev CREATEDB;
ALTER USER gestione_pareri_test CREATEDB;
ALTER USER gestione_pareri_staging CREATEDB;
ALTER USER gestione_pareri_prod CREATEDB;
```

## 3. Verifica utenti e database

```sql
\du      -- Mostra utenti e permessi
\l       -- Mostra database
```

## 4. Note

- Le password possono essere generate con `just generate-db-passwords`.
- Aggiorna la configurazione `.env` per ogni ambiente con i dati corretti.
- I permessi `CREATEDB` sono necessari per eseguire i test Django.

# 🗄️ Database Setup - PostgreSQL Multi-Ambiente

Guida completa per configurare PostgreSQL per tutti gli ambienti del progetto **gestione-pareri**.

## 📋 Indice

- [🛠️ Setup Iniziale](#️-setup-iniziale)
- [🔐 Configurazione Sicurezza](#-configurazione-sicurezza)
- [🌍 Configurazione Multi-Ambiente](#-configurazione-multi-ambiente)
- [🔧 Configurazione Django](#-configurazione-django)
- [📊 Testing e Verifica](#-testing-e-verifica)
- [🚨 Troubleshooting](#-troubleshooting)

## 🛠️ Setup Iniziale

### Prerequisiti

- PostgreSQL 13+ installato
- Accesso come superuser `postgres`
- psql client configurato

### 1. Connessione PostgreSQL

```bash
# Windows
psql -U postgres -h localhost
# Se hai problemi di encoding (Windows)
chcp 1252
psql -U postgres -h localhost
```

### 2. Pulizia Database Esistenti (Se Necessario)

```sql
-- Disconnetti connessioni attive
SELECT pg_terminate_backend(pid) FROM pg_stat_activity
WHERE datname IN ('old_database_name') AND pid <> pg_backend_pid();
-- Rimuovi vecchi database e utenti
DROP DATABASE IF EXISTS old_database_name;
DROP USER IF EXISTS old_user_name;
```

## 🔐 Configurazione Sicurezza

### 1. Generazione Password Sicure

Usa il comando Just per generare password sicure:

```bash
just generate-db-passwords
```

Questo comando genera:

- Password di 32 caratteri per DEV/TEST
- Password di 40 caratteri per PROD
- Comandi SQL pronti per l'uso
- Configurazione .env template

### 2. Caratteristiche Password Generate

- **Caratteri speciali sicuri**: `#$%*+-=?@`
- **Lunghezza variabile**: 32 (dev/test), 40 (prod)
- **Mix completo**: maiuscole, minuscole, numeri, simboli
- **SQL-safe**: Evita caratteri che causano problemi in SQL

## 🌍 Configurazione Multi-Ambiente

### 1. Creazione Database e Utenti

```sql
-- 1. Crea utenti per ogni ambiente
CREATE USER gestione_pareri_dev WITH PASSWORD 'password_generata_dev';
CREATE USER gestione_pareri_test WITH PASSWORD 'password_generata_test';
CREATE USER gestione_pareri_prod WITH PASSWORD 'password_generata_prod';
-- 2. Crea database per ogni ambiente
CREATE DATABASE gestione_pareri_dev OWNER gestione_pareri_dev;
CREATE DATABASE gestione_pareri_test OWNER gestione_pareri_test;
CREATE DATABASE gestione_pareri_prod OWNER gestione_pareri_prod;
-- 3. Concedi privilegi completi
GRANT ALL PRIVILEGES ON DATABASE gestione_pareri_dev TO gestione_pareri_dev;
GRANT ALL PRIVILEGES ON DATABASE gestione_pareri_test TO gestione_pareri_test;
GRANT ALL PRIVILEGES ON DATABASE gestione_pareri_prod TO gestione_pareri_prod;
```

### 2. Configurazioni Sicurezza Produzione

```sql
-- Limita connessioni simultanee per produzione
ALTER USER gestione_pareri_prod CONNECTION LIMIT 20;
-- Imposta scadenza password (opzionale)
ALTER USER gestione_pareri_prod VALID UNTIL '2025-12-31';
-- Verifica configurazione
\du+
```

### 3. Struttura Database Risultante

| Ambiente        | Database                  | Utente                    | Scopo               |
| --------------- | ------------------------- | ------------------------- | ------------------- |
| **Development** | `gestione_pareri_dev`     | `gestione_pareri_dev`     | Sviluppo locale     |
| **Test**        | `gestione_pareri_test`    | `gestione_pareri_test`    | Test automatizzati  |
| **Staging**     | `gestione_pareri_staging` | `gestione_pareri_staging` | Pre-produzione/UAT  |
| **Production**  | `gestione_pareri_prod`    | `gestione_pareri_prod`    | Ambiente produzione |

## 🔧 Configurazione Django

### 1. File .env

Crea/aggiorna il file `.env` nella root del progetto:

```bash
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
# Password generate con: just generate-db-passwords
DB_PASSWORD_DEV=your_generated_dev_password
DB_PASSWORD_TEST=your_generated_test_password
DB_PASSWORD_STAGING=your_generated_staging_password
DB_PASSWORD_PROD=your_generated_prod_password
# Database Names
DB_NAME_DEV=gestione_pareri_dev
DB_NAME_TEST=gestione_pareri_test
DB_NAME_STAGING=gestione_pareri_staging
DB_NAME_PROD=gestione_pareri_prod
# Database Users
DB_USER_DEV=gestione_pareri_dev
DB_USER_TEST=gestione_pareri_test
DB_USER_STAGING=gestione_pareri_staging
DB_USER_PROD=gestione_pareri_prod
# Switches per PostgreSQL per ambiente
USE_POSTGRESQL_DEV=0          # SQLite per dev rapido
USE_POSTGRESQL_TEST=0         # SQLite per test veloci
USE_POSTGRESQL_STAGING=1      # PostgreSQL obbligatorio
USE_POSTGRESQL_PROD=1         # PostgreSQL obbligatorio
```

### 2. Settings Django

Le configurazioni database sono già impostate in:

- **`src/home/settings/dev.py`**: SQLite/PostgreSQL switchable per sviluppo
- **`src/home/settings/test.py`**: Database in memoria/PostgreSQL per test
- **`src/home/settings/staging.py`**: PostgreSQL per pre-produzione
- **`src/home/settings/prod.py`**: PostgreSQL per produzione

### Struttura degli Ambienti

- **DEV**: SQLite di default per sviluppo rapido (switch a PostgreSQL con `USE_POSTGRESQL_DEV=1`)
- **TEST**: SQLite di default per test veloci (switch a PostgreSQL con `USE_POSTGRESQL_TEST=1`)
- **STAGING**: PostgreSQL obbligatorio per simulare produzione
- **PROD**: PostgreSQL obbligatorio per ambiente live
  > 📖 **Per una spiegazione dettagliata** di cosa serve ogni ambiente e quando usarlo, consulta la
  > [Guida agli Ambienti](environments-guide.md).

### 3. Installazione Driver PostgreSQL

```bash
# Installa psycopg2 (già incluso in pyproject.toml)
uv add psycopg2-binary
```

### 4. Migrazioni Database

```bash
# Ambiente DEV
just migrate-dev
# Ambiente TEST
just migrate-test
# Ambiente PROD
just migrate-prod
```

## 📊 Testing e Verifica

### 1. Test Connessioni Database

```bash
# Test tutti gli ambienti
just check-env-dev
just check-env-test
just check-env-prod
```

### 2. Verifica Manuale PostgreSQL

```sql
-- Connettiti a ogni database e verifica
\c gestione_pareri_dev
\dt  -- Mostra tabelle
\c gestione_pareri_test
\dt
\c gestione_pareri_prod
\dt
```

### 3. Test Django

```bash
# Test connection Django
uv run src/manage.py check --database default
uv run src/manage.py dbshell  # Accesso diretto al database
```

## 🚨 Troubleshooting

### Problema: Connessione Rifiutata

```bash
# Verifica servizio PostgreSQL
Get-Service postgresql*  # Windows
sudo systemctl status postgresql  # Linux
```

### Problema: Password Errata

```sql
-- Reset password utente
ALTER USER gestione_pareri_dev WITH PASSWORD 'new_password';
```

### Problema: Permessi Database

```sql
-- Concedi tutti i privilegi
GRANT ALL PRIVILEGES ON DATABASE gestione_pareri_dev TO gestione_pareri_dev;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO gestione_pareri_dev;
```

### Problema: Encoding

```sql
-- Verifica encoding database
SELECT datname, encoding, datcollate, datctype FROM pg_database;
```

## 📚 Comandi Utili

### Just Commands

```bash
# Password sicure
just generate-db-passwords
# Migrazioni per ambiente
just migrate-dev
just migrate-test
just migrate-prod
# Test ambienti
just check-env-dev
just check-env-test
just check-env-prod
```

### PostgreSQL Commands

```sql
-- Info database
\l                          -- Lista database
\du                         -- Lista utenti
\c database_name            -- Cambia database
\dt                         -- Lista tabelle
\q                          -- Esci da psql
-- Monitoring
SELECT * FROM pg_stat_activity;  -- Connessioni attive
SELECT version();                -- Versione PostgreSQL
```

## 🔒 Best Practices Sicurezza

1. **Password**: Usa sempre `just generate-db-passwords` per password sicure
2. **Environment**: Mai password hardcoded nel codice, sempre via `.env`
3. **Produzione**: Limita connessioni e imposta scadenze password
4. **Backup**: Configura backup automatici per produzione
5. **Network**: Limita accesso rete per database produzione
6. **Monitoring**: Configura alerting per connessioni database

---

## 📖 Riferimenti

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Django Database Configuration](https://docs.djangoproject.com/en/stable/ref/settings/#databases)
- [psycopg2 Documentation](https://www.psycopg.org/docs/)

---

**🔄 Ultimo aggiornamento**: Settembre 2025 **📝 Autore**: Sistema di template Django Deploy

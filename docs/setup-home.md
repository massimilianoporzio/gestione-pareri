# 🏠 Setup Completo da Casa - Windows/macOS

Guida per configurare il progetto da casa con tutti i 4 ambienti (dev, test, staging, prod).

## 📋 Prerequisiti

### Installa Just (Task Runner)
```bash
# Windows
scoop install just
# oppure
choco install just

# macOS  
brew install just

# Linux
sudo apt install just
# oppure
cargo install just
```

### Installa uv (Python Package Manager)
```bash
# Windows
curl -LsSf https://astral.sh/uv/install.ps1 | powershell

# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 🚀 Setup Rapido (One-Liner)

```bash
# Clone + Setup automatico completo
git clone https://github.com/massimilianoporzio/gestione-pareri.git && \
cd gestione-pareri && \
uv sync && \
just setup-all-environments && \
echo "✅ Setup completato per tutti e 4 gli ambienti!"
```

## 🔑 Configurazione Password - 4 Ambienti

### Setup Automatico (Raccomandato)
```bash
cd gestione-pareri

# Genera tutto automaticamente
just setup-all-environments

# Verifica configurazioni
just check-env-dev
just check-env-test  
just check-env-staging
just check-env-prod
```

### Setup Manuale
```bash
# 1. Genera SECRET_KEY per tutti gli ambienti
just generate-secret-keys-all

# 2. Genera password database sicure
just generate-db-passwords

# 3. Setup credentials
just setup-credentials
```

## 🗄️ Database Setup

### Opzione A: Docker (Più Semplice)

```bash
# DEV Environment (porta 5432)
docker run --name gestione-pareri-dev \
  -e POSTGRES_DB=gestione_pareri_dev \
  -e POSTGRES_USER=gestione_pareri_dev \
  -e POSTGRES_PASSWORD=$(grep DB_PASSWORD .env.dev | cut -d'=' -f2) \
  -p 5432:5432 \
  -d postgres:15

# TEST Environment (porta 5433)  
docker run --name gestione-pareri-test \
  -e POSTGRES_DB=gestione_pareri_test \
  -e POSTGRES_USER=gestione_pareri_test \
  -e POSTGRES_PASSWORD=$(grep DB_PASSWORD .env.test | cut -d'=' -f2) \
  -p 5433:5432 \
  -d postgres:15

# STAGING Environment (porta 5434)
docker run --name gestione-pareri-staging \
  -e POSTGRES_DB=gestione_pareri_staging \
  -e POSTGRES_USER=gestione_pareri_staging \
  -e POSTGRES_PASSWORD=$(grep DB_PASSWORD .env.staging | cut -d'=' -f2) \
  -p 5434:5432 \
  -d postgres:15

# PROD Environment (porta 5435)
docker run --name gestione-pareri-prod \
  -e POSTGRES_DB=gestione_pareri_prod \
  -e POSTGRES_USER=gestione_pareri_prod \
  -e POSTGRES_PASSWORD=$(grep DB_PASSWORD .env.prod | cut -d'=' -f2) \
  -p 5435:5432 \
  -d postgres:15
```

### Opzione B: PostgreSQL Nativo

#### Windows
```powershell
# Avvia PostgreSQL
net start postgresql-x64-15

# Crea database per tutti gli ambienti
psql -U postgres -c "
CREATE USER gestione_pareri_dev WITH PASSWORD '$(grep DB_PASSWORD .env.dev | cut -d'=' -f2)';
CREATE DATABASE gestione_pareri_dev OWNER gestione_pareri_dev;
CREATE USER gestione_pareri_test WITH PASSWORD '$(grep DB_PASSWORD .env.test | cut -d'=' -f2)';
CREATE DATABASE gestione_pareri_test OWNER gestione_pareri_test;
CREATE USER gestione_pareri_staging WITH PASSWORD '$(grep DB_PASSWORD .env.staging | cut -d'=' -f2)';
CREATE DATABASE gestione_pareri_staging OWNER gestione_pareri_staging;
CREATE USER gestione_pareri_prod WITH PASSWORD '$(grep DB_PASSWORD .env.prod | cut -d'=' -f2)';
CREATE DATABASE gestione_pareri_prod OWNER gestione_pareri_prod;
"
```

#### macOS
```bash
# Avvia PostgreSQL
brew services start postgresql@15

# Crea database per tutti gli ambienti
for env in dev test staging prod; do
  password=$(grep DB_PASSWORD .env.$env | cut -d'=' -f2)
  createuser gestione_pareri_$env
  createdb -O gestione_pareri_$env gestione_pareri_$env
  psql -d gestione_pareri_$env -c "ALTER USER gestione_pareri_$env WITH PASSWORD '$password';"
done
```

## 🛠️ Setup Django per Tutti gli Ambienti

```bash
# Migrazioni
just migrate-dev
just migrate-test
just migrate-staging
just migrate-prod

# Crea superuser
just createsuperuser-dev
just createsuperuser-test
just createsuperuser-staging
just createsuperuser-prod

# Inizializza gruppi/permessi
just init-groups-dev
just init-groups-test
just init-groups-staging
just init-groups-prod

# File statici
just collectstatic-dev
just collectstatic-prod
```

## 🧪 Test Ambienti

```bash
# Avvia server per ogni ambiente
just run-dev        # http://localhost:8000 (sviluppo)
just run-test       # Test automatici
just run-staging    # http://localhost:8002 (pre-produzione)
just run-prod       # http://localhost:8003 (produzione)

# Test qualità
just test-quick
just lint-codacy
just test-pre-deploy
```

## 📋 Comandi Just Utili

```bash
# Lista tutti i comandi disponibili
just --list

# Setup e configurazione
just setup-all-environments     # Setup completo
just generate-secret-keys-all   # Genera SECRET_KEY
just generate-db-passwords      # Genera password DB
just setup-credentials          # Setup credenziali

# Database
just migrate-{env}              # Migrazioni per ambiente
just createsuperuser-{env}      # Crea superuser
just init-groups-{env}          # Inizializza gruppi

# Server e deploy
just run-{env}                  # Avvia server ambiente
just deploy-{env}               # Deploy ambiente
just test-{env}                 # Test ambiente

# Qualità codice
just fix-all                    # Correzioni automatiche
just lint-codacy               # Controlli qualità
just add-docstrings            # Aggiungi docstring

# Utility
just check-env-{env}           # Verifica configurazione
just stats                     # Statistiche progetto
just kill-port                 # Termina processi porta 8000
```

## 🔍 Verifica Setup

```bash
# Controlla che tutto funzioni
just test-quick                # Test rapidi
just test-health              # Health check
just check-env-dev            # Verifica ambiente DEV

# Controlla password diverse per ogni ambiente
grep SECRET_KEY .env.dev .env.test .env.staging .env.prod
grep DB_PASSWORD .env.dev .env.test .env.staging .env.prod
```

## 🎯 Struttura File Ambiente

Dopo il setup avrai:
```
.env.dev      # Sviluppo - DEBUG=True, database locale
.env.test     # Test automatici - SQLite in memoria  
.env.staging  # Pre-produzione - Come prod ma separato
.env.prod     # Produzione - DEBUG=False, sicurezza massima
```

## 🚨 Note Importanti

1. **Non committare mai i file .env** (sono in .gitignore)
2. **Ogni ambiente ha password diverse** generate automaticamente
3. **TEST usa SQLite** per velocità nei test
4. **PROD ha sicurezza massima** configurata
5. **Docker containers usano porte diverse** per isolamento

## 🆘 Troubleshooting

```bash
# Problemi connessione database
just check-env-dev
uv run python src/manage.py dbshell --settings=home.settings.dev

# Reset database se necessario  
docker rm -f gestione-pareri-dev
# Poi ricrea il container

# Verifica Docker containers
docker ps -a
docker logs gestione-pareri-dev

# Reset completo progetto
git clean -fd
uv sync
just setup-all-environments
```

---

**✅ Con questo setup avrai 4 ambienti completamente isolati e funzionanti!**


# Configura shell per Windows
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Variabili globali
python := "uv run"
django_manage := "uv run src/manage.py"



# Deploy Django Template - Comandi disponibili con Just
# Per visualizzare tutti i comandi: just --list o just



default:
    just default-{{os()}}

@default-linux:
    just default-macos

default-macos:
    @ printf "\033[35m🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI\033[0m\n";
    @ printf "\033[90m============================================================\033[0m\n";
    @ printf "\n";
    @ printf "\033[32m📊 DJANGO & DATABASE:\033[0m\n";
    @ printf "\033[32m  just run-server         🚀 Server di sviluppo Django\033[0m\n";
    @ printf "\033[32m  just run-dev            🔧 Server sviluppo (DEV)\033[0m\n";
    @ printf "\033[32m  just run-test           🧪 Server sviluppo (TEST)\033[0m\n";
    @ printf "\033[32m  just run-staging        🎭 Server sviluppo (STAGING)\033[0m\n";
    @ printf "\033[32m  just run-prod           ⚡ Server sviluppo (PROD)\033[0m\n";
    @ printf "\033[32m  just migrate            📦 Migrazioni database\033[0m\n";
    @ printf "\033[32m  just makemigrations     📝 Crea migrazioni\033[0m\n";
    @ printf "\033[32m  just shell              🐚 Shell Django\033[0m\n";
    @ printf "\033[32m  just test               🧪 Esegue test progetto\033[0m\n";
    @ printf "\033[32m  just test-dev           🔧 Test ambiente DEV\033[0m\n";
    @ printf "\033[32m  just test-test          🧪 Test ambiente TEST\033[0m\n";
    @ printf "\033[32m  just test-staging       🎭 Test ambiente STAGING\033[0m\n";
    @ printf "\033[32m  just test-prod          ⚡ Test ambiente PROD\033[0m\n";
    @ printf "\n";
    @ printf "\033[36m🌐 SERVER & DEPLOY:\033[0m\n";
    @ printf "\033[36m  just waitress           🪟 Server Waitress (Windows)\033[0m\n";
    @ printf "\033[36m  just run-uvicorn        ⚡ Server Uvicorn ASGI\033[0m\n";
    @ printf "\033[36m  just deploy             🎯 Deploy automatico\033[0m\n";
    @ printf "\033[36m  just deploy-dev         🔧 Deploy development\033[0m\n";
    @ printf "\033[36m  just deploy-staging     🧪 Deploy staging\033[0m\n";
    @ printf "\033[36m  just deploy-prod        🚀 Deploy production\033[0m\n";
    @ printf "\033[36m  just stop-servers       🛑 Ferma tutti i server\033[0m\n";
    @ printf "\033[36m  just kill-port          🔪 Termina processo porta 8000\033[0m\n";
    @ printf "\n";
    @ printf "\033[33m🔧 QUALITY & FORMAT:\033[0m\n";
    @ printf "\033[33m  just fix-all            ⭐ CORREZIONE GLOBALE completa\033[0m\n";
    @ printf "\033[33m  just lint-codacy        🔍 Controlli qualità Codacy\033[0m\n";
    @ printf "\033[33m  just add-docstrings     📝 Aggiunge docstring mancanti\033[0m\n";
    @ printf "\033[33m  just precommit-corporate 🏢 Pre-commit aziendale\033[0m\n";
    @ printf "\033[33m  just quality-corporate  🏢 Quality controlli alternativi\033[0m\n";
    @ printf "\033[33m  just fix-markdown       📝 Corregge problemi Markdown\033[0m\n";
    @ printf "\n";
    @ printf "\033[97mℹ️  UTILITY:\033[0m\n";
    @ printf "\033[97m  just stats              📊 Statistiche progetto\033[0m\n";
    @ printf "\033[97m  just check-env          🔍 Controllo ambiente\033[0m\n";
    @ printf "\033[97m  just check-env-dev      🔍 Controllo ambiente DEV\033[0m\n";

default-windows:
    @Write-Host "🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI" -ForegroundColor Magenta;
    @Write-Host "============================================================" -ForegroundColor Gray;
    @Write-Host "";
    @Write-Host "📊 DJANGO & DATABASE:" -ForegroundColor Green;
    @Write-Host "  just run-server         🚀 Server di sviluppo Django" -ForegroundColor Green;
    @Write-Host "  just run-dev            🔧 Server sviluppo (DEV)" -ForegroundColor Green;
    @Write-Host "  just run-test           🧪 Server sviluppo (TEST)" -ForegroundColor Green;
    @Write-Host "  just run-staging        🎭 Server sviluppo (STAGING)" -ForegroundColor Green;
    @Write-Host "  just run-prod           ⚡ Server sviluppo (PROD)" -ForegroundColor Green;
    @Write-Host "  just migrate            📦 Migrazioni database" -ForegroundColor Green;
    @Write-Host "  just makemigrations     📝 Crea migrazioni" -ForegroundColor Green;
    @Write-Host "  just shell              🐚 Shell Django" -ForegroundColor Green;
    @Write-Host "  just test               🧪 Esegue test progetto" -ForegroundColor Green;
    @Write-Host "  just test-dev           🔧 Test ambiente DEV" -ForegroundColor Green;
    @Write-Host "  just test-test          🧪 Test ambiente TEST" -ForegroundColor Green;
    @Write-Host "  just test-staging       🎭 Test ambiente STAGING" -ForegroundColor Green;
    @Write-Host "  just test-prod          ⚡ Test ambiente PROD" -ForegroundColor Green;
    @Write-Host "";
    @Write-Host "🌐 SERVER & DEPLOY:" -ForegroundColor Cyan;
    @Write-Host "  just waitress           🪟 Server Waitress (Windows)" -ForegroundColor Cyan;
    @Write-Host "  just run-uvicorn        ⚡ Server Uvicorn ASGI" -ForegroundColor Cyan;
    @Write-Host "  just deploy             🎯 Deploy automatico" -ForegroundColor Cyan;
    @Write-Host "  just deploy-dev         🔧 Deploy development" -ForegroundColor Cyan;
    @Write-Host "  just deploy-staging     🧪 Deploy staging" -ForegroundColor Cyan;
    @Write-Host "  just deploy-prod        🚀 Deploy production" -ForegroundColor Cyan;
    @Write-Host "  just stop-servers       🛑 Ferma tutti i server" -ForegroundColor Cyan;
    @Write-Host "  just kill-port          🔪 Termina processo porta 8000" -ForegroundColor Cyan;
    @Write-Host "";
    @Write-Host "🔧 QUALITY & FORMAT:" -ForegroundColor Yellow;
    @Write-Host "  just fix-all            ⭐ CORREZIONE GLOBALE completa" -ForegroundColor Yellow;
    @Write-Host "  just lint-codacy        🔍 Controlli qualità Codacy" -ForegroundColor Yellow;
    @Write-Host "  just add-docstrings     📝 Aggiunge docstring mancanti" -ForegroundColor Yellow;
    @Write-Host "  just precommit-corporate 🏢 Pre-commit aziendale" -ForegroundColor Yellow;
    @Write-Host "  just quality-corporate  🏢 Quality controlli alternativi" -ForegroundColor Yellow;
    @Write-Host "  just fix-markdown       📝 Corregge problemi Markdown" -ForegroundColor Yellow;
    @Write-Host "";
    @Write-Host "ℹ️  UTILITY:" -ForegroundColor White;
    @Write-Host "  just stats              📊 Statistiche progetto" -ForegroundColor White;
    @Write-Host "  just check-env          🔍 Controllo ambiente" -ForegroundColor White;
    @Write-Host "  just check-env-dev      🔍 Controllo ambiente DEV" -ForegroundColor White;
    @Write-Host "  just check-env-test     🧪 Controllo ambiente TEST" -ForegroundColor White;
    @Write-Host "  just check-env-staging  🎭 Controllo ambiente STAGING" -ForegroundColor White;
    @Write-Host "  just check-env-prod     ⚡ Controllo ambiente PROD" -ForegroundColor White;
    @Write-Host "  just generate-secret-key 🔑 Genera Django SECRET_KEY" -ForegroundColor White;
    @Write-Host "  just generate-secret-keys-all 🔐 Genera SECRET_KEY per tutti e 4 gli ambienti" -ForegroundColor White;
    @Write-Host "  just generate-db-passwords 🔐 Genera password PostgreSQL sicure" -ForegroundColor White;
    @Write-Host "  just create-db-script   🗄️ Crea script SQL con password reali" -ForegroundColor White;
    @Write-Host "  just --list             📋 Lista completa comandi" -ForegroundColor White;
    @Write-Host "";
    @Write-Host "🏢 INTRANET AZIENDALE:" -ForegroundColor Magenta;
    @Write-Host "  just setup-iis          🌐 Configura IIS per intranet" -ForegroundColor Cyan;
    @Write-Host "  just deploy-intranet    🚀 Deploy completo intranet" -ForegroundColor Cyan;
    @Write-Host "";
    @Write-Host "🪟 WINDOWS IIS DEPLOYMENT:" -ForegroundColor Blue;
    @Write-Host "  just setup-iis-prod     🌐 Setup IIS produzione" -ForegroundColor Blue;
    @Write-Host "  just deploy-iis         🚀 Deploy completo con IIS" -ForegroundColor Blue;
    @Write-Host "  just deploy-iis         🚀 Deploy completo con IIS" -ForegroundColor Cyan;
    @Write-Host "";
    @Write-Host "🐧 LINUX/macOS NGINX:" -ForegroundColor Blue;
    @Write-Host "  just setup-nginx        🌐 Configura Nginx reverse proxy" -ForegroundColor Blue;
    @Write-Host "  just deploy-nginx       🚀 Deploy completo con Nginx" -ForegroundColor Blue;


# Controllo sicurezza Python (Bandit)
# Ricetta cross-platform per security-scan

@security-scan:
    just security-scan-{{os()}}

security-scan-windows:
    @Write-Host "🔒 Controllo sicurezza Bandit..." -ForegroundColor Yellow
    @uv run bandit -r src tools examples --exclude node_modules,.venv,venv,build,dist,__pycache__,.pytest_cache,*.egg-info

security-scan-macos:
    @printf "\033[33m🔒 Controllo sicurezza Bandit...\033[0m\n"
    @uv run bandit -r src tools examples --exclude node_modules,.venv,venv,build,dist,__pycache__,.pytest_cache,*.egg-info

security-scan-linux:
    @printf "\033[33m🔒 Controllo sicurezza Bandit...\033[0m\n"
    @uv run bandit -r src tools examples --exclude node_modules,.venv,venv,build,dist,__pycache__,.pytest_cache,*.egg-info

# === IIS DEPLOYMENT (Windows Server) ===

# 🌐 Setup IIS reverse proxy per Windows Server
setup-iis:
    @Write-Host "🌐 Configurazione IIS reverse proxy..." -ForegroundColor Cyan
    @Write-Host "⚠️  Richiede privilegi di amministratore!" -ForegroundColor Yellow
    @powershell -ExecutionPolicy Bypass -File "deployment/setup-iis.ps1"

# 🚀 Deploy completo per IIS
deploy-iis:
    @Write-Host "🚀 Deploy completo con IIS reverse proxy..." -ForegroundColor Magenta
    @Write-Host "1/4 - Installazione dipendenze produzione..." -ForegroundColor Yellow
    @uv sync --frozen
    @Write-Host "2/4 - Migrazioni database..." -ForegroundColor Yellow
    @DJANGO_ENV="prod" {{django_manage}} migrate --no-input
    @Write-Host "3/4 - Raccolta file statici..." -ForegroundColor Yellow
    @DJANGO_ENV="prod" {{django_manage}} collectstatic --no-input --clear
    @Write-Host "4/4 - Avvio server Uvicorn per IIS..." -ForegroundColor Yellow
    @Write-Host "🌐 Server disponibile per reverse proxy IIS" -ForegroundColor Green
    @DJANGO_ENV="prod" cd src; {{python}} -m uvicorn home.asgi:application --host 127.0.0.1 --port 8000 --workers 1 --log-level info

# === NGINX DEPLOYMENT (Linux/macOS) ===

# 🌐 Setup Nginx per Linux/macOS
setup-nginx:
    @printf "\033[34m🌐 Configurazione Nginx per Linux/macOS...\033[0m\n"
    @printf "\033[33m⚠️  Richiede privilegi sudo!\033[0m\n"
    @printf "\033[33m1/4 - Copia configurazione Nginx...\033[0m\n"
    sudo cp deployment/nginx.conf /etc/nginx/sites-available/gestione-pareri
    @printf "\033[33m2/4 - Abilita sito...\033[0m\n"; \
    sudo ln -sf /etc/nginx/sites-available/gestione-pareri /etc/nginx/sites-enabled/
    @printf "\033[33m3/4 - Test configurazione...\033[0m\n"; \
    sudo nginx -t
    @printf "\033[33m4/4 - Ricarica Nginx...\033[0m\n"; \
    sudo systemctl reload nginx
    @printf "\033[32m✅ Nginx configurato con successo!\033[0m\n"; \
    @printf "\033[32m🌐 Sito disponibile su: http://localhost\033[0m\n"; \

# 🚀 Deploy completo con Nginx
deploy-nginx: install-prod
    @printf "\033[34m🚀 Deploy completo con Nginx...\033[0m\n"; \
    @printf "\033[33m1/5 - Installazione dipendenze...\033[0m\n"; \
    @uv sync --frozen
    @printf "\033[33m2/5 - Migrazioni database...\033[0m\n"; \
    @DJANGO_ENV="prod" {{django_manage}} migrate --no-input
    @printf "\033[33m3/5 - Raccolta file statici...\033[0m\n"; \
    @DJANGO_ENV="prod" {{django_manage}} collectstatic --no-input --clear
    @printf "\033[33m4/5 - Riavvio Django service...\033[0m\n"; \
    sudo systemctl restart gestione-pareri || echo "Service gestione-pareri non configurato"
    @printf "\033[33m5/5 - Reload Nginx...\033[0m\n"; \
    sudo systemctl reload nginx
    @printf "\033[32m✅ Deploy Nginx completato!\033[0m\n"; \
    @printf "\033[32m🌐 Server disponibile tramite Nginx reverse proxy\033[0m\n"; \


# 📊 Status servizi Nginx
status-nginx:
    @printf "\033[34m📊 Status servizi Nginx...\033[0m\n"; \
    @printf "\033[36m=== NGINX STATUS ===\033[0m\n"; \
    sudo systemctl status nginx --no-pager
    @printf "\033[97m\n\033[0m"; \
    @printf "\033[36m=== DJANGO SERVICE STATUS ===\033[0m\n"; \
    sudo systemctl status gestione-pareri --no-pager || echo "Service gestione-pareri non configurato"

# === DJANGO COMMANDS ===

# 🚀 Server di sviluppo
# Ricetta cross-platform per run-server
@run-server:
    just run-server-{{os()}}

run-server-macos:
    @ printf "\033[32m🚀 Avvio server di sviluppo Django (macOS)...\033[0m\n"
    @ uv run src/manage.py runserver

run-server-linux:
    @ printf "\033[32m🚀 Avvio server di sviluppo Django (Linux)...\033[0m\n"
    @ uv run src/manage.py runserver

run-server-windows:
    @Write-Host "🚀 Avvio server di sviluppo Django (Windows)..." -ForegroundColor Green
    @uv run src/manage.py runserver

# 🔧 Server di sviluppo in ambiente DEV
# Ricetta cross-platform per run-dev
@run-dev:
    just run-dev-{{os()}}

run-dev-macos:
    @ printf "\033[32m🔧 Avvio server sviluppo (DEV) su macOS...\033[0m\n"
    @ uv run src/manage.py runserver --settings=home.settings.dev

run-dev-linux:
    @ printf "\033[32m🔧 Avvio server sviluppo (DEV) su Linux...\033[0m\n"
    @ uv run src/manage.py runserver --settings=home.settings.dev

run-dev-windows:
    @Write-Host "🔧 Avvio server sviluppo (DEV) su Windows..." -ForegroundColor Green
    @uv run src/manage.py runserver --settings=home.settings.dev


# 🧪 Server di sviluppo in ambiente TEST
@run-test:
    just run-test-{{os()}}

run-test-macos:
    @ printf "\033[36m🧪 Avvio del server di sviluppo in ambiente TEST (macOS)...\033[0m\n"
    @DJANGO_ENV="test" uv run src/manage.py runserver

run-test-linux:
    @ printf "\033[36m🧪 Avvio del server di sviluppo in ambiente TEST (Linux)...\033[0m\n"
    @DJANGO_ENV="test" uv run src/manage.py runserver

run-test-windows:
    @Write-Host "🧪 Avvio del server di sviluppo in ambiente TEST (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="test" uv run src/manage.py runserver

# 🎭 Server di sviluppo in ambiente STAGING
@run-staging:
    just run-staging-{{os()}}

run-staging-macos:
    @ printf "\033[36m🎭 Avvio del server di sviluppo in ambiente STAGING (macOS)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa sempre PostgreSQL!\033[0m\n"
    @ DJANGO_ENV="staging" uv run src/manage.py runserver

run-staging-linux:
    @ printf "\033[36m🎭 Avvio del server di sviluppo in ambiente STAGING (Linux)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa sempre PostgreSQL!\033[0m\n"
    @ DJANGO_ENV="staging" uv run src/manage.py runserver

run-staging-windows:
    @Write-Host "🎭 Avvio del server di sviluppo in ambiente STAGING (Windows)..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa sempre PostgreSQL!" -ForegroundColor Yellow
    @DJANGO_ENV="staging" uv run src/manage.py runserver

# ⚡ Server di sviluppo in ambiente PROD
@run-prod:
    just run-prod-{{os()}}

run-prod-macos:
    @ printf "\033[36m⚡ Avvio del server di sviluppo in ambiente PROD (macOS)...\033[0m\n"
    @ DJANGO_ENV="prod" uv run src/manage.py runserver

run-prod-linux:
    @ printf "\033[36m⚡ Avvio del server di sviluppo in ambiente PROD (Linux)...\033[0m\n"
    @ DJANGO_ENV="prod" uv run src/manage.py runserver

run-prod-windows:
    @Write-Host "⚡ Avvio del server di sviluppo in ambiente PROD (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="prod" uv run src/manage.py runserver

# 🧪 Test del progetto
@test:
    just test-{{os()}}

test-macos:
    @ printf "\033[36m🧪 Esecuzione dei test (macOS)...\033[0m\n"
    @ cd src && uv run manage.py test

test-linux:
    @ printf "\033[36m🧪 Esecuzione dei test (Linux)...\033[0m\n"
    @ cd src && uv run manage.py test

test-windows:
    @Write-Host "🧪 Esecuzione dei test (Windows)..." -ForegroundColor Cyan
    @cd src; uv run manage.py test

# 🧪 Test in ambiente DEV
test-dev:
    just test-dev-{{os()}}

test-dev-macos:
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente DEV (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="dev" uv run manage.py test

test-dev-linux:
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente DEV (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="dev" uv run manage.py test

test-dev-windows:
    @Write-Host "🧪 Esecuzione dei test in ambiente DEV (Windows)..." -ForegroundColor Cyan
    cd src; $env:DJANGO_ENV="dev"; uv run manage.py test

# 🧪 Test in ambiente TEST
test-test:
    just test-test-{{os()}}

test-test-macos:
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente TEST (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py test

test-test-linux:
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente TEST (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py test

test-test-windows:
    @Write-Host "🧪 Esecuzione dei test in ambiente TEST (Windows)..." -ForegroundColor Cyan
    cd src; $env:DJANGO_ENV="test"; uv run manage.py test

# 🧪 Test in ambiente STAGING
test-staging:
    just test-staging-{{os()}}

test-staging-macos:
    @ printf "\033[36m🎭 Esecuzione dei test in ambiente STAGING (macOS)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!\033[0m\n"
    @ cd src && DJANGO_ENV="staging" uv run manage.py test

test-staging-linux:
    @ printf "\033[36m🎭 Esecuzione dei test in ambiente STAGING (Linux)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!\033[0m\n"
    @ cd src && DJANGO_ENV="staging" uv run manage.py test

test-staging-windows:
    @Write-Host "🎭 Esecuzione dei test in ambiente STAGING (Windows)..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!" -ForegroundColor Yellow
    cd src; $env:DJANGO_ENV="staging"; uv run manage.py test

# 🧪 Test in ambiente PROD
test-prod:
    just test-prod-{{os()}}

test-prod-macos:
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente PROD (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="prod" uv run manage.py test

test-prod-linux:
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente PROD (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="prod" uv run manage.py test

test-prod-windows:
    @Write-Host "🧪 Esecuzione dei test in ambiente PROD (Windows)..." -ForegroundColor Cyan
    cd src; $env:DJANGO_ENV="prod"; uv run manage.py test

# 📦 Migrazioni database
migrate:
    just migrate-{{os()}}

migrate-macos:
    @ printf "\033[36m📦 Applicazione delle migrazioni (macOS)...\033[0m\n"
    @ {{django_manage}} migrate

migrate-linux:
    @ printf "\033[36m📦 Applicazione delle migrazioni (Linux)...\033[0m\n"
    @ {{django_manage}} migrate

migrate-windows:
    @Write-Host "📦 Applicazione delle migrazioni (Windows)..." -ForegroundColor Cyan
    @{{django_manage}} migrate

# 📦 Migrazioni in ambiente DEV
migrate-dev:
    just migrate-dev-{{os()}}

migrate-dev-macos:
    @ printf "\033[36m📦 Applicazione delle migrazioni in ambiente DEV (macOS)...\033[0m\n"
    @ DJANGO_ENV="dev" {{django_manage}} migrate

migrate-dev-linux:
    @ printf "\033[36m📦 Applicazione delle migrazioni in ambiente DEV (Linux)...\033[0m\n"
    @ DJANGO_ENV="dev" {{django_manage}} migrate

migrate-dev-windows:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente DEV (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="dev" {{django_manage}} migrate

# 📦 Migrazioni in ambiente TEST
migrate-test:
    just migrate-test-{{os()}}

migrate-test-macos:
    @ printf "\033[36m📦 Applicazione delle migrazioni in ambiente TEST (macOS)...\033[0m\n"
    @ DJANGO_ENV="test" {{django_manage}} migrate

migrate-test-linux:
    @ printf "\033[36m📦 Applicazione delle migrazioni in ambiente TEST (Linux)...\033[0m\n"
    @ DJANGO_ENV="test" {{django_manage}} migrate

migrate-test-windows:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente TEST (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="test" {{django_manage}} migrate

# 📦 Migrazioni in ambiente STAGING
migrate-staging:
    just migrate-staging-{{os()}}

migrate-staging-macos:
    @ printf "\033[36m🎭 Applicazione delle migrazioni in ambiente STAGING (macOS)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!\033[0m\n"
    @ DJANGO_ENV="staging" {{django_manage}} migrate

migrate-staging-linux:
    @ printf "\033[36m🎭 Applicazione delle migrazioni in ambiente STAGING (Linux)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!\033[0m\n"
    @ DJANGO_ENV="staging" {{django_manage}} migrate

migrate-staging-windows:
    @Write-Host "🎭 Applicazione delle migrazioni in ambiente STAGING (Windows)..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!" -ForegroundColor Yellow
    @DJANGO_ENV="staging" {{django_manage}} migrate

# 📦 Migrazioni in ambiente PROD
migrate-prod:
    just migrate-prod-{{os()}}

migrate-prod-macos:
    @ printf "\033[36m📦 Applicazione delle migrazioni in ambiente PROD (macOS)...\033[0m\n"
    @ DJANGO_ENV="prod" {{django_manage}} migrate

migrate-prod-linux:
    @ printf "\033[36m📦 Applicazione delle migrazioni in ambiente PROD (Linux)...\033[0m\n"
    @ DJANGO_ENV="prod" {{django_manage}} migrate

migrate-prod-windows:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente PROD (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="prod" {{django_manage}} migrate

# 📝 Creazione migrazioni
makemigrations:
    just makemigrations-{{os()}}

makemigrations-macos:
    @ printf "\033[36m📝 Creazione delle migrazioni (macOS)...\033[0m\n"
    @ {{django_manage}} makemigrations

makemigrations-linux:
    @ printf "\033[36m📝 Creazione delle migrazioni (Linux)...\033[0m\n"
    @ {{django_manage}} makemigrations

makemigrations-windows:
    @Write-Host "📝 Creazione delle migrazioni (Windows)..." -ForegroundColor Cyan
    @{{django_manage}} makemigrations

# 🐚 Shell Django
shell:
    just shell-{{os()}}

shell-macos:
    @ printf "\033[36m🐚 Avvio della shell Django (macOS)...\033[0m\n"
    @ {{django_manage}} shell

shell-linux:
    @ printf "\033[36m🐚 Avvio della shell Django (Linux)...\033[0m\n"
    @ {{django_manage}} shell

shell-windows:
    @Write-Host "🐚 Avvio della shell Django (Windows)..." -ForegroundColor Cyan
    @{{django_manage}} shell

shell-dev:
    just shell-dev-{{os()}}

shell-dev-macos:
    @ printf "\033[36m🐚 Avvio della shell Django in ambiente DEV (macOS)...\033[0m\n"
    @ DJANGO_ENV="dev" {{django_manage}} shell

shell-dev-linux:
    @ printf "\033[36m🐚 Avvio della shell Django in ambiente DEV (Linux)...\033[0m\n"
    @ DJANGO_ENV="dev" {{django_manage}} shell

shell-dev-windows:
    @Write-Host "🐚 Avvio della shell Django in ambiente DEV (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="dev" {{django_manage}} shell

shell-test:
    just shell-test-{{os()}}

shell-test-macos:
    @ printf "\033[36m🐚 Avvio della shell Django in ambiente TEST (macOS)...\033[0m\n"
    @ DJANGO_ENV="test" {{django_manage}} shell

shell-test-linux:
    @ printf "\033[36m🐚 Avvio della shell Django in ambiente TEST (Linux)...\033[0m\n"
    @ DJANGO_ENV="test" {{django_manage}} shell

shell-test-windows:
    @Write-Host "🐚 Avvio della shell Django in ambiente TEST (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="test" {{django_manage}} shell

shell-staging:
    just shell-staging-{{os()}}

shell-staging-macos:
    @ printf "\033[36m🎭 Avvio della shell Django in ambiente STAGING (macOS)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa PostgreSQL!\033[0m\n"
    @ DJANGO_ENV="staging" {{django_manage}} shell

shell-staging-linux:
    @ printf "\033[36m🎭 Avvio della shell Django in ambiente STAGING (Linux)...\033[0m\n"
    @ printf "\033[33m⚠️  STAGING usa PostgreSQL!\033[0m\n"
    @ DJANGO_ENV="staging" {{django_manage}} shell

shell-staging-windows:
    @Write-Host "🎭 Avvio della shell Django in ambiente STAGING (Windows)..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL!" -ForegroundColor Yellow
    @DJANGO_ENV="staging" {{django_manage}} shell

shell-prod:
    just shell-prod-{{os()}}

shell-prod-macos:
    @ printf "\033[36m🐚 Avvio della shell Django in ambiente PROD (macOS)...\033[0m\n"
    @ DJANGO_ENV="prod" {{django_manage}} shell

shell-prod-linux:
    @ printf "\033[36m🐚 Avvio della shell Django in ambiente PROD (Linux)...\033[0m\n"
    @ DJANGO_ENV="prod" {{django_manage}} shell

shell-prod-windows:
    @Write-Host "🐚 Avvio della shell Django in ambiente PROD (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="prod" {{django_manage}} shell
# === QUALITY COMMANDS ===

# 📝 Aggiunge docstring mancanti
add-docstrings:
    just add-docstrings-{{os()}}
add-docstrings-macos:
    @ printf "\033[36m📝 Aggiunta docstring ai file Python del progetto (macOS)...\033[0m\n"
    @ {{python}} tools/add_docstring_batch.py .
    @ printf "\033[32m✅ Docstring aggiunte con successo!\033[0m\n"

add-docstrings-linux:
    @ printf "\033[36m📝 Aggiunta docstring ai file Python del progetto (Linux)...\033[0m\n"
    @ {{python}} tools/add_docstring_batch.py .
    @ printf "\033[32m✅ Docstring aggiunte con successo!\033[0m\n"

add-docstrings-windows:
    @Write-Host "📝 Aggiunta docstring ai file Python del progetto (Windows)..." -ForegroundColor Cyan
    {{python}} tools/add_docstring_batch.py .
    @Write-Host "✅ Docstring aggiunte con successo!" -ForegroundColor Green

# ⭐ CORREZIONE GLOBALE: Fix all code quality issues
fix-all:
    just fix-all-{{os()}}
fix-all-macos:
    @ printf "\033[36m⭐ Correzione completa di tutti i problemi di qualità del codice (macOS)...\033[0m\n"
    @ printf "\033[33m1/10 - Rimozione spazi finali...\033[0m\n"
    @ pre-commit run trailing-whitespace --all-files
    @ printf "\033[33m2/10 - Correzione fine file...\033[0m\n"
    @ pre-commit run end-of-file-fixer --all-files
    @ printf "\033[33m3/10 - Aggiunta docstring...\033[0m\n"
    @ {{python}} tools/add_docstring_batch.py .
    @ printf "\033[33m4/10 - Ordinamento import (isort style)...\033[0m\n"
    @ {{python}} ruff check --select I --fix .
    @ printf "\033[33m5/10 - Formattazione con Ruff...\033[0m\n"
    @ {{python}} ruff format .
    @ printf "\033[33m6/10 - Correzione automatica con Ruff...\033[0m\n"
    @ {{python}} ruff check . --fix --unsafe-fixes
    @ printf "\033[33m7/10 - Correzioni aggressive con autopep8...\033[0m\n"
    @ {{python}} autopep8 --in-place --aggressive --aggressive --recursive .
    @ printf "\033[33m8/10 - Formattazione finale con Ruff...\033[0m\n"
    @ {{python}} ruff format .
    @ printf "\033[33m9/10 - Formattazione Markdown...\033[0m\n"
    @ just format-markdown
    @ printf "\033[33m10/10 - Correzione problemi Markdown...\033[0m\n"
    @ just fix-markdown
    @ printf "\033[32m✅ Tutti i problemi di qualità del codice sono stati corretti!\033[0m\n"

fix-all-linux:
    @ printf "\033[36m⭐ Correzione completa di tutti i problemi di qualità del codice (Linux)...\033[0m\n"
    @ printf "\033[33m1/10 - Rimozione spazi finali...\033[0m\n"
    @ pre-commit run trailing-whitespace --all-files
    @ printf "\033[33m2/10 - Correzione fine file...\033[0m\n"
    @ pre-commit run end-of-file-fixer --all-files
    @ printf "\033[33m3/10 - Aggiunta docstring...\033[0m\n"
    @ {{python}} tools/add_docstring_batch.py .
    @ printf "\033[33m4/10 - Ordinamento import (isort style)...\033[0m\n"
    @ {{python}} ruff check --select I --fix .
    @ printf "\033[33m5/10 - Formattazione con Ruff...\033[0m\n"
    @ {{python}} ruff format .
    @ printf "\033[33m6/10 - Correzione automatica con Ruff...\033[0m\n"
    @ {{python}} ruff check . --fix --unsafe-fixes
    @ printf "\033[33m7/10 - Correzioni aggressive con autopep8...\033[0m\n"
    @ {{python}} autopep8 --in-place --aggressive --aggressive --recursive .
    @ printf "\033[33m8/10 - Formattazione finale con Ruff...\033[0m\n"
    @ {{python}} ruff format .
    @ printf "\033[33m9/10 - Formattazione Markdown...\033[0m\n"
    @ just format-markdown
    @ printf "\033[33m10/10 - Correzione problemi Markdown...\033[0m\n"
    @ just fix-markdown
    @ printf "\033[32m✅ Tutti i problemi di qualità del codice sono stati corretti!\033[0m\n"

fix-all-windows:
    @Write-Host "⭐ Correzione completa di tutti i problemi di qualità del codice (Windows)..." -ForegroundColor Cyan
    @Write-Host "1/10 - Rimozione spazi finali..." -ForegroundColor Yellow
    pre-commit run trailing-whitespace --all-files
    @Write-Host "2/10 - Correzione fine file..." -ForegroundColor Yellow
    pre-commit run end-of-file-fixer --all-files
    @Write-Host "3/10 - Aggiunta docstring..." -ForegroundColor Yellow
    {{python}} tools/add_docstring_batch.py .
    @Write-Host "4/10 - Ordinamento import (isort style)..." -ForegroundColor Yellow
    {{python}} ruff check --select I --fix .
    @Write-Host "5/10 - Formattazione con Ruff..." -ForegroundColor Yellow
    {{python}} ruff format .
    @Write-Host "6/10 - Correzione automatica con Ruff..." -ForegroundColor Yellow
    {{python}} ruff check . --fix --unsafe-fixes
    @Write-Host "7/10 - Correzioni aggressive con autopep8..." -ForegroundColor Yellow
    {{python}} autopep8 --in-place --aggressive --aggressive --recursive .
    @Write-Host "8/10 - Formattazione finale con Ruff..." -ForegroundColor Yellow
    {{python}} ruff format .
    @Write-Host "9/10 - Formattazione Markdown..." -ForegroundColor Yellow
    just format-markdown
    @Write-Host "10/10 - Correzione problemi Markdown..." -ForegroundColor Yellow
    just fix-markdown
    @Write-Host "✅ Tutti i problemi di qualità del codice sono stati corretti!" -ForegroundColor Green
    else \
        @Write-Host "7/10 - Correzioni aggressive con autopep8..." -ForegroundColor Yellow; \
    fi
    @-{{python}} autopep8 --in-place --aggressive --aggressive --recursive .
    @if [ "$(uname -s)" = "Darwin" ] || [ "$(uname -s)" = "Linux" ]; then \
        @printf "\033[33m8/10 - Formattazione finale con Ruff...\033[0m\n"; \
    else \
        @Write-Host "8/10 - Formattazione finale con Ruff..." -ForegroundColor Yellow; \
    fi
    @-{{python}} ruff format .
    @if [ "$(uname -s)" = "Darwin" ] || [ "$(uname -s)" = "Linux" ]; then \
        @printf "\033[33m9/10 - Formattazione Markdown...\033[0m\n"; \
    else \
        @Write-Host "9/10 - Formattazione Markdown..." -ForegroundColor Yellow; \
    fi
    @just format-markdown
    @if [ "$(uname -s)" = "Darwin" ] || [ "$(uname -s)" = "Linux" ]; then \
        @printf "\033[33m10/10 - Correzione problemi Markdown...\033[0m\n"; \
    else \
        @Write-Host "10/10 - Correzione problemi Markdown..." -ForegroundColor Yellow; \
    fi
    @just fix-markdown
    @if [ "$(uname -s)" = "Darwin" ] || [ "$(uname -s)" = "Linux" ]; then \
        @printf "\033[32m✅ Tutti i problemi di qualità del codice sono stati corretti!\033[0m\n"; \
    else \
        @Write-Host "✅ Tutti i problemi di qualità del codice sono stati corretti!" -ForegroundColor Green; \
    fi

# 🔍 Test pre-commit hooks senza modifiche
test-precommit:
    just test-precommit-{{os()}}

test-precommit-macos:
    @ printf "\033[36m🔍 Test di tutti i controlli pre-commit (macOS)...\033[0m\n"
    @ pre-commit run --all-files
    @ printf "\033[32m✅ Test pre-commit completato!\033[0m\n"

test-precommit-linux:
    @ printf "\033[36m🔍 Test di tutti i controlli pre-commit (Linux)...\033[0m\n"
    @ pre-commit run --all-files
    @ printf "\033[32m✅ Test pre-commit completato!\033[0m\n"

test-precommit-windows:
    @Write-Host "🔍 Test di tutti i controlli pre-commit (Windows)..." -ForegroundColor Cyan
    pre-commit run --all-files
    @Write-Host "✅ Test pre-commit completato!" -ForegroundColor Green

# 🔧 Correzione automatica script bash
fix-codacy:
    just fix-codacy-{{os()}}

fix-codacy-macos:
    @ printf "\033[36m🔧 Correzione automatica script bash (macOS)...\033[0m\n"
    @ find scripts/deployment -name "*.sh" -exec shfmt -w {} +
    @ printf "\033[32m✅ Correzioni applicate!\033[0m\n"

fix-codacy-linux:
    @ printf "\033[36m🔧 Correzione automatica script bash (Linux)...\033[0m\n"
    @ find scripts/deployment -name "*.sh" -exec shfmt -w {} +
    @ printf "\033[32m✅ Correzioni applicate!\033[0m\n"

fix-codacy-windows:
    @Write-Host "🔧 Correzione automatica script bash (Windows)..." -ForegroundColor Cyan
    find scripts/deployment -name "*.sh" -exec shfmt -w {} +
    @Write-Host "✅ Correzioni applicate!" -ForegroundColor Green

# 📝 Formattazione file Markdown
format-markdown:
    just format-markdown-{{os()}}

format-markdown-macos:
    @ printf "\033[36m📝 Formattazione file Markdown (macOS)...\033[0m\n"
    @ find . -name "*.md" -exec printf "Formatting %s\n" {} \; -exec sed -i '' -e '/^[ \t]*$/d' -e ':a;N;$!ba;s/\n\{3,\}/\n\n/g' {} \;
    @ printf "\033[32m✅ File Markdown formattati con successo!\033[0m\n"

format-markdown-linux:
    @ printf "\033[36m📝 Formattazione file Markdown (Linux)...\033[0m\n"
    @ find . -name "*.md" -exec printf "Formatting %s\n" {} \; -exec sed -i -e '/^[ \t]*$/d' -e ':a;N;$!ba;s/\n\{3,\}/\n\n/g' {} \;
    @ printf "\033[32m✅ File Markdown formattati con successo!\033[0m\n"

format-markdown-windows:
    @Write-Host "📝 Formattazione file Markdown (Windows)..." -ForegroundColor Cyan
    find . -name "*.md" -exec Write-Host "Formatting {}" \; -exec sed -i -e '/^[ \t]*$/d' -e ':a;N;$!ba;s/\n\{3,\}/\n\n/g' {} \;
    @Write-Host "✅ File Markdown formattati con successo!" -ForegroundColor Green

# 📝 Correzione problemi Markdown
fix-markdown:
    just fix-markdown-{{os()}}

fix-markdown-macos:
    @ printf "\033[36m📝 Correzione problemi Markdown (macOS)...\033[0m\n"
    @ printf "\033[33m1/4 - Correzioni automatiche...\033[0m\n"
    @ {{python}} tools/fix_markdown.py
    @ printf "\033[33m2/4 - Prettier formatting...\033[0m\n"
    @ pnpm exec prettier --write "**/*.md"
    @ printf "\033[33m3/4 - Markdownlint auto-fix...\033[0m\n"
    @ pnpm exec markdownlint-cli2 --fix "**/*.md" "!**/node_modules/**/*.md" --ignore-path .markdownlintignore --config .config/.markdownlint-cli2.jsonc
    @ printf "\033[33m4/4 - Markdownlint validation...\033[0m\n"
    @-pre-commit run markdownlint-cli2 --all-files
    @ printf "\033[32m✅ Problemi Markdown corretti!\033[0m\n"

fix-markdown-linux:
    @ printf "\033[36m📝 Correzione problemi Markdown (Linux)...\033[0m\n"
    @ printf "\033[33m1/4 - Correzioni automatiche...\033[0m\n"
    @ {{python}} tools/fix_markdown.py
    @ printf "\033[33m2/4 - Prettier formatting...\033[0m\n"
    @ pnpm exec prettier --write "**/*.md"
    @ printf "\033[33m3/4 - Markdownlint auto-fix...\033[0m\n"
    @ pnpm exec markdownlint-cli2 --fix "**/*.md" "!**/node_modules/**/*.md" --ignore-path .markdownlintignore --config .config/.markdownlint-cli2.jsonc
    @ printf "\033[33m4/4 - Markdownlint validation...\033[0m\n"
    @-pre-commit run markdownlint-cli2 --all-files
    @ printf "\033[32m✅ Problemi Markdown corretti!\033[0m\n"

fix-markdown-windows:
    @Write-Host "📝 Correzione problemi Markdown (Windows)..." -ForegroundColor Cyan
    @Write-Host "1/4 - Correzioni automatiche..." -ForegroundColor Yellow
    {{python}} tools/fix_markdown.py
    @Write-Host "2/4 - Prettier formatting..." -ForegroundColor Yellow
    pnpm exec prettier --write "**/*.md"
    @Write-Host "3/4 - Markdownlint auto-fix..." -ForegroundColor Yellow
    pnpm exec markdownlint-cli2 --fix "**/*.md" "!**/node_modules/**/*.md" --ignore-path .markdownlintignore --config .config/.markdownlint-cli2.jsonc
    @Write-Host "4/4 - Markdownlint validation..." -ForegroundColor Yellow
    pre-commit run markdownlint-cli2 --all-files
    @Write-Host "✅ Problemi Markdown corretti!" -ForegroundColor Green

# 🔍 Controlli qualità stile Codacy (semplificato)
lint-codacy:
    just lint-codacy-{{os()}}
lint-codacy-macos:
    @ printf "\033[36m🔍 Controlli qualità stile Codacy (macOS)...\033[0m\n"
    @ printf "\033[33m1/3 - Ruff check...\033[0m\n"
    @ {{python}} ruff check --output-format=github --config=pyproject.toml .
    @ printf "\033[33m2/3 - Flake8...\033[0m\n"
    @ {{python}} flake8 --format=default --config=.config/flake8 --exclude=.venv,migrations/*,migrations/**,src/*/migrations/*,src/*/migrations/**,src/**/migrations/*,src/**/migrations/**,src/**/migrations,src/**/migrations/*.py,src/**/migrations/**/*.py,node_modules .
    @ printf "\033[33m3/3 - Pylint...\033[0m\n"
    @ {{python}} pylint src/home/ --output-format=colorized
    @ printf "\033[32m✅ Controlli completati!\033[0m\n"

lint-codacy-linux:
    @ printf "\033[36m🔍 Controlli qualità stile Codacy (Linux)...\033[0m\n"
    @ printf "\033[33m1/3 - Ruff check...\033[0m\n"
    @ {{python}} ruff check --output-format=github --config=pyproject.toml .
    @ printf "\033[33m2/3 - Flake8...\033[0m\n"
    @ {{python}} flake8 --format=default --config=.config/flake8 --exclude=.venv,migrations/*,migrations/**,src/*/migrations/*,src/*/migrations/**,src/**/migrations/*,src/**/migrations/**,src/**/migrations,src/**/migrations/*.py,src/**/migrations/**/*.py,node_modules .
    @ printf "\033[33m3/3 - Pylint...\033[0m\n"
    @ {{python}} pylint src/home/ --output-format=colorized
    @ printf "\033[32m✅ Controlli completati!\033[0m\n"

lint-codacy-windows:
    @Write-Host "🔍 Controlli qualità stile Codacy (Windows)..." -ForegroundColor Cyan
    @Write-Host "1/3 - Ruff check..." -ForegroundColor Yellow
    {{python}} ruff check --output-format=github --config=pyproject.toml .
    @Write-Host "2/3 - Flake8..." -ForegroundColor Yellow
    {{python}} flake8 --format=default --config=.config/flake8 --exclude=.venv,migrations/*,migrations/**,src/*/migrations/*,src/*/migrations/**,src/**/migrations/*,src/**/migrations/**,src/**/migrations,src/**/migrations/*.py,src/**/migrations/**/*.py,node_modules .
    @Write-Host "3/3 - Pylint..." -ForegroundColor Yellow
    {{python}} pylint src/home/ --output-format=colorized
    @Write-Host "✅ Controlli completati!" -ForegroundColor Green

# 📊 Statistiche progetto
stats:
    just stats-{{os()}}

stats-macos:
    @ printf "\033[36m📊 Generazione statistiche progetto (macOS)...\033[0m\n"
    @ {{python}} tools/project_stats.py
    @ printf "\033[32m📊 Dashboard disponibile in tools/quality_dashboard.md\033[0m\n"

stats-linux:
    @ printf "\033[36m📊 Generazione statistiche progetto (Linux)...\033[0m\n"
    @ {{python}} tools/project_stats.py
    @ printf "\033[32m📊 Dashboard disponibile in tools/quality_dashboard.md\033[0m\n"

stats-windows:
    @Write-Host "📊 Generazione statistiche progetto (Windows)..." -ForegroundColor Cyan
    {{python}} tools/project_stats.py
    @Write-Host "📊 Dashboard disponibile in tools/quality_dashboard.md" -ForegroundColor Green

# 🔑 Genera Django SECRET_KEY
generate-secret-key:
    just generate-secret-key-{{os()}}

generate-secret-key-macos:
    @ printf "\033[36m🔑 Generazione Django SECRET_KEY (macOS)...\033[0m\n"
    @ printf "\033[33mGenero SECRET_KEY generica:\033[0m\n"
    @ {{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

generate-secret-key-linux:
    @ printf "\033[36m🔑 Generazione Django SECRET_KEY (Linux)...\033[0m\n"
    @ printf "\033[33mGenero SECRET_KEY generica:\033[0m\n"
    @ {{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

generate-secret-key-windows:
    @Write-Host "🔑 Generazione Django SECRET_KEY (Windows)..." -ForegroundColor Cyan
    @Write-Host "Genero SECRET_KEY generica:" -ForegroundColor Yellow
    {{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

# 🔑 Genera SECRET_KEY per tutti i 4 ambienti
generate-secret-keys-all:
    just generate-secret-keys-all-{{os()}}

generate-secret-keys-all-macos:
    @ printf "\033[36m🔐 Generazione SECRET_KEY per tutti gli ambienti (macOS)...\033[0m\n"
    @ printf "\n"
    @ printf "\033[32m🔧 DEV Environment:\033[0m\n"
    dev_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_DEV=%s\n" "$dev_key"
    @ printf "\n"
    @ printf "\033[34m🧪 TEST Environment:\033[0m\n"
    test_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_TEST=%s\n" "$test_key"
    @ printf "\n"
    @ printf "\033[35m🎭 STAGING Environment:\033[0m\n"
    staging_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_STAGING=%s\n" "$staging_key"
    @ printf "\n"
    @ printf "\033[31m⚡ PROD Environment:\033[0m\n"
    prod_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_PROD=%s\n" "$prod_key"
    @ printf "\n"
    @ printf "\033[36m💡 CONFIGURAZIONE .env:\033[0m\n"
    @ printf "\033[36m=======================\033[0m\n"
    @ printf "DJANGO_SECRET_KEY_DEV=%s\n" "$dev_key"
    @ printf "DJANGO_SECRET_KEY_TEST=%s\n" "$test_key"
    @ printf "DJANGO_SECRET_KEY_STAGING=%s\n" "$staging_key"
    @ printf "DJANGO_SECRET_KEY_PROD=%s\n" "$prod_key"
    @ printf "\n"
    @ printf "\033[33m⚠️  IMPORTANTE: Ogni ambiente deve avere la sua SECRET_KEY!\033[0m\n"
    @ printf "\033[90m📖 Vedi docs/environments-guide.md per configurazione completa\033[0m\n"

generate-secret-keys-all-linux:
    @ printf "\033[36m🔐 Generazione SECRET_KEY per tutti gli ambienti (Linux)...\033[0m\n"
    @ printf "\n"
    @ printf "\033[32m🔧 DEV Environment:\033[0m\n"
    dev_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_DEV=%s\n" "$dev_key"
    @ printf "\n"
    @ printf "\033[34m🧪 TEST Environment:\033[0m\n"
    test_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_TEST=%s\n" "$test_key"
    @ printf "\n"
    @ printf "\033[35m🎭 STAGING Environment:\033[0m\n"
    staging_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_STAGING=%s\n" "$staging_key"
    @ printf "\n"
    @ printf "\033[31m⚡ PROD Environment:\033[0m\n"
    prod_key=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    @ printf "DJANGO_SECRET_KEY_PROD=%s\n" "$prod_key"
    @ printf "\n"
    @ printf "\033[36m💡 CONFIGURAZIONE .env:\033[0m\n"
    @ printf "\033[36m=======================\033[0m\n"
    @ printf "DJANGO_SECRET_KEY_DEV=%s\n" "$dev_key"
    @ printf "DJANGO_SECRET_KEY_TEST=%s\n" "$test_key"
    @ printf "DJANGO_SECRET_KEY_STAGING=%s\n" "$staging_key"
    @ printf "DJANGO_SECRET_KEY_PROD=%s\n" "$prod_key"
    @ printf "\n"
    @ printf "\033[33m⚠️  IMPORTANTE: Ogni ambiente deve avere la sua SECRET_KEY!\033[0m\n"
    @ printf "\033[90m📖 Vedi docs/environments-guide.md per configurazione completa\033[0m\n"

generate-secret-keys-all-windows:
    @Write-Host "🔐 Generazione SECRET_KEY per tutti gli ambienti (Windows)..." -ForegroundColor Cyan
    @Write-Host ""
    @Write-Host "🔧 DEV Environment:" -ForegroundColor Green
    @$dev_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_DEV=$dev_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "🧪 TEST Environment:" -ForegroundColor Blue
    @$test_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_TEST=$test_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "🎭 STAGING Environment:" -ForegroundColor Magenta
    @$staging_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_STAGING=$staging_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "⚡ PROD Environment:" -ForegroundColor Red
    @$prod_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_PROD=$prod_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "💡 CONFIGURAZIONE .env:" -ForegroundColor Cyan
    @Write-Host "=======================" -ForegroundColor Cyan
    @Write-Host "DJANGO_SECRET_KEY_DEV=$dev_key"
    @Write-Host "DJANGO_SECRET_KEY_TEST=$test_key"
    @Write-Host "DJANGO_SECRET_KEY_STAGING=$staging_key"
    @Write-Host "DJANGO_SECRET_KEY_PROD=$prod_key"
    @Write-Host ""
    @Write-Host "⚠️  IMPORTANTE: Ogni ambiente deve avere la sua SECRET_KEY!" -ForegroundColor Yellow
    @Write-Host "📖 Vedi docs/environments-guide.md per configurazione completa" -ForegroundColor Gray
# === DEPLOYMENT COMMANDS ===

# 📦 Installazione dipendenze produzione
install-prod:
    @@Write-Host "📦 Installazione dipendenze produzione..." -ForegroundColor Cyan
    @uv sync --group prod

# 🔧 Deploy development
deploy-dev:
    @@Write-Host "🔧 Avvio server di sviluppo..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="dev"; {{django_manage}} runserver

# 🧪 Deploy staging
deploy-staging:
    @@Write-Host "🧪 Deploy staging (Windows - Uvicorn)..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="test"; powershell -ExecutionPolicy Bypass -File scripts/deployment/start-uvicorn.ps1 -DjangoEnv test

# 🚀 Deploy production
deploy-prod: install-prod
    @@Write-Host "🚀 Deploy produzione (Windows - Uvicorn ASGI)..." -ForegroundColor Green
    @just run-uvicorn

# 🎯 Smart deploy automatico
deploy: install-prod
    @@Write-Host "🎯 Smart deployment - Windows rilevato, usando Uvicorn ASGI..." -ForegroundColor Cyan
    @just run-uvicorn

# 🪟 Waitress server (Windows/Cross-platform)
waitress: install-prod
    @@Write-Host "🪟 Avvio Django con Waitress (Windows)..." -ForegroundColor Green
    @@Write-Host "🚀 Starting Django with Waitress" -ForegroundColor Green
    @@Write-Host "Environment: prod" -ForegroundColor Cyan
    @@Write-Host "Host: 0.0.0.0:8000" -ForegroundColor Cyan
    @@Write-Host "Threads: 4" -ForegroundColor Cyan
    @@Write-Host "📊 Running migrations..." -ForegroundColor Yellow
    @{{django_manage}} migrate --no-input
    @@Write-Host "📁 Collecting static files..." -ForegroundColor Yellow
    @{{django_manage}} collectstatic --no-input --clear
    @@Write-Host "🌟 Starting Waitress server..." -ForegroundColor Green
    @$env:DJANGO_ENV="prod"; cd src; {{python}} -m waitress --host=0.0.0.0 --port=8000 --threads=4 --connection-limit=1000 --channel-timeout=120 home.wsgi:application

# ⚡ Uvicorn ASGI server - RACCOMANDATO
run-uvicorn:
    just run-uvicorn-{{os()}}

run-uvicorn-macos:
    @ printf "\033[32m⚡ Avvio Django con Uvicorn ASGI (macOS)...\033[0m\n"
    @ printf "\033[34m🚀 Starting Uvicorn ASGI Server\033[0m\n"
    @ printf "\033[33mEnvironment: prod\033[0m\n"
    @ printf "\033[33mHost: 0.0.0.0:8000\033[0m\n"
    @ printf "\033[33m📊 Running migrations...\033[0m\n"
    {{django_manage}} migrate --no-input
    @ printf "\033[33m📁 Collecting static files...\033[0m\n"
    {{django_manage}} collectstatic --no-input --clear
    @ printf "\033[32m🌟 Starting Uvicorn server...\033[0m\n"
    cd src; {{python}} -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --workers 1 --log-level info

run-uvicorn-linux:
    @ printf "\033[32m⚡ Avvio Django con Uvicorn ASGI (Linux)...\033[0m\n"
    @ printf "\033[34m🚀 Starting Uvicorn ASGI Server\033[0m\n"
    @ printf "\033[33mEnvironment: prod\033[0m\n"
    @ printf "\033[33mHost: 0.0.0.0:8000\033[0m\n"
    @ printf "\033[33m📊 Running migrations...\033[0m\n"
    {{django_manage}} migrate --no-input
    @ printf "\033[33m📁 Collecting static files...\033[0m\n"
    {{django_manage}} collectstatic --no-input --clear
    @ printf "\033[32m🌟 Starting Uvicorn server...\033[0m\n"
    cd src; {{python}} -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --workers 1 --log-level info

run-uvicorn-windows:
    @Write-Host "⚡ Avvio Django con Uvicorn ASGI (Windows)..." -ForegroundColor Green
    @Write-Host "🚀 Starting Uvicorn ASGI Server" -ForegroundColor Blue
    @Write-Host "Environment: prod" -ForegroundColor Yellow
    @Write-Host "Host: 0.0.0.0:8000" -ForegroundColor Yellow
    @Write-Host "📊 Running migrations..." -ForegroundColor Yellow
    {{django_manage}} migrate --no-input
    @Write-Host "📁 Collecting static files..." -ForegroundColor Yellow
    {{django_manage}} collectstatic --no-input --clear
    @Write-Host "🌟 Starting Uvicorn server..." -ForegroundColor Green
    cd src; {{python}} -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --workers 1 --log-level info

# 🧪 Test Uvicorn locale (debug)
test-uvicorn-local:
    just test-uvicorn-local-{{os()}}

test-uvicorn-local-macos:
    @ bash scripts/deployment/test-uvicorn-local.sh

test-uvicorn-local-linux:
    @ bash scripts/deployment/test-uvicorn-local.sh

test-uvicorn-local-windows:
    @powershell -ExecutionPolicy Bypass -File scripts/deployment/test-uvicorn-local.ps1

# 📦 Raccolta file statici
collectstatic:
    just collectstatic-{{os()}}

collectstatic-macos:
    @ printf "\033[36m📁 Raccolta file statici (macOS)...\033[0m\n"
    @ {{django_manage}} collectstatic --no-input --clear

collectstatic-linux:
    @ printf "\033[36m📁 Raccolta file statici (Linux)...\033[0m\n"
    @ {{django_manage}} collectstatic --no-input --clear

collectstatic-windows:
    @Write-Host "📁 Raccolta file statici (Windows)..." -ForegroundColor Cyan
    @{{django_manage}} collectstatic --no-input --clear

collectstatic-dev:
    just collectstatic-dev-{{os()}}

collectstatic-dev-macos:
    @ printf "\033[36m📁 Raccolta file statici in ambiente DEV (macOS)...\033[0m\n"
    @ DJANGO_ENV="dev" {{django_manage}} collectstatic --no-input --clear

collectstatic-dev-linux:
    @ printf "\033[36m📁 Raccolta file statici in ambiente DEV (Linux)...\033[0m\n"
    @ DJANGO_ENV="dev" {{django_manage}} collectstatic --no-input --clear

collectstatic-dev-windows:
    @Write-Host "📁 Raccolta file statici in ambiente DEV (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="dev" {{django_manage}} collectstatic --no-input --clear

collectstatic-test:
    just collectstatic-test-{{os()}}

collectstatic-test-macos:
    @ printf "\033[36m📁 Raccolta file statici in ambiente TEST (macOS)...\033[0m\n"
    @ DJANGO_ENV="test" {{django_manage}} collectstatic --no-input --clear

collectstatic-test-linux:
    @ printf "\033[36m📁 Raccolta file statici in ambiente TEST (Linux)...\033[0m\n"
    @ DJANGO_ENV="test" {{django_manage}} collectstatic --no-input --clear

collectstatic-test-windows:
    @Write-Host "📁 Raccolta file statici in ambiente TEST (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="test" {{django_manage}} collectstatic --no-input --clear

collectstatic-staging:
    just collectstatic-staging-{{os()}}

collectstatic-staging-macos:
    @ printf "\033[36m📁 Raccolta file statici in ambiente STAGING (macOS)...\033[0m\n"
    @ DJANGO_ENV="staging" {{django_manage}} collectstatic --no-input --clear

collectstatic-staging-linux:
    @ printf "\033[36m📁 Raccolta file statici in ambiente STAGING (Linux)...\033[0m\n"
    @ DJANGO_ENV="staging" {{django_manage}} collectstatic --no-input --clear

collectstatic-staging-windows:
    @Write-Host "📁 Raccolta file statici in ambiente STAGING (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="staging" {{django_manage}} collectstatic --no-input --clear

collectstatic-prod:
    just collectstatic-prod-{{os()}}

collectstatic-prod-macos:
    @ printf "\033[36m📁 Raccolta file statici in ambiente PROD (macOS)...\033[0m\n"
    @ DJANGO_ENV="prod" {{django_manage}} collectstatic --no-input --clear

collectstatic-prod-linux:
    @ printf "\033[36m📁 Raccolta file statici in ambiente PROD (Linux)...\033[0m\n"
    @ DJANGO_ENV="prod" {{django_manage}} collectstatic --no-input --clear

collectstatic-prod-windows:
    @Write-Host "📁 Raccolta file statici in ambiente PROD (Windows)..." -ForegroundColor Cyan
    @DJANGO_ENV="prod" {{django_manage}} collectstatic --no-input --clear

# 🌐 Apre la home page nel browser
open-home:
    just open-home-{{os()}}

open-home-macos:
    @ printf "\033[36m🌐 Apro la home del sito in browser (macOS)...\033[0m\n"
    @ open "http://localhost:8000"

open-home-linux:
    @ printf "\033[36m🌐 Apro la home del sito in browser (Linux)...\033[0m\n"
    @ xdg-open "http://localhost:8000"

open-home-windows:
    @Write-Host "🌐 Apro la home del sito in browser (Windows)..." -ForegroundColor Cyan
    start "http://localhost:8000"

# === SERVER MANAGEMENT ===

# 🛑 Ferma tutti i server Django
stop-servers:
    just stop-servers-{{os()}}

stop-servers-macos:
    @ printf "\033[36m🛑 Arresto di tutti i server (macOS)...\033[0m\n"
    @ pkill -f "uvicorn|waitress|manage.py runserver" || true

stop-servers-linux:
    @ printf "\033[36m🛑 Arresto di tutti i server (Linux)...\033[0m\n"
    @ pkill -f "uvicorn|waitress|manage.py runserver" || true

stop-servers-windows:
    @Write-Host "🛑 Arresto di tutti i server (Windows)..." -ForegroundColor Red
    Stop-Process -Name "python", "uvicorn", "waitress" -ErrorAction SilentlyContinue

# 🔪 Termina processi sulla porta 8000
kill-port:
    just kill-port-{{os()}}

kill-port-macos:
    @ printf "\033[36m🔪 Terminazione processo sulla porta 8000 (macOS)...\033[0m\n"
    @ lsof -ti:8000 | xargs kill -9 || true

kill-port-linux:
    @ printf "\033[36m🔪 Terminazione processo sulla porta 8000 (Linux)...\033[0m\n"
    @ lsof -ti:8000 | xargs kill -9 || true

kill-port-windows:
    @Write-Host "🔪 Terminazione processo sulla porta 8000 (Windows)..." -ForegroundColor Red
    $pids = Get-NetTCPConnection -LocalPort 8000 | Select-Object -ExpandProperty OwningProcess
    foreach ($pid in $pids) { Stop-Process -Id $pid -Force }
# === ENVIRONMENT CHECKS ===

# 🔍 Controllo ambiente corrente
check-env:
    just check-env-{{os()}}

check-env-macos:
    @ printf "\033[36m🔍 Controllo ambiente (macOS)...\033[0m\n"
    @ {{python}} tools/check_env.py

check-env-linux:
    @ printf "\033[36m🔍 Controllo ambiente (Linux)...\033[0m\n"
    @ {{python}} tools/check_env.py

check-env-windows:
    @Write-Host "🔍 Controllo ambiente (Windows)..." -ForegroundColor Cyan
    {{python}} tools/check_env.py

check-env-dev:
    just check-env-dev-{{os()}}

check-env-dev-macos:
    @ printf "\033[36m🔍 Controllo ambiente DEV (macOS)...\033[0m\n"
    @ DJANGO_ENV="dev" {{python}} tools/check_env.py

check-env-dev-linux:
    @ printf "\033[36m🔍 Controllo ambiente DEV (Linux)...\033[0m\n"
    @ DJANGO_ENV="dev" {{python}} tools/check_env.py

check-env-dev-windows:
    @Write-Host "🔍 Controllo ambiente DEV (Windows)..." -ForegroundColor Cyan
    $env:DJANGO_ENV="dev"; {{python}} tools/check_env.py

check-env-test:
    just check-env-test-{{os()}}

check-env-test-macos:
    @ printf "\033[36m🔍 Controllo ambiente TEST (macOS)...\033[0m\n"
    @ DJANGO_ENV="test" {{python}} tools/check_env.py

check-env-test-linux:
    @ printf "\033[36m🔍 Controllo ambiente TEST (Linux)...\033[0m\n"
    @ DJANGO_ENV="test" {{python}} tools/check_env.py

check-env-test-windows:
    @Write-Host "🔍 Controllo ambiente TEST (Windows)..." -ForegroundColor Cyan
    $env:DJANGO_ENV="test"; {{python}} tools/check_env.py

check-env-staging:
    just check-env-staging-{{os()}}

check-env-staging-macos:
    @ printf "\033[36m🔍 Controllo ambiente STAGING (macOS)...\033[0m\n"
    @ DJANGO_ENV="staging" {{python}} tools/check_env.py

check-env-staging-linux:
    @ printf "\033[36m🔍 Controllo ambiente STAGING (Linux)...\033[0m\n"
    @ DJANGO_ENV="staging" {{python}} tools/check_env.py

check-env-staging-windows:
    @Write-Host "🔍 Controllo ambiente STAGING (Windows)..." -ForegroundColor Cyan
    $env:DJANGO_ENV="staging"; {{python}} tools/check_env.py

check-env-prod:
    just check-env-prod-{{os()}}

check-env-prod-macos:
    @ printf "\033[36m🔍 Controllo ambiente PROD (macOS)...\033[0m\n"
    @ DJANGO_ENV="prod" {{python}} tools/check_env.py

check-env-prod-linux:
    @ printf "\033[36m🔍 Controllo ambiente PROD (Linux)...\033[0m\n"
    @ DJANGO_ENV="prod" {{python}} tools/check_env.py

check-env-prod-windows:
    @Write-Host "🔍 Controllo ambiente PROD (Windows)..." -ForegroundColor Cyan
    $env:DJANGO_ENV="prod"; {{python}} tools/check_env.py
# === CORPORATE COMMANDS ===

# 🏢 Pre-commit con configurazione corporate
@precommit-corporate:
    just precommit-corporate-{{os()}}

precommit-corporate-macos:
    @ printf "\033[35m🏢 Esecuzione pre-commit con configurazione corporate (macOS)...\033[0m\n"
    @ if [ -f .pre-commit-config-corporate.yaml ]; then \
        pre-commit run --all-files --config .pre-commit-config-corporate.yaml; result=$?; \
    else \
        printf "\033[31m⚠️  File .pre-commit-config-corporate.yaml non trovato!\033[0m\n"; \
        printf "\033[33m💡 Usando configurazione standard...\033[0m\n"; \
        pre-commit run --all-files; result=$?; \
    fi; \
    if [ $result -eq 0 ]; then \
        printf "\033[32m✅ Tutti i controlli pre-commit superati!\033[0m\n"; \
    elif [ $result -eq 1 ]; then \
        printf "\033[33m🔧 Pre-commit ha corretto automaticamente alcuni problemi!\033[0m\n"; \
        printf "\033[36m💡 Rivedi le modifiche e committa se necessario.\033[0m\n"; \
    else \
        printf "\033[31m❌ Errori durante l'esecuzione pre-commit (exit code: $result)\033[0m\n"; \
        exit $result; \
    fi

precommit-corporate-linux:
    @ printf "\033[35m🏢 Esecuzione pre-commit con configurazione corporate (Linux)...\033[0m\n"
    @ if [ -f .pre-commit-config-corporate.yaml ]; then \
        pre-commit run --all-files --config .pre-commit-config-corporate.yaml; result=$?; \
    else \
        printf "\033[31m⚠️  File .pre-commit-config-corporate.yaml non trovato!\033[0m\n"; \
        printf "\033[33m💡 Usando configurazione standard...\033[0m\n"; \
        pre-commit run --all-files; result=$?; \
    fi; \
    if [ $result -eq 0 ]; then \
        printf "\033[32m✅ Tutti i controlli pre-commit superati!\033[0m\n"; \
    elif [ $result -eq 1 ]; then \
        printf "\033[33m🔧 Pre-commit ha corretto automaticamente alcuni problemi!\033[0m\n"; \
        printf "\033[36m💡 Rivedi le modifiche e committa se necessario.\033[0m\n"; \
    else \
        printf "\033[31m❌ Errori durante l'esecuzione pre-commit (exit code: $result)\033[0m\n"; \
        exit $result; \
    fi

precommit-corporate-windows:
    @Write-Host "🏢 Esecuzione pre-commit con configurazione corporate (Windows)..." -ForegroundColor Magenta
    if (Test-Path ".pre-commit-config-corporate.yaml") {
    pre-commit run --all-files --config .pre-commit-config-corporate.yaml
    $result = $LASTEXITCODE
    } else {
    Write-Host "⚠️  File .pre-commit-config-corporate.yaml non trovato!" -ForegroundColor Red
    Write-Host "💡 Usando configurazione standard..." -ForegroundColor Yellow
    pre-commit run --all-files
    $result = $LASTEXITCODE
    }
    if ($result -eq 0) {
    Write-Host "✅ Tutti i controlli pre-commit superati!" -ForegroundColor Green
    } elseif ($result -eq 1) {
    Write-Host "🔧 Pre-commit ha corretto automaticamente alcuni problemi!" -ForegroundColor Yellow
    Write-Host "💡 Rivedi le modifiche e committa se necessario." -ForegroundColor Cyan
    } else {
    Write-Host "❌ Errori durante l'esecuzione pre-commit (exit code: $result)" -ForegroundColor Red
    exit $result
    }

# 🏢 Quality checks corporate (alternativi)
@quality-corporate:
    just quality-corporate-{{os()}}

quality-corporate-macos:
    @ printf "\033[35m🏢 Controlli qualità corporate (macOS)...\033[0m\n"
    @ printf "\033[36m🔍 1. Controlli pre-commit corporate...\033[0m\n"
    just precommit-corporate
    @ printf "\033[36m📊 2. Controlli Codacy...\033[0m\n"
    just lint-codacy
    @ printf "\033[36m📝 3. Aggiunta docstring...\033[0m\n"
    just add-docstrings

quality-corporate-linux:
    @ printf "\033[35m🏢 Controlli qualità corporate (Linux)...\033[0m\n"
    @ printf "\033[36m🔍 1. Controlli pre-commit corporate...\033[0m\n"
    just precommit-corporate
    @ printf "\033[36m📊 2. Controlli Codacy...\033[0m\n"
    just lint-codacy
    @ printf "\033[36m📝 3. Aggiunta docstring...\033[0m\n"
    just add-docstrings

quality-corporate-windows:
    @Write-Host "🏢 Controlli qualità corporate (Windows)..." -ForegroundColor Magenta
    @Write-Host "🔍 1. Controlli pre-commit corporate..." -ForegroundColor Cyan
    just precommit-corporate
    @Write-Host "📊 2. Controlli Codacy..." -ForegroundColor Cyan
    just lint-codacy
    @Write-Host "📝 3. Aggiunta docstring..." -ForegroundColor Cyan
    just add-docstrings

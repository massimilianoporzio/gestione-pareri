# Coverage con PostgreSQL e pulizia DB
@coverage-postgres:
    just coverage-postgres-{{os()}}

coverage-postgres-macos:
    @just db-test-clean
    @printf "\033[33m📊 Coverage: esecuzione test con coverage e PostgreSQL...\033[0m\n"
    @cd src && DJANGO_ENV="test" uv run coverage run manage.py test
    @cd src && uv run coverage report
    @cd src && uv run coverage html -d ../htmlcov
    @cd src && uv run coverage xml
    @printf "\033[32mReport HTML generato in htmlcov/index.html\033[0m\n"
    @code htmlcov/index.html
    @printf "\033[33mPer visualizzare il report renderizzato, apri htmlcov/index.html con l'estensione Live Preview in VS Code.\033[0m\n"

coverage-postgres-linux:
    @just db-test-clean
    @printf "\033[33m📊 Coverage: esecuzione test con coverage e PostgreSQL...\033[0m\n"
    @cd src && DJANGO_ENV="test" uv run coverage run manage.py test
    @cd src && uv run coverage report
    @cd src && uv run coverage html -d ../htmlcov
    @cd src && uv run coverage xml
    @printf "\033[32mReport HTML generato in htmlcov/index.html\033[0m\n"
    @code htmlcov/index.html
    @printf "\033[33mPer visualizzare il report renderizzato, apri htmlcov/index.html con l'estensione Live Preview in VS Code.\033[0m\n"

coverage-postgres-windows:
    @just db-test-clean
    @Write-Host "📊 Coverage: esecuzione test con coverage e PostgreSQL..." -ForegroundColor Yellow
    cd src; $env:DJANGO_ENV="test"; uv run coverage run manage.py test
    cd src; uv run coverage report
    cd src; uv run coverage html -d ..\htmlcov
    cd src; uv run coverage xml
    @Write-Host "Report HTML generato in htmlcov/index.html" -ForegroundColor Green
    @Start-Process htmlcov/index.html
    @Write-Host "Per visualizzare il report renderizzato, apri htmlcov/index.html con l'estensione Live Preview in VS Code." -ForegroundColor Yellow
coverage-clean:
    @rm -f .coverage
    @rm -rf htmlcov

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
    @ printf "\033[32m  just test-sqlite        🧪 Test veloce (SQLite, default)\033[0m\n";
    @ printf "\033[32m  just test-postgres      🧪 Test realistico (PostgreSQL, pulizia DB)\033[0m\n";
    @ printf "\033[32m  just test-dev           🔧 Test ambiente DEV\033[0m\n";
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

# Test Coverage cross-platform
@coverage:
    just coverage-clean
    just coverage-{{os()}}

coverage-windows:
    @Write-Host "📊 Coverage: esecuzione test con coverage..." -ForegroundColor Yellow
    @cd src; uv run coverage run manage.py test
    @cd src; uv run coverage report
    @cd src; uv run coverage html -d ..\htmlcov
    @cd src; uv run coverage xml
    @Write-Host "Report HTML generato in htmlcov/index.html" -ForegroundColor Green
    @Start-Process htmlcov/index.html
    @Write-Host "Per visualizzare il report renderizzato, apri htmlcov/index.html con l'estensione Live Preview in VS Code." -ForegroundColor Yellow

coverage-macos:
    @printf "\033[33m📊 Coverage: esecuzione test con coverage...\033[0m\n"
    @cd src && uv run coverage run manage.py test
    @cd src && uv run coverage report
    @cd src && uv run coverage html -d ../htmlcov
    @cd src && uv run coverage xml
    @printf "\033[32mReport HTML generato in htmlcov/index.html\033[0m\n"
    @code htmlcov/index.html
    @printf "\033[33mPer visualizzare il report renderizzato, apri htmlcov/index.html con l'estensione Live Preview in VS Code.\033[0m\n"

coverage-linux:
    @printf "\033[33m📊 Coverage: esecuzione test con coverage...\033[0m\n"
    @cd src && uv run coverage run manage.py test
    @cd src && uv run coverage report
    @cd src && uv run coverage html -d ../htmlcov
    @cd src && uv run coverage xml
    @printf "\033[32mReport HTML generato in htmlcov/index.html\033[0m\n"
    @code htmlcov/index.html
    @printf "\033[33mPer visualizzare il report renderizzato, apri htmlcov/index.html con l'estensione Live Preview in VS Code.\033[0m\n"
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
deploy-nginx:
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

# 🧪 Test veloce (SQLite, default)
@test-sqlite:
    just test-sqlite-{{os()}}

test-sqlite-macos:
    @ printf "\033[36m🧪 Esecuzione dei test veloce (SQLite, macOS)...\033[0m\n"
    @ cd src && uv run manage.py test

test-sqlite-linux:
    @ printf "\033[36m🧪 Esecuzione dei test veloce (SQLite, Linux)...\033[0m\n"
    @ cd src && uv run manage.py test

test-sqlite-windows:
    @Write-Host "🧪 Esecuzione dei test veloce (SQLite, Windows)..." -ForegroundColor Cyan
    @cd src; uv run manage.py test

# 🧪 Test realistico (PostgreSQL, pulizia DB)
@test-postgres:
    just test-postgres-{{os()}}

test-postgres-macos:
    @just db-test-clean
    @ printf "\033[36m🧪 Esecuzione dei test realistico (PostgreSQL, macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py test

test-postgres-linux:
    @just db-test-clean
    @ printf "\033[36m🧪 Esecuzione dei test realistico (PostgreSQL, Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py test

test-postgres-windows:
    @just db-test-clean
    @Write-Host "🧪 Esecuzione dei test realistico (PostgreSQL, Windows)..." -ForegroundColor Cyan
    cd src; $env:DJANGO_ENV="test"; uv run manage.py test
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
    @just db-test-clean
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente TEST (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py test

test-test-linux:
    @just db-test-clean
    @ printf "\033[36m🧪 Esecuzione dei test in ambiente TEST (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py test

test-test-windows:
    @just db-test-clean
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

# 🔄 Clean & recreate test database PostgreSQL
@db-test-clean:
    just db-test-clean-{{os()}}

db-test-clean-macos:
    @uv run scripts/db_test_clean.py

db-test-clean-linux:
    @uv run scripts/db_test_clean.py

db-test-clean-windows:
    @uv run scripts/db_test_clean.py

set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Variabili globali
python := "uv run"
django_manage := "uv run src/manage.py"


# ricetta default
@default:
    just default-{{os()}}

default-linux:
    just default-macos

default-macos:
    @ printf "\033[35m🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI\033[0m\n";
    @ printf "\033[90m============================================================\033[0m\n";
    @ printf "\n";
    @ printf "\033[32m📊 DJANGO & DATABASE:\033[0m\n";
    @ printf "  just run-server         🚀 Server di sviluppo Django\n";
    @ printf "  just run-dev            🔧 Server sviluppo (DEV)\n";
    @ printf "  just run-test           🧪 Server sviluppo (TEST)\n";
    @ printf "  just run-staging        🎭 Server sviluppo (STAGING)\n";
    @ printf "  just run-prod           ⚡ Server sviluppo (PROD)\n";
    @ printf "  just migrate            📦 Migrazioni database\n";
    @ printf "  just migrate-dev        🛠️ Migrazioni database dev\n";
    @ printf "  just migrate-test       🧪 Migrazioni database test\n";
    @ printf "  just migrate-staging    🎭 Migrazioni database staging\n";
    @ printf "  just migrate-prod       🚀 Migrazioni database prod\n";
    @ printf "  just makemigrations     📝 Crea migrazioni\n";
    @ printf "  just shell              🐚 Shell Django\n";
    @ printf "  just test-sqlite        🧪 Test veloce (SQLite, default)\n";
    @ printf "  just test-postgres      🧪 Test realistico (PostgreSQL, pulizia DB)\n";
    @ printf "  just test-dev           🔧 Test ambiente DEV\n";
    @ printf "  just test-staging       🎭 Test ambiente STAGING\n";
    @ printf "  just test-prod          ⚡ Test ambiente PROD\n";
    @ printf "\n";
    @ printf "\033[36m🌐 SERVER & DEPLOY:\033[0m\n";
    @ printf "  just nginx-generate-conf     📝 Genera file configurazione Nginx\n";
    @ printf "  just nginx-copy-conf         📋 Copia file configurazione Nginx\n";
    @ printf "  just nginx-reload            🔄 Riavvia/reload Nginx\n";
    @ printf "  just run-uvicorn-prod        ⚡ Uvicorn produzione (cross-platform)\n";
    @ printf "  just deploy-nginx-steps      🚀 Deploy Nginx step-by-step (cross-platform)\n";
    @ printf "  just deploy-nginx            🚀 Deploy completo con Nginx\n";
    @ printf "  just setup-nginx             🌐 Configura Nginx reverse proxy\n";
    @ printf "  just status-nginx            📊 Status servizi Nginx/Django\n";
    @ printf "  just stop-servers            🛑 Ferma tutti i server\n";
    @ printf "  just kill-port               🔪 Termina processo porta 8000\n";
    @ printf "\n";
    @ printf "\033[33m🔧 QUALITY & FORMAT:\033[0m\n";
    @ printf "  just fix-all            ⭐ CORREZIONE GLOBALE completa\n";
    @ printf "  just lint-codacy        🔍 Controlli qualità Codacy\n";
    @ printf "  just add-docstrings     📝 Aggiunge docstring mancanti\n";
    @ printf "  just precommit-corporate 🏢 Pre-commit aziendale\n";
    @ printf "  just quality-corporate  🏢 Quality controlli alternativi\n";
    @ printf "  just fix-markdown       📝 Corregge problemi Markdown\n";
    @ printf "\n";
    @ printf "\033[97mℹ️  UTILITY:\033[0m\n";
    @ printf "  just stats              📊 Statistiche progetto\n";
    @ printf "  just check-env          🔍 Controllo ambiente\n";
    @ printf "  just check-env-dev      🔍 Controllo ambiente DEV\n";
    @ printf "  just check-env-test     🧪 Controllo ambiente TEST\n";
    @ printf "  just check-env-staging  🎭 Controllo ambiente STAGING\n";
    @ printf "  just check-env-prod     ⚡ Controllo ambiente PROD\n";
    @ printf "  just generate-secret-key 🔑 Genera Django SECRET_KEY\n";
    @ printf "  just generate-secret-keys-all 🔐 Genera SECRET_KEY per tutti e 4 gli ambienti\n";
    @ printf "  just generate-db-passwords 🔐 Genera password PostgreSQL sicure\n";
    @ printf "  just create-db-script   🗄️ Crea script SQL con password reali\n";
    @ printf "  just --list             📋 Lista completa comandi\n"
# === NGINX/Uvicorn cross-platform ===


# Wrapper cross-platform per caricare variabili da .env


# Wrapper per esportare solo DJANGO_SUBPATH e SERVER_IP da .env (safe)

dotenv_win_safe := "$lines = Get-Content .env | Where-Object { $_ -match '^(DJANGO_SUBPATH|SERVER_IP)=' }; foreach ($line in $lines) { $pair = $line -split '=',2; if ($pair.Length -eq 2) { Set-Item -Path Env:$($pair[0].Trim()) -Value $pair[1].Trim() } }"

# 1. Genera file di configurazione Nginx (cross-platform)
@nginx-generate-conf:
    just nginx-generate-conf-{{os()}}


nginx-generate-conf-macos:
    DJANGO_SUBPATH=$(grep '^DJANGO_SUBPATH=' .env | cut -d'=' -f2-) SERVER_IP=$(grep '^SERVER_IP=' .env | cut -d'=' -f2-) uv run scripts/deployment/generate_nginx_conf.py


nginx-generate-conf-linux:
    DJANGO_SUBPATH=$(grep '^DJANGO_SUBPATH=' .env | cut -d'=' -f2-) SERVER_IP=$(grep '^SERVER_IP=' .env | cut -d'=' -f2-) uv run scripts/deployment/generate_nginx_conf.py

nginx-generate-conf-windows:
    powershell -Command "${dotenv_win_safe}; uv run scripts/deployment/generate_nginx_conf.py"

# 2. Copia file di configurazione Nginx (macOS/Linux/Windows)
@nginx-copy-conf:
    just nginx-copy-conf-{{os()}}


nginx-copy-conf-macos:
    DJANGO_SUBPATH=$(grep '^DJANGO_SUBPATH=' .env | cut -d'=' -f2-) sudo cp scripts/deployment/nginx_$(grep '^DJANGO_SUBPATH=' .env | cut -d'=' -f2-).conf /opt/homebrew/etc/nginx/gestione-pareri.conf


nginx-copy-conf-linux:
    DJANGO_SUBPATH=$(grep '^DJANGO_SUBPATH=' .env | cut -d'=' -f2-) sudo cp scripts/deployment/nginx_$(grep '^DJANGO_SUBPATH=' .env | cut -d'=' -f2-).conf /etc/nginx/sites-available/gestione-pareri && sudo ln -sf /etc/nginx/sites-available/gestione-pareri /etc/nginx/sites-enabled/

nginx-copy-conf-windows:
    powershell -Command "${dotenv_win_safe}; Copy-Item -Path 'scripts/deployment/nginx_$env:DJANGO_SUBPATH.conf' -Destination 'C:\nginx\conf\gestione-pareri.conf' -Force"

# 3. Riavvia/reload Nginx (macOS/Linux/Windows)
@nginx-reload:
    just nginx-reload-{{os()}}

nginx-reload-macos:
    brew services restart nginx

nginx-reload-linux:
    sudo systemctl reload nginx

nginx-reload-windows:
    Stop-Process -Name nginx -Force -ErrorAction SilentlyContinue; Start-Process "C:\nginx\nginx.exe"

# 4. Ricetta unica: deploy step-by-step (cross-platform)
@deploy-nginx-steps:
    just nginx-generate-conf
    just nginx-copy-conf
    just nginx-reload
    just run-uvicorn-prod

default-windows:
    @Write-Host "🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI" -ForegroundColor Magenta;
    @Write-Host "============================================================" -ForegroundColor Gray;
    @Write-Host "";
    @Write-Host "📊 DJANGO & DATABASE:" -ForegroundColor Green;
    @Write-Host "  just run-server         🚀 Server di sviluppo Django" -ForegroundColor Green;
    @Write-Host "  just run-dev            🛠️ Server sviluppo (DEV)" -ForegroundColor Green;
    @Write-Host "  just run-test           🧪 Server sviluppo (TEST)" -ForegroundColor Green;
    @Write-Host "  just run-staging        🎭 Server sviluppo (STAGING)" -ForegroundColor Green;
    @Write-Host "  just run-prod           ⚡ Server sviluppo (PROD)" -ForegroundColor Green;
    @Write-Host "  just migrate            📦 Migrazioni database" -ForegroundColor Green;
    @Write-Host "  just migrate-dev        🛠️ Migrazioni database dev" -ForegroundColor Green;
    @Write-Host "  just migrate-test       🧪 Migrazioni database test" -ForegroundColor Green;
    @Write-Host "  just migrate-staging    🎭 Migrazioni database staging" -ForegroundColor Green;
    @Write-Host "  just migrate-prod       🚀 Migrazioni database prod" -ForegroundColor Green;
    @Write-Host "  just makemigrations     📝 Crea migrazioni" -ForegroundColor Green;
    @Write-Host "  just shell              🐚 Shell Django" -ForegroundColor Green;
    @Write-Host "  just test-sqlite        🧪 Test veloce (SQLite, default)" -ForegroundColor Green;
    @Write-Host "  just test-postgres      🧪 Test realistico (PostgreSQL, pulizia DB)" -ForegroundColor Green;
    @Write-Host "  just test-dev           🔧 Test ambiente DEV" -ForegroundColor Green;
    @Write-Host "  just test-staging       🎭 Test ambiente STAGING" -ForegroundColor Green;
    @Write-Host "  just test-prod          ⚡ Test ambiente PROD" -ForegroundColor Green;
    @Write-Host "";
    @Write-Host "🌐 SERVER & DEPLOY:" -ForegroundColor Cyan;
    @Write-Host "  just run-uvicorn        ⚡ Server Uvicorn ASGI" -ForegroundColor Cyan;
    @Write-Host "  just run-uvicorn-prod   ⚡ Uvicorn produzione (cross-platform)" -ForegroundColor Cyan;
# === Uvicorn produzione cross-platform ===
@run-uvicorn-prod:
    just run-uvicorn-prod-{{os()}}

run-uvicorn-prod-macos:
    @ printf "\033[32m⚡ Avvio Uvicorn in produzione (macOS)...\033[0m\n"
    @ uv run -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --workers 4 --env-file .env --app-dir src

run-uvicorn-prod-linux:
    @ printf "\033[32m⚡ Avvio Uvicorn in produzione (Linux)...\033[0m\n"
    @ uv run -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --workers 4 --env-file .env --app-dir src

run-uvicorn-prod-windows:
    @Write-Host "⚡ Avvio Uvicorn in produzione (Windows)..." -ForegroundColor Green
    uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --workers 4 --env-file .env
    @Write-Host "  just setup-nginx        🌐 Configura Nginx reverse proxy" -ForegroundColor Cyan;
    @Write-Host "  just deploy-nginx       🚀 Deploy completo con Nginx" -ForegroundColor Cyan;
    @Write-Host "  just status-nginx       📊 Status servizi Nginx/Django" -ForegroundColor Cyan;
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
@test-test:
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
@migrate:
    just migrate-{{os()}}

migrate-windows:
    @Write-Host "📦 Migrazione database (Windows)..." -ForegroundColor Green
    cd src; $env:DJANGO_ENV="dev"; uv run manage.py migrate
migrate-linux:
    @ printf "\033[32m📦 Migrazione database (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="dev" uv run manage.py migrate
migrate-macos:
    @ printf "\033[32m📦 Migrazione database (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="dev" uv run manage.py migrate

@migrate-test:
    just migrate-test-{{os()}}

migrate-test-windows:
    @Write-Host "📦 Migrazione database (Windows)..." -ForegroundColor Green
    cd src; $env:DJANGO_ENV="test"; uv run manage.py migrate
migrate-test-linux:
    @ printf "\033[32m📦 Migrazione database (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py migrate
migrate-test-macos:
    @ printf "\033[32m📦 Migrazione database (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="test" uv run manage.py migrate

@migrate-staging:
    just migrate-staging-{{os()}}

migrate-staging-windows:
    @Write-Host "📦 Migrazione database (Windows)..." -ForegroundColor Green
    cd src; $env:DJANGO_ENV="staging"; uv run manage.py migrate
migrate-staging-linux:
    @ printf "\033[32m📦 Migrazione database (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="staging" uv run manage.py migrate
migrate-staging-macos:
    @ printf "\033[32m📦 Migrazione database (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="staging" uv run manage.py migrate

@migrate-prod:
    just migrate-prod-{{os()}}

migrate-prod-windows:
    @Write-Host "📦 Migrazione database (Windows)..." -ForegroundColor Green
    cd src; $env:DJANGO_ENV="prod"; uv run manage.py migrate
migrate-prod-linux:
    @ printf "\033[32m📦 Migrazione database (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="prod" uv run manage.py migrate
migrate-prod-macos:
    @ printf "\033[32m📦 Migrazione database (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="prod" uv run manage.py migrate


@migrate-dev:
    just migrate-dev-{{os()}}

migrate-dev-windows:
    @Write-Host "📦 Migrazione database (Windows)..." -ForegroundColor Green
    cd src; $env:DJANGO_ENV="dev"; uv run manage.py migrate
migrate-dev-linux:
    @ printf "\033[32m📦 Migrazione database (macOS)...\033[0m\n"
    @ cd src && DJANGO_ENV="dev" uv run manage.py migrate
migrate-dev-macos:
    @ printf "\033[32m📦 Migrazione database (Linux)...\033[0m\n"
    @ cd src && DJANGO_ENV="dev" uv run manage.py migrate

# 🔄 Clean & recreate test database PostgreSQL
@db-test-clean:
    just db-test-clean-{{os()}}

db-test-clean-macos:
    @uv run scripts/db_test_clean.py

db-test-clean-linux:
    @uv run scripts/db_test_clean.py

db-test-clean-windows:
    @uv run scripts/db_test_clean.py

# === ENVIRONMENT CHECKS ===

# 🔍 Controllo ambiente corrente
@check-env:
    just check-env-{{os()}}

check-env-windows:
    @Write-Host "🔍 Controllo dell'ambiente corrente..." -ForegroundColor Cyan
    @{{python}} src/test_logging.py

check-env-macos:
    @printf "\033[36m🔍 Controllo dell'ambiente corrente...\033[0m\n"
    @{{python}} src/test_logging.py

check-env-linux:
    @printf "\033[36m🔍 Controllo dell'ambiente corrente...\033[0m\n"
    @{{python}} src/test_logging.py

# 🔍 Controllo ambiente DEV
@check-env-dev:
    just check-env-dev-{{os()}}

check-env-dev-windows:
    @Write-Host "🔍 Controllo dell'ambiente DEV..." -ForegroundColor Cyan
    cd src; $env:DJANGO_ENV="dev"; uv run test_logging.py

check-env-dev-macos:
    @printf "\033[36m🔍 Controllo dell'ambiente DEV...\033[0m\n"
    @DJANGO_ENV="dev" {{python}} src/test_logging.py

check-env-dev-linux:
    @printf "\033[36m🔍 Controllo dell'ambiente DEV...\033[0m\n"
    @DJANGO_ENV="dev" {{python}} src/test_logging.py

# 🔍 Controllo ambiente TEST
@check-env-test:
    just check-env-test-{{os()}}

check-env-test-windows:
    @Write-Host "🔍 Controllo dell'ambiente TEST..." -ForegroundColor Cyan
    cd src; $env:DJANGO_ENV="test"; uv run test_logging.py

check-env-test-macos:
    @printf "\033[36m🔍 Controllo dell'ambiente TEST...\033[0m\n"
    @DJANGO_ENV="test" {{python}} src/test_logging.py

check-env-test-linux:
    @printf "\033[36m🔍 Controllo dell'ambiente TEST...\033[0m\n"
    @DJANGO_ENV="test" {{python}} src/test_logging.py

# 🔍 Controllo ambiente STAGING
@check-env-staging:
    just check-env-staging-{{os()}}

check-env-staging-windows:
    @Write-Host "🎭 Controllo dell'ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL e logging su file!" -ForegroundColor Yellow
    cd src; $env:DJANGO_ENV="staging"; uv run test_logging.py

check-env-staging-macos:
    @printf "\033[36m🎭 Controllo dell'ambiente STAGING...\033[0m\n"
    @printf "\033[33m⚠️  STAGING usa PostgreSQL e logging su file!\033[0m\n"
    @DJANGO_ENV="staging" {{python}} src/test_logging.py

check-env-staging-linux:
    @printf "\033[36m🎭 Controllo dell'ambiente STAGING...\033[0m\n"
    @printf "\033[33m⚠️  STAGING usa PostgreSQL e logging su file!\033[0m\n"
    @DJANGO_ENV="staging" {{python}} src/test_logging.py

# 🔍 Controllo ambiente PROD
@check-env-prod:
    just check-env-prod-{{os()}}

check-env-prod-windows:
    @Write-Host "🔍 Controllo dell'ambiente PROD..." -ForegroundColor Cyan
    cd src; $env:DJANGO_ENV="prod"; uv run test_logging.py

check-env-prod-macos:
    @printf "\033[36m🔍 Controllo dell'ambiente PROD...\033[0m\n"
    @DJANGO_ENV="prod" {{python}} src/test_logging.py

check-env-prod-linux:
    @printf "\033[36m🔍 Controllo dell'ambiente PROD...\033[0m\n"
    @DJANGO_ENV="prod" {{python}} src/test_logging.py

@format-docs:
    just format-docs-{{os()}}

@format-docs-windows:
    Get-ChildItem src -Recurse -Filter *.py | ForEach-Object { uv run docformatter --in-place $_.FullName }

format-docs-macos:
    find src -name '*.py' -exec uv run docformatter --in-place {} +

format-docs-linux:
    find src -name '*.py' -exec uv run docformatter --in-place {} +

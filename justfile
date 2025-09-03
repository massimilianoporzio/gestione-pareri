# Deploy Django Template - Comandi disponibili con Just
# Per visualizzare tutti i comandi: just --list o just

# Configura shell per Windows
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Variabili globali
python := "uv run"
django_manage := "uv run src/manage.py"

# 📋 Comando default: mostra l'help
default:
    @Write-Host "🚀 DEPLOY DJANGO TEMPLATE - COMANDI DISPONIBILI" -ForegroundColor Magenta
    @Write-Host "============================================================" -ForegroundColor DarkGray
    @Write-Host ""
    @Write-Host "📊 DJANGO & DATABASE:" -ForegroundColor Green
    @Write-Host "  just run-server         🚀 Server di sviluppo Django" -ForegroundColor Green
    @Write-Host "  just run-dev            🔧 Server sviluppo (DEV)" -ForegroundColor Green
    @Write-Host "  just run-test           🧪 Server sviluppo (TEST)" -ForegroundColor Green
    @Write-Host "  just run-prod           ⚡ Server sviluppo (PROD)" -ForegroundColor Green
    @Write-Host "  just migrate            📦 Migrazioni database" -ForegroundColor Green
    @Write-Host "  just makemigrations     📝 Crea migrazioni" -ForegroundColor Green
    @Write-Host "  just shell              🐚 Shell Django" -ForegroundColor Green
    @Write-Host "  just test               🧪 Esegue test progetto" -ForegroundColor Green
    @Write-Host ""
    @Write-Host "🌐 SERVER & DEPLOY:" -ForegroundColor Cyan
    @Write-Host "  just waitress           🪟 Server Waitress (Windows)" -ForegroundColor Cyan
    @Write-Host "  just run-uvicorn        ⚡ Server Uvicorn ASGI" -ForegroundColor Cyan
    @Write-Host "  just deploy             🎯 Deploy automatico" -ForegroundColor Cyan
    @Write-Host "  just deploy-dev         🔧 Deploy development" -ForegroundColor Cyan
    @Write-Host "  just deploy-staging     🧪 Deploy staging" -ForegroundColor Cyan
    @Write-Host "  just deploy-prod        🚀 Deploy production" -ForegroundColor Cyan
    @Write-Host "  just stop-servers       🛑 Ferma tutti i server" -ForegroundColor Cyan
    @Write-Host "  just kill-port          🔪 Termina processo porta 8000" -ForegroundColor Cyan
    @Write-Host ""
    @Write-Host "🔧 QUALITY & FORMAT:" -ForegroundColor Yellow
    @Write-Host "  just fix-all            ⭐ CORREZIONE GLOBALE completa" -ForegroundColor Yellow
    @Write-Host "  just lint-codacy        🔍 Controlli qualità Codacy" -ForegroundColor Yellow
    @Write-Host "  just add-docstrings     📝 Aggiunge docstring mancanti" -ForegroundColor Yellow
    @Write-Host "  just fix-markdown       📝 Corregge problemi Markdown" -ForegroundColor Yellow
    @Write-Host ""
    @Write-Host "ℹ️  UTILITY:" -ForegroundColor White
    @Write-Host "  just stats              📊 Statistiche progetto" -ForegroundColor White
    @Write-Host "  just check-env          🔍 Controllo ambiente" -ForegroundColor White
    @Write-Host "  just check-env-dev      🔍 Controllo ambiente DEV" -ForegroundColor White
    @Write-Host "  just generate-secret-key 🔑 Genera Django SECRET_KEY" -ForegroundColor White
    @Write-Host "  just --list             📋 Lista completa comandi" -ForegroundColor White
    @Write-Host ""
    @Write-Host "🪟 WINDOWS IIS DEPLOYMENT:" -ForegroundColor Magenta
    @Write-Host "  just setup-iis          🌐 Configura IIS reverse proxy" -ForegroundColor Cyan
    @Write-Host "  just deploy-iis         🚀 Deploy completo con IIS" -ForegroundColor Cyan
    @Write-Host ""
    @Write-Host "🐧 LINUX/macOS NGINX:" -ForegroundColor Blue
    @Write-Host "  just setup-nginx        🌐 Configura Nginx reverse proxy" -ForegroundColor Blue
    @Write-Host "  just deploy-nginx       🚀 Deploy completo con Nginx" -ForegroundColor Blue

# === IIS DEPLOYMENT (Windows Server) ===

# 🌐 Setup IIS reverse proxy per Windows Server
setup-iis:
    @Write-Host "🌐 Configurazione IIS reverse proxy..." -ForegroundColor Cyan
    @Write-Host "⚠️  Richiede privilegi di amministratore!" -ForegroundColor Yellow
    @PowerShell -ExecutionPolicy Bypass -File "deployment\setup-iis.ps1"

# 🚀 Deploy completo per IIS
deploy-iis:
    @Write-Host "🚀 Deploy completo con IIS reverse proxy..." -ForegroundColor Magenta
    @Write-Host "1/4 - Installazione dipendenze produzione..." -ForegroundColor Yellow
    @uv sync --frozen
    @Write-Host "2/4 - Migrazioni database..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} migrate --no-input
    @Write-Host "3/4 - Raccolta file statici..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} collectstatic --no-input --clear
    @Write-Host "4/4 - Avvio server Uvicorn per IIS..." -ForegroundColor Yellow
    @Write-Host "🌐 Server disponibile per reverse proxy IIS" -ForegroundColor Green
    @$env:DJANGO_ENV="prod"; cd src; {{python}} -m uvicorn home.asgi:application --host 127.0.0.1 --port 8000 --workers 1 --log-level info

# === NGINX DEPLOYMENT (Linux/macOS) ===

# 🌐 Setup Nginx per Linux/macOS
setup-nginx:
    @Write-Host "🌐 Configurazione Nginx per Linux/macOS..." -ForegroundColor Blue
    @Write-Host "⚠️  Richiede privilegi sudo!" -ForegroundColor Yellow
    @Write-Host "1/4 - Copia configurazione Nginx..." -ForegroundColor Yellow
    sudo cp deployment/nginx.conf /etc/nginx/sites-available/gestione-pareri
    @Write-Host "2/4 - Abilita sito..." -ForegroundColor Yellow
    sudo ln -sf /etc/nginx/sites-available/gestione-pareri /etc/nginx/sites-enabled/
    @Write-Host "3/4 - Test configurazione..." -ForegroundColor Yellow
    sudo nginx -t
    @Write-Host "4/4 - Ricarica Nginx..." -ForegroundColor Yellow
    sudo systemctl reload nginx
    @Write-Host "✅ Nginx configurato con successo!" -ForegroundColor Green
    @Write-Host "🌐 Sito disponibile su: http://localhost" -ForegroundColor Green

# 🚀 Deploy completo con Nginx
deploy-nginx: install-prod
    @Write-Host "🚀 Deploy completo con Nginx..." -ForegroundColor Blue
    @Write-Host "1/5 - Installazione dipendenze..." -ForegroundColor Yellow
    @uv sync --frozen
    @Write-Host "2/5 - Migrazioni database..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} migrate --no-input
    @Write-Host "3/5 - Raccolta file statici..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} collectstatic --no-input --clear
    @Write-Host "4/5 - Riavvio Django service..." -ForegroundColor Yellow
    sudo systemctl restart gestione-pareri || echo "Service gestione-pareri non configurato"
    @Write-Host "5/5 - Reload Nginx..." -ForegroundColor Yellow
    sudo systemctl reload nginx
    @Write-Host "✅ Deploy Nginx completato!" -ForegroundColor Green
    @Write-Host "🌐 Server disponibile tramite Nginx reverse proxy" -ForegroundColor Green

# 📊 Status servizi Nginx
status-nginx:
    @Write-Host "📊 Status servizi Nginx..." -ForegroundColor Blue
    @Write-Host "=== NGINX STATUS ===" -ForegroundColor Cyan
    sudo systemctl status nginx --no-pager
    @Write-Host "" -ForegroundColor White
    @Write-Host "=== DJANGO SERVICE STATUS ===" -ForegroundColor Cyan
    sudo systemctl status gestione-pareri --no-pager || echo "Service gestione-pareri non configurato"

# === DJANGO COMMANDS ===

# 🚀 Server di sviluppo
run-server:
    @Write-Host "🚀 Avvio del server di sviluppo Django..." -ForegroundColor Cyan
    @{{django_manage}} runserver

# 🔧 Server di sviluppo in ambiente DEV
run-dev:
    @Write-Host "🔧 Avvio del server di sviluppo in ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} runserver

# 🧪 Server di sviluppo in ambiente TEST
run-test:
    @Write-Host "🧪 Avvio del server di sviluppo in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} runserver

# ⚡ Server di sviluppo in ambiente PROD
run-prod:
    @Write-Host "⚡ Avvio del server di sviluppo in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} runserver

# 🧪 Test del progetto
test:
    @Write-Host "🧪 Esecuzione dei test..." -ForegroundColor Cyan
    @{{django_manage}} test

# 🧪 Test in ambiente DEV
test-dev:
    @Write-Host "🧪 Esecuzione dei test in ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} test

# 🧪 Test in ambiente TEST
test-test:
    @Write-Host "🧪 Esecuzione dei test in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} test

# 🧪 Test in ambiente PROD
test-prod:
    @Write-Host "🧪 Esecuzione dei test in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} test

# 📦 Migrazioni database
migrate:
    @Write-Host "📦 Applicazione delle migrazioni..." -ForegroundColor Cyan
    @{{django_manage}} migrate

# 📦 Migrazioni in ambiente DEV
migrate-dev:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} migrate

# 📦 Migrazioni in ambiente TEST
migrate-test:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} migrate

# 📦 Migrazioni in ambiente PROD
migrate-prod:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} migrate

# 📝 Creazione migrazioni
makemigrations:
    @Write-Host "📝 Creazione delle migrazioni..." -ForegroundColor Cyan
    @{{django_manage}} makemigrations

# 🐚 Shell Django
shell:
    @Write-Host "🐚 Avvio della shell Django..." -ForegroundColor Cyan
    @{{django_manage}} shell

# 🐚 Shell Django DEV
shell-dev:
    @Write-Host "🐚 Avvio della shell Django in ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} shell

# 🐚 Shell Django TEST
shell-test:
    @Write-Host "🐚 Avvio della shell Django in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} shell

# 🐚 Shell Django PROD
shell-prod:
    @Write-Host "🐚 Avvio della shell Django in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} shell

# === QUALITY COMMANDS ===

# 📝 Aggiunge docstring mancanti
add-docstrings:
    @Write-Host "📝 Aggiunta docstring ai file Python del progetto..." -ForegroundColor Cyan
    @{{python}} tools/add_docstring_batch.py .

# ⭐ CORREZIONE GLOBALE: Fix all code quality issues
fix-all:
    @Write-Host "⭐ Correzione completa di tutti i problemi di qualità del codice..." -ForegroundColor Cyan
    @Write-Host "1/10 - Rimozione spazi finali..." -ForegroundColor Yellow
    @-pre-commit run trailing-whitespace --all-files
    @Write-Host "2/10 - Correzione fine file..." -ForegroundColor Yellow
    @-pre-commit run end-of-file-fixer --all-files
    @Write-Host "3/10 - Aggiunta docstring..." -ForegroundColor Yellow
    @-{{python}} tools/add_docstring_batch.py .
    @Write-Host "4/10 - Ordinamento import (isort style)..." -ForegroundColor Yellow
    @-{{python}} ruff check --select I --fix .
    @Write-Host "5/10 - Formattazione con Ruff..." -ForegroundColor Yellow
    @-{{python}} ruff format .
    @Write-Host "6/10 - Correzione automatica con Ruff..." -ForegroundColor Yellow
    @-{{python}} ruff check . --fix --unsafe-fixes
    @Write-Host "7/10 - Correzioni aggressive con autopep8..." -ForegroundColor Yellow
    @-{{python}} autopep8 --in-place --aggressive --aggressive --recursive .
    @Write-Host "8/10 - Formattazione finale con Ruff..." -ForegroundColor Yellow
    @-{{python}} ruff format .
    @Write-Host "9/10 - Formattazione Markdown..." -ForegroundColor Yellow
    @just format-markdown
    @Write-Host "10/10 - Correzione problemi Markdown..." -ForegroundColor Yellow
    @just fix-markdown
    @Write-Host "✅ Tutti i problemi di qualità del codice sono stati corretti!" -ForegroundColor Green

# 🔍 Test pre-commit hooks senza modifiche
test-precommit:
    @Write-Host "🔍 Test di tutti i controlli pre-commit..." -ForegroundColor Cyan
    @pre-commit run --all-files
    @Write-Host "✅ Test pre-commit completato!" -ForegroundColor Green

# 🔧 Correzione automatica script bash
fix-codacy:
    @Write-Host "🔧 Correzione automatica script bash..." -ForegroundColor Cyan
    @Get-ChildItem -Path "scripts/deployment" -Filter "*.sh" | ForEach-Object { shfmt -w $_.FullName }
    @Write-Host "✅ Correzioni applicate!" -ForegroundColor Green

# 📝 Formattazione file Markdown
format-markdown:
    @Write-Host "📝 Formattazione file Markdown..." -ForegroundColor Cyan
    @Get-ChildItem -Path . -Include "*.md" -Recurse | ForEach-Object { Write-Host "Formatting" $_.FullName; $content = Get-Content $_.FullName -Raw; if ($content) { $formatted = $content -replace "(?m)^[ \t]+$", "" -replace "(?m)\r?\n{3,}", "`n`n" -replace "(?m)[ \t]+$", ""; Set-Content $_.FullName -Value $formatted -NoNewline } }
    @Write-Host "✅ File Markdown formattati con successo!" -ForegroundColor Green

# 📝 Correzione problemi Markdown
fix-markdown:
    @Write-Host "📝 Correzione problemi Markdown..." -ForegroundColor Cyan
    @Write-Host "1/3 - Correzioni automatiche..." -ForegroundColor Yellow
    @{{python}} tools/fix_markdown.py
    @Write-Host "2/3 - Prettier formatting..." -ForegroundColor Yellow
    @-pre-commit run prettier --all-files
    @Write-Host "3/3 - Markdownlint validation..." -ForegroundColor Yellow
    @-pre-commit run markdownlint-cli2 --all-files
    @Write-Host "✅ Problemi Markdown corretti!" -ForegroundColor Green

# 🔍 Controlli qualità stile Codacy (semplificato)
lint-codacy:
    @Write-Host "🔍 Controlli qualità stile Codacy..." -ForegroundColor Cyan
    @Write-Host "1/3 - Ruff check..." -ForegroundColor Yellow
    @-{{python}} ruff check --output-format=github --exclude=.venv .
    @Write-Host "2/3 - Flake8..." -ForegroundColor Yellow
    @-{{python}} flake8 --format=default --exclude=.venv .
    @Write-Host "3/3 - Pylint..." -ForegroundColor Yellow
    @-{{python}} pylint src/home/ --output-format=colorized
    @Write-Host "✅ Controlli completati!" -ForegroundColor Green

# 📊 Statistiche progetto
stats:
    @Write-Host "📊 Generazione statistiche progetto..." -ForegroundColor Cyan
    @{{python}} tools/project_stats.py
    @Write-Host "📊 Dashboard disponibile in tools/quality_dashboard.md" -ForegroundColor Green

# 🔑 Genera Django SECRET_KEY
generate-secret-key:
    @Write-Host "🔑 Generazione Django SECRET_KEY..." -ForegroundColor Cyan
    @{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

# === DEPLOYMENT COMMANDS ===

# 📦 Installazione dipendenze produzione
install-prod:
    @Write-Host "📦 Installazione dipendenze produzione..." -ForegroundColor Cyan
    @uv sync --group prod

# 🔧 Deploy development
deploy-dev:
    @Write-Host "🔧 Avvio server di sviluppo..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="dev"; {{django_manage}} runserver

# 🧪 Deploy staging
deploy-staging:
    @Write-Host "🧪 Deploy staging (Windows - Uvicorn)..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="test"; powershell -ExecutionPolicy Bypass -File scripts/deployment/start-uvicorn.ps1 -DjangoEnv test

# 🚀 Deploy production
deploy-prod: install-prod
    @Write-Host "🚀 Deploy produzione (Windows - Uvicorn ASGI)..." -ForegroundColor Green
    @just run-uvicorn

# 🎯 Smart deploy automatico
deploy: install-prod
    @Write-Host "🎯 Smart deployment - Windows rilevato, usando Uvicorn ASGI..." -ForegroundColor Cyan
    @just run-uvicorn

# 🪟 Waitress server (Windows/Cross-platform)
waitress: install-prod
    @Write-Host "🪟 Avvio Django con Waitress (Windows)..." -ForegroundColor Green
    @Write-Host "🚀 Starting Django with Waitress" -ForegroundColor Green
    @Write-Host "Environment: prod" -ForegroundColor Cyan
    @Write-Host "Host: 0.0.0.0:8000" -ForegroundColor Cyan
    @Write-Host "Threads: 4" -ForegroundColor Cyan
    @Write-Host "📊 Running migrations..." -ForegroundColor Yellow
    @{{django_manage}} migrate --no-input
    @Write-Host "📁 Collecting static files..." -ForegroundColor Yellow
    @{{django_manage}} collectstatic --no-input --clear
    @Write-Host "🌟 Starting Waitress server..." -ForegroundColor Green
    @$env:DJANGO_ENV="prod"; cd src; {{python}} -m waitress --host=0.0.0.0 --port=8000 --threads=4 --connection-limit=1000 --channel-timeout=120 home.wsgi:application

# ⚡ Uvicorn ASGI server - RACCOMANDATO
run-uvicorn: install-prod
    @Write-Host "⚡ Avvio Django con Uvicorn ASGI (Windows)..." -ForegroundColor Green
    @Write-Host "🚀 Starting Uvicorn ASGI Server" -ForegroundColor Blue
    @Write-Host "Environment: prod" -ForegroundColor Yellow
    @Write-Host "Host: 0.0.0.0:8000" -ForegroundColor Yellow
    @Write-Host "📊 Running migrations..." -ForegroundColor Yellow
    @{{django_manage}} migrate --no-input
    @Write-Host "📁 Collecting static files..." -ForegroundColor Yellow
    @{{django_manage}} collectstatic --no-input --clear
    @Write-Host "⚡ Modalità produzione: single worker (Windows optimized)" -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; cd src; {{python}} -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --log-level info --access-log --timeout-keep-alive 2

# 🧪 Test Uvicorn locale (debug)
test-uvicorn-local:
    @Write-Host "🧪 Test locale Uvicorn ASGI (debug, singolo worker)..." -ForegroundColor Cyan
    @bash scripts/deployment/test-uvicorn-local.sh

# 📦 Raccolta file statici
collectstatic:
    @Write-Host "📦 Raccolta file statici..." -ForegroundColor Cyan
    @{{django_manage}} collectstatic --noinput

# 📦 Raccolta file statici DEV
collectstatic-dev:
    @Write-Host "📦 Raccolta file statici (DEV)..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} collectstatic --noinput

# 📦 Raccolta file statici TEST
collectstatic-test:
    @Write-Host "📦 Raccolta file statici (TEST)..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} collectstatic --noinput

# 📦 Raccolta file statici PROD
collectstatic-prod:
    @Write-Host "📦 Raccolta file statici (PROD)..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} collectstatic --noinput

# 🌐 Apre la home page nel browser
open-home:
    @Write-Host "🌐 Apertura pagina home nel browser..." -ForegroundColor Cyan
    @Start-Process "http://localhost:8000"

# === SERVER MANAGEMENT ===

# 🛑 Ferma tutti i server Django
stop-servers:
    @Write-Host "🛑 Arresto di tutti i server Django..." -ForegroundColor Yellow
    @Write-Host "ℹ️  Nota: Eseguire da un terminale DIVERSO da quello che esegue il server" -ForegroundColor Cyan
    @Get-Process | Where-Object {$_.ProcessName -match "python|gunicorn|waitress|uvicorn"} | Where-Object {$_.CommandLine -match "django|manage.py|wsgi|asgi"} | Stop-Process -Force

# 🔪 Termina processi sulla porta 8000
kill-port:
    @Write-Host "🔪 Terminazione processi sulla porta 8000..." -ForegroundColor Yellow
    @Write-Host "ℹ️  Nota: Eseguire da un terminale DIVERSO da quello che esegue il server" -ForegroundColor Cyan
    @$processes = Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess; if ($processes) { $processes | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }; Write-Host "Processi sulla porta 8000 terminati" } else { Write-Host "Nessun processo trovato sulla porta 8000" }

# === ENVIRONMENT CHECKS ===

# 🔍 Controllo ambiente corrente
check-env:
    @Write-Host "🔍 Controllo dell'ambiente corrente..." -ForegroundColor Cyan
    @{{python}} src/test_logging.py

# 🔍 Controllo ambiente DEV
check-env-dev:
    @Write-Host "🔍 Controllo dell'ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{python}} src/test_logging.py

# 🔍 Controllo ambiente TEST
check-env-test:
    @Write-Host "🔍 Controllo dell'ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{python}} src/test_logging.py

# 🔍 Controllo ambiente PROD
check-env-prod:
    @Write-Host "🔍 Controllo dell'ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{python}} src/test_logging.py

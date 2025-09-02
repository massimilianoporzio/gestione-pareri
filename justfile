# Deploy Django Template - Comandi disponibili con Just
# Per visualizzare tutti i comandi: just --list o just

# Configura shell per Windows
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Variabili globali
python := "uv run"
django_manage := "uv run src/manage.py"

# 📋 Comando default: mostra l'help
default:
    @Write-Host "Deploy Django Template - Comandi disponibili:" -ForegroundColor Cyan
    @Write-Host "just run-server     🚀 Avvia il server di sviluppo Django" -ForegroundColor Green
    @Write-Host "just run-dev        🔧 Avvia il server di sviluppo in ambiente DEV" -ForegroundColor Green
    @Write-Host "just run-test       🧪 Avvia il server di sviluppo in ambiente TEST" -ForegroundColor Green
    @Write-Host "just run-prod       ⚡ Avvia il server di sviluppo in ambiente PROD" -ForegroundColor Green
    @Write-Host "just test           🧪 Esegue i test del progetto" -ForegroundColor Green
    @Write-Host "just add-docstrings 📝 Aggiunge docstring mancanti ai file Python" -ForegroundColor Green
    @Write-Host "just fix-all        ⭐ CORREZIONE GLOBALE: Risolve tutti i problemi di qualità del codice" -ForegroundColor Green
    @Write-Host "just test-precommit 🔍 TEST PRE-COMMIT: Verifica tutti i controlli senza modifiche" -ForegroundColor Green
    @Write-Host "just quality-corporate 🏢 Controlli qualità per ambiente aziendale" -ForegroundColor Green
    @Write-Host "just fix-markdown   📝 Corregge problemi di linting Markdown" -ForegroundColor Green
    @Write-Host "just lint-codacy    🔍 Controlli qualità stile Codacy (senza correzioni)" -ForegroundColor Green
    @Write-Host "just stats          📊 Genera statistiche complete del progetto" -ForegroundColor Green
    @Write-Host "" -ForegroundColor White
    @Write-Host "== DEPLOYMENT ==" -ForegroundColor Magenta
    @Write-Host "just deploy-dev     🔧 Avvia server di sviluppo" -ForegroundColor Green
    @Write-Host "just deploy-staging 🧪 Deploy in modalità staging/test" -ForegroundColor Green
    @Write-Host "just deploy-prod    🚀 Deploy in produzione" -ForegroundColor Green
    @Write-Host "just deploy         🎯 Deploy automatico (rileva OS e usa il server ottimale)" -ForegroundColor Green
    @Write-Host "just waitress       🪟 Avvia con Waitress (Windows/Cross-platform)" -ForegroundColor Green
    @Write-Host "just run-uvicorn    ⚡ Avvia con Uvicorn ASGI (Tutti gli OS) - RACCOMANDATO" -ForegroundColor Green
    @Write-Host "just test-uvicorn-local Test locale Uvicorn ASGI (debug, singolo worker)" -ForegroundColor Green
    @Write-Host "just open-home      🌐 Apre la pagina home nel browser" -ForegroundColor Green
    @Write-Host "just collectstatic  📦 Raccoglie i file statici" -ForegroundColor Green
    @Write-Host "just stop-servers   🛑 Ferma tutti i server Django" -ForegroundColor Yellow
    @Write-Host "just kill-port      🔪 Termina i processi sulla porta 8000" -ForegroundColor Red
    @Write-Host "just generate-secret-key 🔑 Genera Django SECRET_KEY" -ForegroundColor Green

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
    @Write-Host "✅ Docstring aggiunte con successo!" -ForegroundColor Green

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

# 🏢 Pre-commit completo per ambiente aziendale
precommit-corporate:
    @Write-Host "🏢 Pre-commit ambiente aziendale (completo)..." -ForegroundColor Cyan
    @$env:NODE_TLS_REJECT_UNAUTHORIZED="0"; $env:PYTHONHTTPSVERIFY="0"; pre-commit run --all-files
    @Write-Host "✅ Pre-commit aziendale completato!" -ForegroundColor Green

# 🏢 Controlli qualità per ambiente aziendale (alternativa a pre-commit)
quality-corporate:
    @Write-Host "🏢 Controlli qualità ambiente aziendale..." -ForegroundColor Cyan
    @Write-Host "1/6 - Ruff format..." -ForegroundColor Yellow
    @-{{python}} ruff format .
    @Write-Host "2/6 - Ruff check e fix..." -ForegroundColor Yellow
    @-{{python}} ruff check . --fix --unsafe-fixes
    @Write-Host "3/6 - Import sorting..." -ForegroundColor Yellow
    @-{{python}} ruff check --select I --fix .
    @Write-Host "4/6 - Flake8..." -ForegroundColor Yellow
    @-{{python}} flake8 --format=default .
    @Write-Host "5/6 - Correzione script bash..." -ForegroundColor Yellow
    @just fix-codacy
    @Write-Host "6/6 - Formattazione Markdown..." -ForegroundColor Yellow
    @just format-markdown
    @Write-Host "✅ Controlli qualità completati (ambiente aziendale)!" -ForegroundColor Green

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
    @Write-Host "1/2 - Prettier formatting..." -ForegroundColor Yellow
    @-pre-commit run prettier --all-files
    @Write-Host "2/2 - Markdownlint fixes..." -ForegroundColor Yellow
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
    @powershell -ExecutionPolicy Bypass -File scripts/deployment/start-waitress.ps1

# ⚡ Uvicorn ASGI server - RACCOMANDATO
run-uvicorn: install-prod
    @Write-Host "⚡ Avvio Django con Uvicorn ASGI (Windows)..." -ForegroundColor Green
    @powershell -ExecutionPolicy Bypass -File scripts/deployment/start-uvicorn.ps1

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

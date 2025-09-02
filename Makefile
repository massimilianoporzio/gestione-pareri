generate-secret-key: ## Genera una Django SECRET_KEY sicura per la produzione
	@uv run python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
# 🔧 Correzione automatica script bash (formattazione e best practice)
fix-codacy:  ## Applica correzioni automatiche agli script bash di deployment
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Correzione automatica script bash...' -ForegroundColor Cyan"
	@powershell -Command "Get-ChildItem -Path 'scripts/deployment' -Filter '*.sh' | ForEach-Object { shfmt -w $$_.FullName }"
	@powershell -Command "Write-Host 'Correzioni applicate!' -ForegroundColor Green"
else
	@echo -e "$(CYAN)🔧 Correzione automatica script bash...$(NC)"
	shfmt -w scripts/deployment/*.sh
	@echo -e "$(GREEN)✅ Correzioni applicate!$(NC)"
endif
.PHONY: run-server test migrate makemigrations shell lint format help run-dev run-test run-prod test-dev test-test test-prod migrate-dev migrate-test migrate-prod shell-dev shell-test shell-prod check-env check-env-dev check-env-test check-env-prod check-custom-logs add-docstrings fix-all test-precommit format-markdown install-prod gunicorn waitress uvicorn deploy-dev deploy-prod deploy-staging deploy collectstatic fix-markdown stop-servers kill-port

.SILENT: run-server run-dev run-test run-prod deploy deploy-dev deploy-prod deploy-staging gunicorn waitress install-prod stop-servers kill-port

# Colori - solo per l'help
SHELL := /bin/bash
ifneq (,$(findstring xterm,${TERM}))
	GREEN = \033[0;32m
	YELLOW = \033[0;33m
	CYAN = \033[0;36m
	MAGENTA = \033[0;35m
	NC = \033[0m
else
	GREEN =
	YELLOW =
	CYAN =
	MAGENTA =
	NC =
endif

# Include .env file if it exists
ifneq (,$(wildcard .env))
    include .env
    export
endif

# Comandi specifici per Windows PowerShell
ifeq ($(OS),Windows_NT)
    # Rilevato Windows
    SET_ENV_DEV = powershell -Command "$$env:DJANGO_ENV='dev';"
    SET_ENV_TEST = powershell -Command "$$env:DJANGO_ENV='test';"
    SET_ENV_PROD = powershell -Command "$$env:DJANGO_ENV='prod';"
    # Preserva le variabili d'ambiente esistenti
    SET_ENV_PRESERVE = powershell -Command ""
else
    # Rilevato macOS o Linux
    SET_ENV_DEV = env DJANGO_ENV=dev
    SET_ENV_TEST = env DJANGO_ENV=test
    SET_ENV_PROD = env DJANGO_ENV=prod
    SET_ENV_PRESERVE =
endif

help:
ifeq ($(OS),Windows_NT)
	@uv run scripts/help.py
else
	@printf "$(CYAN)Deploy Django Template - Comandi disponibili:$(NC)\n"
	@printf "$(GREEN)make run-server$(NC)    Avvia il server di sviluppo Django\n"
	@printf "$(GREEN)make run-dev$(NC)       Avvia il server di sviluppo in ambiente DEV\n"
	@printf "$(GREEN)make run-test$(NC)      Avvia il server di sviluppo in ambiente TEST\n"
	@printf "$(GREEN)make run-prod$(NC)      Avvia il server di sviluppo in ambiente PROD\n"
	@printf "$(GREEN)make test$(NC)          Esegue i test del progetto\n"
	@printf "$(GREEN)make add-docstrings$(NC) 📝 Aggiunge docstring mancanti ai file Python\n"
	@printf "$(GREEN)make fix-all$(NC)       ⭐ CORREZIONE GLOBALE: Risolve tutti i problemi di qualità del codice\n"
	@printf "$(GREEN)make test-precommit$(NC) 🔍 TEST PRE-COMMIT: Verifica tutti i controlli senza modifiche\n"
	@printf "$(GREEN)make fix-markdown$(NC)  📝 Corregge problemi di linting Markdown\n"
	@printf "$(GREEN)make lint-codacy$(NC)   🔍 Controlli qualità stile Codacy (senza correzioni)\n"
	@printf "$(GREEN)make stats$(NC)         🔍 Genera statistiche complete del progetto (alternativa locale a Codacy)\n"
	@printf "$(MAGENTA)== DEPLOYMENT ==$(NC)\n"
	@printf "$(GREEN)make deploy-dev$(NC)    🔧 Avvia server di sviluppo\n"
	@printf "$(GREEN)make deploy-staging$(NC) 🧪 Deploy in modalità staging/test\n"
	@printf "$(GREEN)make deploy-prod$(NC)   🚀 Deploy in produzione\n"
	@printf "$(GREEN)make deploy$(NC)        🎯 Deploy automatico (rileva OS e usa il server ottimale)\n"
	@printf "$(GREEN)make waitress$(NC)      🪟 Avvia con Waitress (Windows/Cross-platform)\n"
	@printf "$(GREEN)make gunicorn$(NC)      🐧 Avvia con Gunicorn (Unix/Linux/macOS)\n"
	@printf "$(GREEN)make run-uvicorn$(NC)   ⚡ Avvia con Uvicorn ASGI (Tutti gli OS) - RACCOMANDATO\n"
	@printf "$(GREEN)make test-uvicorn-local$(NC) Test locale Uvicorn ASGI (debug, singolo worker)\n"
	@printf "$(GREEN)make open-home$(NC)     🌐 Apre la pagina home nel browser\n"
	@printf "$(GREEN)make collectstatic$(NC) 📦 Raccoglie i file statici\n"
	@printf "$(YELLOW)make stop-servers$(NC)  🛑 Ferma tutti i server Django\n"
	@printf "$(RED)make kill-port$(NC)     🔪 Termina i processi sulla porta 8000\n"
	@printf "$(GREEN)make help$(NC)          Mostra questo messaggio di aiuto\n"
endif
test-uvicorn-local: ## Test locale Uvicorn ASGI (debug, singolo worker)
	@echo "Test locale Uvicorn ASGI (debug, singolo worker)..."
	bash scripts/deployment/test-uvicorn-local.sh

run-server:
	@echo "🚀 Avvio del server di sviluppo Django..."
	@uv run src/manage.py runserver

run-dev:
	@echo "� Avvio del server di sviluppo in ambiente DEV..."
	@$(SET_ENV_DEV) uv run src/manage.py runserver

run-test:
	@echo "🧪 Avvio del server di sviluppo in ambiente TEST..."
	@$(SET_ENV_TEST) uv run src/manage.py runserver

run-prod:
	@echo "⚡ Avvio del server di sviluppo in ambiente PROD..."
	@$(SET_ENV_PROD) uv run src/manage.py runserver

test:
	@echo -e "$(CYAN)Esecuzione dei test...$(NC)"
	uv run src/manage.py test

test-dev:
	@echo -e "$(CYAN)Esecuzione dei test in ambiente DEV...$(NC)"
	$(SET_ENV_DEV) uv run src/manage.py test

test-test:
	@echo -e "$(CYAN)Esecuzione dei test in ambiente TEST...$(NC)"
	$(SET_ENV_TEST) uv run src/manage.py test

test-prod:
	@echo -e "$(CYAN)Esecuzione dei test in ambiente PROD...$(NC)"
	$(SET_ENV_PROD) uv run src/manage.py test

migrate:
	@echo -e "$(CYAN)Applicazione delle migrazioni...$(NC)"
	uv run src/manage.py migrate

migrate-dev:
	@echo -e "$(CYAN)Applicazione delle migrazioni in ambiente DEV...$(NC)"
	$(SET_ENV_DEV) uv run src/manage.py migrate

migrate-test:
	@echo -e "$(CYAN)Applicazione delle migrazioni in ambiente TEST...$(NC)"
	$(SET_ENV_TEST) uv run src/manage.py migrate

migrate-prod:
	@echo -e "$(CYAN)Applicazione delle migrazioni in ambiente PROD...$(NC)"
	$(SET_ENV_PROD) uv run src/manage.py migrate

makemigrations:
	@echo -e "$(CYAN)Creazione delle migrazioni...$(NC)"
	uv run src/manage.py makemigrations

shell:
	@echo -e "$(CYAN)Avvio della shell Django...$(NC)"
	uv run src/manage.py shell

shell-dev:
	@echo -e "$(CYAN)Avvio della shell Django in ambiente DEV...$(NC)"
	$(SET_ENV_DEV) uv run src/manage.py shell

shell-test:
	@echo -e "$(CYAN)Avvio della shell Django in ambiente TEST...$(NC)"
	$(SET_ENV_TEST) uv run src/manage.py shell

shell-prod:
	@echo -e "$(CYAN)Avvio della shell Django in ambiente PROD...$(NC)"
	$(SET_ENV_PROD) uv run src/manage.py shell

lint:
	@echo -e "$(CYAN)Esecuzione dei controlli di qualità del codice...$(NC)"
	uv run flake8
	uv run pylint src/
	uv run ruff check .

format:
	@echo -e "$(CYAN)Formattazione del codice...$(NC)"
	uv run ruff format .
	uv run ruff check . --fix --unsafe-fixes
	uv run python tools/add_docstring_batch.py .
	uv run autopep8 --in-place --aggressive --aggressive $$(find . -name "*.py" -not -path "./.venv/*" -not -path "./venv/*" 2>/dev/null || git ls-files "*.py")

sonarqube:
	@echo -e "$(CYAN)Esecuzione dell'analisi SonarQube locale...$(NC)"
ifeq ($(OS),Windows_NT)
	# Windows: usa lo script PowerShell
	powershell -File tools/run_sonarqube.ps1
else
	# macOS/Linux: usa lo script bash
	chmod +x tools/run_sonarqube.sh && ./tools/run_sonarqube.sh
endif

# Target per controllare l'ambiente corrente
check-env:
	@echo -e "$(CYAN)Controllo dell'ambiente corrente...$(NC)"
	$(SET_ENV_PRESERVE) uv run src/test_logging.py

check-env-dev:
	@echo -e "$(CYAN)Controllo dell'ambiente DEV...$(NC)"
	$(SET_ENV_DEV) uv run src/test_logging.py

check-env-test:
	@echo -e "$(CYAN)Controllo dell'ambiente TEST...$(NC)"
	$(SET_ENV_TEST) uv run src/test_logging.py

check-env-prod:
	@echo -e "$(CYAN)Controllo dell'ambiente PROD...$(NC)"
	$(SET_ENV_PROD) uv run src/test_logging.py

# Target per verificare la configurazione personalizzata dei log
check-custom-logs:
	@echo -e "$(CYAN)Verifica della directory personalizzata dei log...$(NC)"
	@echo -e "$(YELLOW)Utilizza: make check-custom-logs LOGS_DIR=/path/to/logs ENV=dev|test|prod$(NC)"
ifdef LOGS_DIR
	@echo -e "$(GREEN)Directory dei log: $(LOGS_DIR)$(NC)"
	@echo -e "$(GREEN)Ambiente: $(ENV)$(NC)"
ifeq ($(OS),Windows_NT)
	# Su Windows, usa uv run per usare l'ambiente virtuale
	powershell -Command "$$env:DJANGO_LOGS_DIR='$(LOGS_DIR)'; $$env:DJANGO_ENV='$(ENV)'; uv run src/test_logging.py"
else
	# Su macOS/Linux, usa export per impostare le variabili d'ambiente
	DJANGO_LOGS_DIR="$(LOGS_DIR)" DJANGO_ENV="$(ENV)" uv run src/test_logging.py
endif
else
	@echo -e "$(YELLOW)Nessuna directory specificata. Usa LOGS_DIR=/path/to/logs$(NC)"
endif

# Target per aggiungere docstring a tutti i file Python
add-docstrings:
	@echo -e "$(CYAN)Aggiunta docstring ai file Python del progetto...$(NC)"
ifeq ($(OS),Windows_NT)
	@REM Ambiente Windows
	uv run python tools/add_docstring_batch.py .
else
	@# Ambiente Linux/macOS
	chmod +x tools/add_docstring_batch.py
	uv run python tools/add_docstring_batch.py .
endif
	@echo -e "$(GREEN)Docstring aggiunte con successo!$(NC)"

# Fix all code quality issues across the project
fix-all:
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Correzione completa di tutti i problemi di qualita del codice...' -ForegroundColor Cyan"
	@powershell -Command "Write-Host '1/8 - Aggiunta docstring...' -ForegroundColor Yellow"
	-uv run python tools/add_docstring_batch.py .
	@powershell -Command "Write-Host '2/8 - Ordinamento import (isort style)...' -ForegroundColor Yellow"
	-uv run ruff check --select I --fix .
	@powershell -Command "Write-Host '3/8 - Formattazione con Ruff...' -ForegroundColor Yellow"
	-uv run ruff format .
	@powershell -Command "Write-Host '4/8 - Correzione automatica con Ruff...' -ForegroundColor Yellow"
	-uv run ruff check . --fix --unsafe-fixes
	@powershell -Command "Write-Host '5/8 - Correzioni aggressive con autopep8...' -ForegroundColor Yellow"
	-uv run autopep8 --in-place --aggressive --aggressive --recursive .
	@powershell -Command "Write-Host '6/8 - Formattazione finale con Ruff...' -ForegroundColor Yellow"
	-uv run ruff format .
	@powershell -Command "Write-Host '7/9 - Controllo finale import...' -ForegroundColor Yellow"
	-uv run ruff check --select I --fix .
	@powershell -Command "Write-Host '8/9 - Formattazione Markdown...' -ForegroundColor Yellow"
	$(MAKE) format-markdown
	@powershell -Command "Write-Host '9/9 - Correzione problemi Markdown...' -ForegroundColor Yellow"
	$(MAKE) fix-markdown
	@powershell -Command "Write-Host 'Tutti i problemi di qualita del codice sono stati corretti!' -ForegroundColor Green"
else
	@echo -e "$(CYAN)Correzione completa di tutti i problemi di qualità del codice...$(NC)"
	@echo -e "$(YELLOW)1/8 - Aggiunta docstring...$(NC)"
	-uv run python tools/add_docstring_batch.py .
	@echo -e "$(YELLOW)2/8 - Ordinamento import (isort style)...$(NC)"
	-uv run ruff check --select I --fix .
	@echo -e "$(YELLOW)3/8 - Formattazione con Ruff...$(NC)"
	-uv run ruff format .
	@echo -e "$(YELLOW)4/8 - Correzione automatica con Ruff...$(NC)"
	-uv run ruff check . --fix --unsafe-fixes
	@echo -e "$(YELLOW)5/8 - Correzioni aggressive con autopep8...$(NC)"
	-uv run autopep8 --in-place --aggressive --aggressive --recursive .
	@echo -e "$(YELLOW)6/8 - Formattazione finale con Ruff...$(NC)"
	-uv run ruff format .
	@echo -e "$(YELLOW)7/9 - Controllo finale import...$(NC)"
	-uv run ruff check --select I --fix .
	@echo -e "$(YELLOW)8/9 - Formattazione Markdown...$(NC)"
	$(MAKE) format-markdown
	@echo -e "$(YELLOW)9/9 - Correzione problemi Markdown...$(NC)"
	$(MAKE) fix-markdown
	@echo -e "$(GREEN)✅ Tutti i problemi di qualità del codice sono stati corretti!$(NC)"
endif

# Test all pre-commit hooks without making changes
test-precommit:
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Test di tutti i controlli pre-commit...' -ForegroundColor Cyan"
	pre-commit run --all-files
	@powershell -Command "Write-Host 'Test pre-commit completato!' -ForegroundColor Green"
else
	@echo -e "$(CYAN)🔍 Test di tutti i controlli pre-commit...$(NC)"
	pre-commit run --all-files
	@echo -e "$(GREEN)✅ Test pre-commit completato!$(NC)"
endif

# Format all markdown files
format-markdown:
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Formattazione file Markdown...' -ForegroundColor Cyan"
	@powershell -Command "Get-ChildItem -Path . -Include '*.md' -Recurse | ForEach-Object { Write-Host 'Formatting' $$_.FullName; $$content = Get-Content $$_.FullName -Raw; if ($$content) { $$formatted = $$content -replace '(?m)^[ \t]+$$', '' -replace '(?m)\r?\n{3,}', \"`n`n\" -replace '(?m)[ \t]+$$', ''; Set-Content $$_.FullName -Value $$formatted -NoNewline } }"
	@powershell -Command "Write-Host 'File Markdown formattati con successo!' -ForegroundColor Green"
else
	@echo "Formattazione file Markdown..."
	@find . -name "*.md" -type f -exec sh -c 'echo "Formatting $$1"; sed -i "/^[[:space:]]*$$/d; /^$$/N; /^\\n$$/d" "$$1"' _ {} \;
	@echo "File Markdown formattati con successo!"
endif

# Fix markdown linting issues
fix-markdown: ## 📝 Fix markdown linting issues with prettier and markdownlint
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Correzione problemi Markdown...' -ForegroundColor Cyan"
	@powershell -Command "Write-Host '1/2 - Prettier formatting...' -ForegroundColor Yellow"
	-pre-commit run prettier --all-files
	@powershell -Command "Write-Host '2/2 - Markdownlint fixes...' -ForegroundColor Yellow"
	-pre-commit run markdownlint-cli2 --all-files
	@powershell -Command "Write-Host 'Problemi Markdown corretti!' -ForegroundColor Green"
else
	@echo "Correzione problemi Markdown..."
	@echo "1/2 - Prettier formatting..."
	-pre-commit run prettier --all-files
	@echo "2/2 - Markdownlint fixes..."
	-pre-commit run markdownlint-cli2 --all-files
	@echo "Problemi Markdown corretti!"
endif

# Genera statistiche complete del progetto (alternativa a Codacy)
stats:  ## Genera statistiche complete del progetto
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Generazione statistiche progetto...' -ForegroundColor Cyan"
	uv run python tools/project_stats.py
	@powershell -Command "Write-Host 'Dashboard completa disponibile in tools/quality_dashboard.md' -ForegroundColor Green"
else
	@echo -e "$(CYAN)Generazione statistiche progetto...$(NC)"
	uv run python tools/project_stats.py
	@echo -e "$(GREEN)📊 Dashboard completa disponibile in tools/quality_dashboard.md$(NC)"
endif

# 🔍 Controllo qualità completo simile a Codacy
lint-codacy:  ## Esegue controlli simili a Codacy
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Controlli qualità stile Codacy...' -ForegroundColor Cyan"
	@powershell -Command "Write-Host '1/5 - Ruff (stile e errori)...' -ForegroundColor Yellow"
	-uv run ruff check --output-format=github .
	@powershell -Command "Write-Host '2/5 - Flake8 (stile aggiuntivo)...' -ForegroundColor Yellow"
	-uv run flake8 --format=default .
	@powershell -Command "Write-Host '3/5 - Pylint (analisi statica)...' -ForegroundColor Yellow"
	-uv run pylint src/home/ --output-format=colorized
	@powershell -Command "Write-Host '4/5 - Import sorting check...' -ForegroundColor Yellow"
	-uv run ruff check --select I .
	@powershell -Command "Write-Host '5/5 - ShellCheck (script bash)...' -ForegroundColor Yellow"
	shellcheck scripts/deployment/*.sh || true
	@powershell -Command "Write-Host 'Controlli completati!' -ForegroundColor Green"
else
	@echo -e "$(CYAN)🔍 Controlli qualità stile Codacy...$(NC)"
	@echo -e "$(YELLOW)1/5 - Ruff (stile e errori)...$(NC)"
	-uv run ruff check --output-format=github .
	@echo -e "$(YELLOW)2/5 - Flake8 (stile aggiuntivo)...$(NC)"
	-uv run flake8 --format=default .
	@echo -e "$(YELLOW)3/5 - Pylint (analisi statica)...$(NC)"
	-uv run pylint src/home/ --output-format=colorized
	@echo -e "$(YELLOW)4/5 - Import sorting check...$(NC)"
	-uv run ruff check --select I .
	@echo -e "$(YELLOW)5/5 - ShellCheck (script bash)...$(NC)"
	shellcheck scripts/deployment/*.sh || true
	@echo -e "$(GREEN)✅ Controlli completati!$(NC)"
endif

# Deployment commands
install-prod: ## Install production dependencies
	@echo "📦 Installing production dependencies..."
	@uv sync --group prod

gunicorn: install-prod ## Start Django with Gunicorn (Unix/Linux/macOS)
ifeq ($(OS), Windows_NT)
	@echo "❌ Gunicorn non è supportato su Windows. Usa waitress invece: make waitress"
else
	@echo "🐧 Starting Django with Gunicorn (Unix/Linux/macOS)..."
	@chmod +x scripts/deployment/start-gunicorn.sh
	@./scripts/deployment/start-gunicorn.sh
endif

uvicorn: install-prod ## Start Django with Uvicorn ASGI (multi-worker, produzione, compatibile Render)
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host '⚡ Starting Django with Uvicorn ASGI (Windows, single worker)...' -ForegroundColor Green"
	@powershell -ExecutionPolicy Bypass -File scripts/deployment/start-uvicorn.ps1
else
	@echo "⚡ Starting Django with Uvicorn ASGI (Unix/Linux/macOS, multi-worker, compatibile Render)..."
	@chmod +x scripts/deployment/start-uvicorn-render.sh
	@./scripts/deployment/start-uvicorn-render.sh
endif

waitress: install-prod ## Start Django with Waitress (Windows/Cross-platform)
ifeq ($(OS), Windows_NT)
	@powershell -Command "Write-Host '🪟 Starting Django with Waitress (Windows)...' -ForegroundColor Green"
	@powershell -ExecutionPolicy Bypass -File scripts/deployment/start-waitress.ps1
else
	@echo "🪟 Starting Django with Waitress (Cross-platform)..."
	@cd src && DJANGO_ENV=prod uv run waitress-serve --host=0.0.0.0 --port=8000 home.wsgi:application
endif

run-uvicorn: install-prod ## Start Django with Uvicorn ASGI (All OS) - RECOMMENDED
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host '⚡ Starting Django with Uvicorn ASGI (Windows)...' -ForegroundColor Green"
	@powershell -ExecutionPolicy Bypass -File scripts/deployment/start-uvicorn.ps1
else
	@echo "⚡ Starting Django with Uvicorn ASGI (Unix/Linux/macOS)..."
	@chmod +x scripts/deployment/start-uvicorn.sh
	@./scripts/deployment/start-uvicorn.sh &
	sleep 2
endif


deploy-dev: ## Deploy in development mode with auto-reload
ifeq ($(OS), Windows_NT)
	@powershell -Command "Write-Host '🔧 Starting development server...' -ForegroundColor Yellow"
	@set DJANGO_ENV=dev&& cd src && uv run python manage.py runserver
else
	@echo "🔧 Starting development server..."
	@DJANGO_ENV=dev cd src && uv run python manage.py runserver
endif

deploy-prod: install-prod ## Deploy in production with Uvicorn ASGI (recommended)
ifeq ($(OS), Windows_NT)
	@powershell -Command "Write-Host '🚀 Production deployment (Windows - Uvicorn ASGI)...' -ForegroundColor Green"
	@$(MAKE) uvicorn
else
	@echo "🚀 Production deployment (Unix/Linux/macOS - Uvicorn ASGI)..."
	@$(MAKE) uvicorn
endif

deploy-staging: ## Deploy in staging/test mode with Uvicorn
ifeq ($(OS), Windows_NT)
	@powershell -Command "Write-Host '🧪 Staging deployment (Windows - Uvicorn)...' -ForegroundColor Yellow"
	@set DJANGO_ENV=test&& powershell -ExecutionPolicy Bypass -File scripts/deployment/start-uvicorn.ps1 -DjangoEnv test
else
	@echo "🧪 Staging deployment (Unix/Linux/macOS - Uvicorn)..."
	@DJANGO_ENV=test ./scripts/deployment/start-uvicorn.sh
endif

deploy: install-prod ## 🎯 Smart deploy - uses Uvicorn ASGI on all platforms (recommended)
ifeq ($(OS), Windows_NT)
	@powershell -Command "Write-Host '🎯 Smart deployment - Windows detected, using Uvicorn ASGI...' -ForegroundColor Cyan"
	@$(MAKE) uvicorn
else
	@echo "🎯 Smart deployment - Unix/Linux/macOS detected, using Uvicorn ASGI..."
	@$(MAKE) uvicorn
endif

# Static files management
collectstatic: ## 📦 Collect static files for production
	@echo "📦 Collecting static files..."
	@uv run src/manage.py collectstatic --noinput

collectstatic-dev: ## 📦 Collect static files in DEV environment
	@echo "📦 Collecting static files (DEV)..."
	@$(SET_ENV_DEV) uv run src/manage.py collectstatic --noinput

collectstatic-test: ## 📦 Collect static files in TEST environment
	@echo "📦 Collecting static files (TEST)..."
	@$(SET_ENV_TEST) uv run src/manage.py collectstatic --noinput

collectstatic-prod: ## 📦 Collect static files in PROD environment
	@echo "📦 Collecting static files (PROD)..."
	@$(SET_ENV_PROD) uv run src/manage.py collectstatic --noinput

# Server management
# IMPORTANT: stop-servers and kill-port must be run from a DIFFERENT terminal
# than the one running the server (since servers run in foreground/background)
stop-servers: ## 🛑 Stop all Django servers (run from different terminal!)
	@printf "$(YELLOW)🛑 Stopping all Django servers...$(NC)\n"
	@printf "$(CYAN)ℹ️  Note: Run this from a DIFFERENT terminal than the one running the server$(NC)\n"
ifeq ($(OS), Windows_NT)
	@powershell -Command "Write-Host '🛑 Stopping all Django servers...' -ForegroundColor Yellow"
	@powershell -Command "Get-Process | Where-Object {$$_.ProcessName -match 'python|gunicorn|waitress|uvicorn'} | Where-Object {$$_.CommandLine -match 'django|manage.py|wsgi|asgi'} | Stop-Process -Force" 2>nul || echo "No Django servers found"
else
	@printf "$(YELLOW)🛑 Stopping all Django servers...$(NC)\n"
	@pkill -f "gunicorn.*wsgi" 2>/dev/null || true
	@pkill -f "gunicorn.*asgi" 2>/dev/null || true
	@pkill -f "uvicorn.*asgi" 2>/dev/null || true
	@pkill -f "waitress.*wsgi" 2>/dev/null || true
	@pkill -f "manage.py runserver" 2>/dev/null || true
	@printf "$(GREEN)✅ All Django servers stopped$(NC)\n"
endif

kill-port: ## 🔪 Kill processes on port 8000 (run from different terminal!)
	@printf "$(YELLOW)🔪 Killing processes on port 8000...$(NC)\n"
	@printf "$(CYAN)ℹ️  Note: Run this from a DIFFERENT terminal than the one running the server$(NC)\n"
ifeq ($(OS), Windows_NT)
	@powershell -Command "$$processes = Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess; if ($$processes) { $$processes | ForEach-Object { Stop-Process -Id $$_ -Force -ErrorAction SilentlyContinue }; Write-Host 'Processes on port 8000 terminated' } else { Write-Host 'No processes found on port 8000' }"
else
	@lsof -ti:8000 | xargs kill -9 2>/dev/null || echo "No processes found on port 8000"
	@printf "$(GREEN)✅ Port 8000 is now free$(NC)\n"
endif

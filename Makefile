.PHONY: run-server test migrate makemigrations shell lint format help run-dev run-test run-prod test-dev test-test test-prod migrate-dev migrate-test migrate-prod shell-dev shell-test shell-prod check-env check-env-dev check-env-test check-env-prod check-custom-logs add-docstrings fix-all format-markdown

# Colori
GREEN = \033[0;32m
YELLOW = \033[0;33m
CYAN = \033[0;36m
NC = \033[0m # No Color

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
	@powershell -Command "Write-Host 'Deploy Django Template - Comandi disponibili:' -ForegroundColor Cyan"
	@powershell -Command "Write-Host 'make run-server    ' -NoNewline -ForegroundColor Green; Write-Host 'Avvia il server di sviluppo Django'"
	@powershell -Command "Write-Host 'make run-dev       ' -NoNewline -ForegroundColor Green; Write-Host 'Avvia il server di sviluppo in ambiente DEV'"
	@powershell -Command "Write-Host 'make run-test      ' -NoNewline -ForegroundColor Green; Write-Host 'Avvia il server di sviluppo in ambiente TEST'"
	@powershell -Command "Write-Host 'make run-prod      ' -NoNewline -ForegroundColor Green; Write-Host 'Avvia il server di sviluppo in ambiente PROD'"
	@powershell -Command "Write-Host 'make test          ' -NoNewline -ForegroundColor Green; Write-Host 'Esegue i test del progetto'"
	@powershell -Command "Write-Host 'make add-docstrings' -NoNewline -ForegroundColor Green; Write-Host '📝 Aggiunge docstring mancanti ai file Python'"
	@powershell -Command "Write-Host 'make fix-all       ' -NoNewline -ForegroundColor Green; Write-Host '⭐ CORREZIONE GLOBALE: Risolve tutti i problemi di qualità del codice'"
	@powershell -Command "Write-Host 'make lint-codacy   ' -NoNewline -ForegroundColor Green; Write-Host '🔍 Controlli qualità stile Codacy (senza correzioni)'"
	@powershell -Command "Write-Host 'make stats         ' -NoNewline -ForegroundColor Green; Write-Host '🔍 Genera statistiche complete del progetto (alternativa locale a Codacy)'"
	@powershell -Command "Write-Host 'make help          ' -NoNewline -ForegroundColor Green; Write-Host 'Mostra questo messaggio di aiuto'"
else
	@echo -e "$(CYAN)Deploy Django Template - Comandi disponibili:$(NC)"
	@echo -e "$(GREEN)make run-server$(NC)    Avvia il server di sviluppo Django"
	@echo -e "$(GREEN)make run-dev$(NC)       Avvia il server di sviluppo in ambiente DEV"
	@echo -e "$(GREEN)make run-test$(NC)      Avvia il server di sviluppo in ambiente TEST"
	@echo -e "$(GREEN)make run-prod$(NC)      Avvia il server di sviluppo in ambiente PROD"
	@echo -e "$(GREEN)make test$(NC)          Esegue i test del progetto"
	@echo -e "$(GREEN)make add-docstrings$(NC) 📝 Aggiunge docstring mancanti ai file Python"
	@echo -e "$(GREEN)make fix-all$(NC)       ⭐ CORREZIONE GLOBALE: Risolve tutti i problemi di qualità del codice"
	@echo -e "$(GREEN)make lint-codacy$(NC)   🔍 Controlli qualità stile Codacy (senza correzioni)"
	@echo -e "$(GREEN)make stats$(NC)         🔍 Genera statistiche complete del progetto (alternativa locale a Codacy)"
	@echo -e "$(GREEN)make help$(NC)          Mostra questo messaggio di aiuto"
endif

run-server:
	@echo -e "$(CYAN)Avvio del server di sviluppo Django...$(NC)"
	uv run src/manage.py runserver

run-dev:
	@echo -e "$(CYAN)Avvio del server di sviluppo in ambiente DEV...$(NC)"
	$(SET_ENV_DEV) uv run src/manage.py runserver

run-test:
	@echo -e "$(CYAN)Avvio del server di sviluppo in ambiente TEST...$(NC)"
	$(SET_ENV_TEST) uv run src/manage.py runserver

run-prod:
	@echo -e "$(CYAN)Avvio del server di sviluppo in ambiente PROD...$(NC)"
	$(SET_ENV_PROD) uv run src/manage.py runserver

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
	@powershell -Command "Write-Host '7/8 - Controllo finale import...' -ForegroundColor Yellow"
	-uv run ruff check --select I --fix .
	@powershell -Command "Write-Host '8/8 - Formattazione Markdown...' -ForegroundColor Yellow"
	$(MAKE) format-markdown
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
	@echo -e "$(YELLOW)7/8 - Controllo finale import...$(NC)"
	-uv run ruff check --select I --fix .
	@echo -e "$(YELLOW)8/8 - Formattazione Markdown...$(NC)"
	$(MAKE) format-markdown
	@echo -e "$(GREEN)✅ Tutti i problemi di qualità del codice sono stati corretti!$(NC)"
endif

# Format all markdown files
format-markdown:
ifeq ($(OS),Windows_NT)
	@powershell -Command "Write-Host 'Formattazione file Markdown...' -ForegroundColor Cyan"
	@powershell -Command "Get-ChildItem -Path . -Include '*.md' -Recurse | ForEach-Object { Write-Host 'Formatting' $$_.FullName; $$content = Get-Content $$_.FullName -Raw; if ($$content) { $$formatted = $$content -replace '(?m)^[ \t]+$$', '' -replace '(?m)\r?\n{3,}', \"`n`n\" -replace '(?m)[ \t]+$$', ''; Set-Content $$_.FullName -Value $$formatted -NoNewline } }"
	@powershell -Command "Write-Host 'File Markdown formattati con successo!' -ForegroundColor Green"
else
	@echo -e "$(CYAN)Formattazione file Markdown...$(NC)"
	@find . -name "*.md" -type f -exec sh -c 'echo "Formatting $$1"; sed -i "/^[[:space:]]*$$/d; /^$$/N; /^\\n$$/d" "$$1"' _ {} \;
	@echo -e "$(GREEN)File Markdown formattati con successo!$(NC)"
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
	@powershell -Command "Write-Host '1/4 - Ruff (stile e errori)...' -ForegroundColor Yellow"
	-uv run ruff check --output-format=github .
	@powershell -Command "Write-Host '2/4 - Flake8 (stile aggiuntivo)...' -ForegroundColor Yellow"
	-uv run flake8 --format=default .
	@powershell -Command "Write-Host '3/4 - Pylint (analisi statica)...' -ForegroundColor Yellow"
	-uv run pylint src/home/ --output-format=colorized
	@powershell -Command "Write-Host '4/4 - Import sorting check...' -ForegroundColor Yellow"
	-uv run ruff check --select I .
	@powershell -Command "Write-Host 'Controlli completati!' -ForegroundColor Green"
else
	@echo -e "$(CYAN)🔍 Controlli qualità stile Codacy...$(NC)"
	@echo -e "$(YELLOW)1/4 - Ruff (stile e errori)...$(NC)"
	-uv run ruff check --output-format=github .
	@echo -e "$(YELLOW)2/4 - Flake8 (stile aggiuntivo)...$(NC)"
	-uv run flake8 --format=default .
	@echo -e "$(YELLOW)3/4 - Pylint (analisi statica)...$(NC)"
	-uv run pylint src/home/ --output-format=colorized
	@echo -e "$(YELLOW)4/4 - Import sorting check...$(NC)"
	-uv run ruff check --select I .
	@echo -e "$(GREEN)✅ Controlli completati!$(NC)"
endif

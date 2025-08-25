.PHONY: run-server test migrate makemigrations shell lint format help run-dev run-test run-prod test-dev test-test test-prod migrate-dev migrate-test migrate-prod shell-dev shell-test shell-prod check-env check-env-dev check-env-test check-env-prod check-custom-logs add-docstrings

# Colori
GREEN = \033[0;32m
YELLOW = \033[0;33m
CYAN = \033[0;36m
NC = \033[0m # No Color

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
    SET_ENV_DEV = DJANGO_ENV=dev
    SET_ENV_TEST = DJANGO_ENV=test
    SET_ENV_PROD = DJANGO_ENV=prod
    SET_ENV_PRESERVE =
endif

help:
	@echo -e "$(CYAN)Deploy Django Template - Comandi disponibili:$(NC)"
	@echo -e "$(GREEN)make run-server$(NC)    Avvia il server di sviluppo Django"
	@echo -e "$(GREEN)make run-dev$(NC)       Avvia il server di sviluppo in ambiente DEV"
	@echo -e "$(GREEN)make run-test$(NC)      Avvia il server di sviluppo in ambiente TEST"
	@echo -e "$(GREEN)make run-prod$(NC)      Avvia il server di sviluppo in ambiente PROD"
	@echo -e "$(GREEN)make test$(NC)          Esegue i test del progetto"
	@echo -e "$(GREEN)make test-dev$(NC)      Esegue i test in ambiente DEV"
	@echo -e "$(GREEN)make test-test$(NC)     Esegue i test in ambiente TEST (predefinito)"
	@echo -e "$(GREEN)make test-prod$(NC)     Esegue i test in ambiente PROD"
	@echo -e "$(GREEN)make migrate$(NC)       Applica le migrazioni al database"
	@echo -e "$(GREEN)make migrate-dev$(NC)   Applica le migrazioni in ambiente DEV"
	@echo -e "$(GREEN)make migrate-test$(NC)  Applica le migrazioni in ambiente TEST"
	@echo -e "$(GREEN)make migrate-prod$(NC)  Applica le migrazioni in ambiente PROD"
	@echo -e "$(GREEN)make makemigrations$(NC) Crea nuove migrazioni"
	@echo -e "$(GREEN)make shell$(NC)         Avvia una shell Python con contesto Django"
	@echo -e "$(GREEN)make check-env$(NC)     Controlla l'ambiente corrente"
	@echo -e "$(GREEN)make check-custom-logs LOGS_DIR=/path/to/logs ENV=dev|test|prod$(NC) Verifica la configurazione personalizzata dei log"
	@echo -e "$(GREEN)make shell-dev$(NC)     Avvia una shell in ambiente DEV"
	@echo -e "$(GREEN)make shell-test$(NC)    Avvia una shell in ambiente TEST"
	@echo -e "$(GREEN)make shell-prod$(NC)    Avvia una shell in ambiente PROD"
	@echo -e "$(GREEN)make check-env$(NC)     Controlla l'ambiente corrente"
	@echo -e "$(GREEN)make check-env-dev$(NC) Controlla l'ambiente DEV"
	@echo -e "$(GREEN)make check-env-test$(NC) Controlla l'ambiente TEST"
	@echo -e "$(GREEN)make check-env-prod$(NC) Controlla l'ambiente PROD"
	@echo -e "$(GREEN)make check-custom-logs LOGS_DIR=/path/to/logs ENV=dev$(NC) Verifica directory log personalizzata"
	@echo -e "$(GREEN)make lint$(NC)          Esegue i controlli di qualità del codice"
	@echo -e "$(GREEN)make format$(NC)        Formatta il codice Python e i template"
	@echo -e "$(GREEN)make sonarqube$(NC)     Esegue l'analisi SonarQube locale"
	@echo -e "$(GREEN)make add-docstrings$(NC) Aggiunge docstring a tutti i file Python del progetto"
	@echo -e "$(GREEN)make help$(NC)          Mostra questo messaggio di aiuto"

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
	uv run black .
	uv run isort .
	uv run djlint . --reformat

format-markdown:
	@echo "Correzione automatica dei file Markdown..."
	npx prettier --write "**/*.md"
	npx markdownlint-cli2 --fix "**/*.md"

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

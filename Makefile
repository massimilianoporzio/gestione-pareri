.PHONY: run-server test migrate makemigrations shell lint format help

# Colori
GREEN = \033[0;32m
YELLOW = \033[0;33m
CYAN = \033[0;36m
NC = \033[0m # No Color

help:
	@echo -e "$(CYAN)Deploy Django Template - Comandi disponibili:$(NC)"
	@echo -e "$(GREEN)make run-server$(NC)    Avvia il server di sviluppo Django"
	@echo -e "$(GREEN)make test$(NC)          Esegue i test del progetto"
	@echo -e "$(GREEN)make migrate$(NC)       Applica le migrazioni al database"
	@echo -e "$(GREEN)make makemigrations$(NC) Crea nuove migrazioni"
	@echo -e "$(GREEN)make shell$(NC)         Avvia una shell Python con contesto Django"
	@echo -e "$(GREEN)make lint$(NC)          Esegue i controlli di qualità del codice"
	@echo -e "$(GREEN)make format$(NC)        Formatta il codice Python e i template"
	@echo -e "$(GREEN)make help$(NC)          Mostra questo messaggio di aiuto"

run-server:
	@echo -e "$(CYAN)Avvio del server di sviluppo Django...$(NC)"
	uv run src/manage.py runserver

test:
	@echo -e "$(CYAN)Esecuzione dei test...$(NC)"
	uv run src/manage.py test

migrate:
	@echo -e "$(CYAN)Applicazione delle migrazioni...$(NC)"
	uv run src/manage.py migrate

makemigrations:
	@echo -e "$(CYAN)Creazione delle migrazioni...$(NC)"
	uv run src/manage.py makemigrations

shell:
	@echo -e "$(CYAN)Avvio della shell Django...$(NC)"
	uv run src/manage.py shell

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

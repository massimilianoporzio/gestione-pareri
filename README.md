# Deploy Django - Template Repository

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=flat)](https://pycqa.github.io/isort/)
[![flake8](https://img.shields.io/badge/linting-flake8-yellowgreen)](https://github.com/PyCQA/flake8)
[![ruff](https://img.shields.io/badge/ruff-enabled-blueviolet)](https://github.com/charliermarsh/ruff)
[![pylint](https://img.shields.io/badge/pylint-enabled-orange)](https://github.com/PyCQA/pylint)
[![djlint](https://img.shields.io/badge/djlint-HTML%20linting-blue)](https://github.com/Riverside-Healthcare/djlint)
[![Django](https://img.shields.io/badge/Django-5.2.0-green.svg)](https://www.djangoproject.com/)
[![Python 3.13+](https://img.shields.io/badge/python-3.13+-blue.svg)](https://www.python.org/downloads/release/python-3130/)
[![uv](https://img.shields.io/badge/uv-package%20manager-blueviolet)](https://github.com/astral-sh/uv)
[![Pre-commit](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml)
[![Django CI](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml)
[![pre-commit-hooks](https://img.shields.io/badge/pre--commit--hooks-enabled-brightgreen)](https://github.com/pre-commit/pre-commit-hooks)
[![VS Code](https://img.shields.io/badge/VS%20Code-Ready-007ACC?logo=visual-studio-code)](https://code.visualstudio.com/)
[![Run on Save](https://img.shields.io/badge/Run%20on%20Save-enabled-success)](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%20enabled-2088FF)](https://github.com/features/actions)

Questo è un **template repository** per progetti Django, già configurato con strumenti moderni per lo sviluppo, la qualità del codice e il deployment. Questo template è progettato per aiutarti a iniziare rapidamente un nuovo progetto Django con best practices già implementate.

## 🚀 Come utilizzare questo template

1. Clicca sul pulsante verde **"Use this template"** in alto a destra della pagina GitHub
2. Seleziona **"Create a new repository"**
3. Inserisci il nome del tuo nuovo repository e altre informazioni
4. Clicca su **"Create repository from template"**
5. Una volta creato, clona il nuovo repository sulla tua macchina:

   ```bash
   git clone https://github.com/tuousername/tuo-nuovo-repo.git
   cd tuo-nuovo-repo
   ```

## 🔧 Requisiti

- Python 3.13+
- [uv](https://github.com/astral-sh/uv) - Gestore di pacchetti Python veloce e moderno
- Visual Studio Code (consigliato per l'integrazione automatica)

## 🔨 Setup iniziale

1. Crea e attiva un ambiente virtuale:

   ```bash
   uv venv

   # In Windows PowerShell:
   .\.venv\Scripts\Activate.ps1

   # In Linux/macOS:
   source .venv/bin/activate
   ```

2. Installa le dipendenze:

   ```bash
   uv sync
   ```

3. Installa e configura pre-commit:

   ```bash
   uv add pre-commit
   pre-commit install
   ```

4. **Importante**: Se desideri usare un modello User personalizzato, crealo **prima** di eseguire le migrazioni. Consulta la [guida rapida](docs/quick-start.md) per maggiori dettagli.

5. Avvia il server di sviluppo:

   ```bash
   cd src
   python manage.py runserver
   ```

## 🛠️ Strumenti di sviluppo integrati

Questo template include i seguenti strumenti configurati e pronti all'uso:

- **black**: Formattatore di codice Python, garantisce uno stile coerente
- **isort**: Organizza automaticamente gli import Python
- **flake8**: Linter Python per identificare errori di stile e potenziali bug
- **ruff**: Linter Python ultra-veloce (sostituto moderno di flake8)
- **pylint**: Linter Python avanzato per analisi di codice approfondita
- **djlint**: Formattatore e linter specifico per template HTML Django
- **pre-commit**: Esegue automaticamente tutti i controlli di qualità prima di ogni commit
- **GitHub Actions**: Pipeline CI/CD preconfigurate per verificare automaticamente la qualità del codice

## 📝 Integrazione con VS Code

Questo template include configurazioni VS Code ottimizzate:

1. Formattazione automatica al salvataggio per tutti i file
2. Evidenziazione di errori in tempo reale con Error Lens
3. Configurazioni specifiche per ciascun linter/formattatore
4. "Run on Save" per formattare automaticamente i template HTML Django

Estensioni VS Code consigliate (già configurate):

- Black Formatter
- isort
- Pylint
- Ruff
- Error Lens
- Git Graph
- markdownlint

## 🔄 Formattazione automatica dei template HTML

I template HTML Django vengono formattati automaticamente in due modi:

1. **Durante il pre-commit**: Ogni commit esegue djlint sui template modificati
2. **In VS Code**: Al salvataggio di un file HTML, viene eseguito djlint tramite "Run on Save"

## 🚢 CI/CD

Il repository include workflow GitHub Actions preconfigurati:

1. **Pre-commit workflow**: Esegue tutti i check di pre-commit su ogni PR e push
2. **Django CI workflow**: Esegue i test Django automaticamente

## 📋 Struttura del progetto

```bash
deploy-django/
├── .github/workflows/    # Configurazioni GitHub Actions
├── .vscode/              # Configurazioni VS Code
├── src/                  # Codice sorgente Django
│   ├── manage.py         # Script di gestione Django
│   └── home/             # Progetto Django principale
├── .pre-commit-config.yaml  # Configurazione pre-commit
├── pyproject.toml        # Configurazione strumenti Python
└── README.md             # Questo file
```

## 🤝 Contribuire

Se vuoi migliorare questo template, sentiti libero di aprire una issue o una pull request nel repository originale.

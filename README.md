# Deploy Django - Template Repository

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=flat)](https://pycqa.github.io/isort/)
[![flake8](https://img.shields.io/badge/linting-flake8-yellowgreen)](https://github.com/PyCQA/flake8)
[![ruff](https://img.shields.io/badge/ruff-enabled-blueviolet)](https://github.com/charliermarsh/ruff)
[![pylint](https://img.shields.io/badge/pylint-enabled-orange)](https://github.com/PyCQA/pylint)
[![djlint](https://img.shields.io/badge/djlint-HTML%20linting-blue)](https://github.com/Riverside-Healthcare/djlint)
[![Prettier](https://img.shields.io/badge/prettier-markdown-ff69b4)](https://prettier.io/)
[![markdownlint](https://img.shields.io/badge/markdownlint-enabled-brightgreen)](https://github.com/DavidAnson/markdownlint)
[![Django](https://img.shields.io/badge/Django-5.2.0-green.svg)](https://www.djangoproject.com/)
[![Python 3.13+](https://img.shields.io/badge/python-3.13+-blue.svg)](https://www.python.org/downloads/release/python-3130/)
[![uv](https://img.shields.io/badge/uv-package%20manager-blueviolet)](https://github.com/astral-sh/uv)
[![Make](https://img.shields.io/badge/Make-automation-brightgreen)](https://www.gnu.org/software/make/)
[![Pre-commit](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml)
[![Django CI](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml)
[![CodeQL](https://github.com/massimilianoporzio/deploy-django/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/codeql-analysis.yml)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/679bcf1491f346a89508bc8c2aff64da)](https://app.codacy.com/gh/massimilianoporzio/deploy-django/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
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

### Utilizzo degli script di setup automatici

Per un setup completo e automatico, puoi usare gli script forniti:

**Windows (PowerShell):**

```powershell
.\scripts\setup.ps1
```

**macOS/Linux (Bash):**

```bash
chmod +x scripts/setup.sh  # Rendi lo script eseguibile
./scripts/setup.sh
```

### Setup manuale

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

4. Configura le variabili d'ambiente:

   ```bash
   # Copia il file di esempio
   cp .env.example .env

   # Modifica il file .env con i tuoi valori
   code .env
   ```

   Per maggiori dettagli, consulta la [documentazione sulle variabili d'ambiente](docs/environment-variables.md).

5. **Importante**: Se desideri usare un modello User personalizzato, crealo **prima** di eseguire le migrazioni. Consulta la [guida rapida](docs/quick-start.md) per maggiori dettagli.

6. Avvia il server di sviluppo:

   ```bash
   cd src

   # Usando uv (consigliato):
   uv run python manage.py runserver

   # Usando l'ambiente virtuale:
   # Attiva prima l'ambiente (.\.venv\Scripts\Activate.ps1 o source .venv/bin/activate)
   python manage.py runserver
   ```

## 💻 Esecuzione di comandi Python

Questo template utilizza [uv](https://github.com/astral-sh/uv) come gestore di pacchetti e ambiente virtuale. Ci sono due modi per eseguire comandi Python:

### 1. Usando uv direttamente (consigliato)

Con uv, non è necessario attivare l'ambiente virtuale. Basta usare `uv run` seguito dal comando:

```bash
# Eseguire uno script Python
uv run python mio_script.py

# Eseguire comandi Django
uv run python src/manage.py migrate
uv run python src/manage.py runserver

# Eseguire altri pacchetti Python
uv run black .
uv run pytest
```

### 2. Usando l'ambiente virtuale tradizionale

Se preferisci l'approccio tradizionale, puoi attivare l'ambiente virtuale e poi eseguire i comandi:

```bash
# Windows PowerShell
.\.venv\Scripts\Activate.ps1

# Linux/macOS
source .venv/bin/activate

# Poi esegui i comandi normalmente
python src/manage.py runserver
```

> **Nota**: Gli script nella cartella `examples/` sono progettati per funzionare con entrambi gli approcci.

## 🛠️ Strumenti di sviluppo integrati

Questo template include i seguenti strumenti configurati e pronti all'uso:

- **black**: Formattatore di codice Python, garantisce uno stile coerente
- **isort**: Organizza automaticamente gli import Python
- **flake8**: Linter Python per identificare errori di stile e potenziali bug
- **ruff**: Linter Python ultra-veloce (sostituto moderno di flake8)
- **pylint**: Linter Python avanzato per analisi di codice approfondita
- **djlint**: Formattatore e linter specifico per template HTML Django
- **prettier**: Formattatore per file Markdown e altri linguaggi
- **markdownlint**: Linter specifico per file Markdown
- **pre-commit**: Esegue automaticamente tutti i controlli di qualità prima di ogni commit
- **GitHub Actions**: Pipeline CI/CD preconfigurate per verificare automaticamente la qualità del codice

> **Nota**: I file del modulo `settings` sono esclusi dai controlli di linting per permettere la massima flessibilità. Per maggiori dettagli, consulta [docs/linting_notes.md](docs/linting_notes.md).

## 📊 Logging configurato

Il template include un sistema di logging avanzato:

- **Log colorati in console**: Durante lo sviluppo (DEBUG=True), i log vengono visualizzati in console con colori per ogni livello di severità
- **Log su file**: In produzione, i log vengono salvati automaticamente in file con rotazione
- **Facile integrazione**: Logger già configurati per l'uso immediato nei tuoi moduli
- **Directory dei log personalizzabile**: Puoi specificare una directory personalizzata per i log tramite la variabile d'ambiente `DJANGO_LOGS_DIR`

```bash
# Windows PowerShell
$env:DJANGO_LOGS_DIR = "E:\percorso\personalizzato\logs"

# macOS/Linux
export DJANGO_LOGS_DIR="/percorso/personalizzato/logs"

# Verifica configurazione tramite Makefile
make check-custom-logs LOGS_DIR="/percorso/personalizzato/logs" ENV=dev|test|prod
```

Per maggiori dettagli, consulta la [documentazione sul logging](docs/logs_configuration.md).

## 🌐 Compatibilità multipiattaforma

Questo template è progettato per funzionare su tutte le principali piattaforme:

- **Windows**: Script PowerShell completi per setup e configurazione
- **macOS/Linux**: Script Bash equivalenti per tutte le operazioni
- **CI/CD**: Workflow GitHub Actions che funzionano indipendentemente dalla piattaforma

Tutti gli strumenti di sviluppo sono configurati per funzionare in modo identico su tutte le piattaforme, garantendo un'esperienza di sviluppo coerente per tutti i membri del team.

## 📝 Integrazione con VS Code

Questo template include configurazioni VS Code ottimizzate:

1. Formattazione automatica al salvataggio per tutti i file
2. Evidenziazione di errori in tempo reale con Error Lens
3. Configurazioni specifiche per ciascun linter/formattatore
4. "Run on Save" per formattare automaticamente i template HTML Django

### Estensioni VS Code consigliate

Il progetto è configurato per funzionare con le seguenti estensioni:

| Estensione      | ID                               | Descrizione                                       |
| --------------- | -------------------------------- | ------------------------------------------------- |
| Black Formatter | `ms-python.black-formatter`      | Formatta il codice Python utilizzando Black       |
| isort           | `ms-python.isort`                | Organizza automaticamente gli import Python       |
| Pylint          | `ms-python.pylint`               | Analizzatore di codice Python per rilevare errori |
| Ruff            | `charliermarsh.ruff`             | Linter Python ultrarapido                         |
| Error Lens      | `usernamehw.errorlens`           | Evidenzia errori e avvisi direttamente nel codice |
| Git Graph       | `mhutchie.git-graph`             | Visualizza il grafico dei commit di Git           |
| markdownlint    | `davidanson.vscode-markdownlint` | Linting per file Markdown                         |
| Prettier        | `esbenp.prettier-vscode`         | Formattatore di codice per vari linguaggi         |
| Run On Save     | `emeraldwalk.RunOnSave`          | Esegue comandi quando si salva un file            |
| Django          | `batisteo.vscode-django`         | Supporto per template e sintassi Django           |

### Configurazione `.vscode`

La cartella `.vscode` contiene il file `settings.json` che configura automaticamente l'editor:

```json
{
  // Configurazione per file HTML e Django templates
  "[html]": { "editor.formatOnSave": false },
  "[django-html]": { "editor.formatOnSave": false },

  // Run on Save - esegue formattatori quando si salvano i file
  "emeraldwalk.runonsave": {
    "commands": [
      // Formatta HTML/Django templates con djlint
      {
        "match": "\\.(html|djhtml|django-html)$",
        "cmd": "uv run djlint \"${file}\" --reformat --ignore H030"
      },
      // Organizza import Python con isort
      { "match": "\\.py$", "cmd": "uv run isort \"${file}\"" },
      // Formatta Markdown con Prettier e markdownlint
      {
        "match": "\\.(md|markdown)$",
        "cmd": "prettier --write \"${file}\" && markdownlint-cli2-fix \"${file}\""
      }
    ]
  },

  // Configurazione Python (Black, Pylint, isort)
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.formatOnSave": true
  },
  "black-formatter.args": ["--line-length=120"],
  "python.linting.pylintEnabled": true,
  "python.linting.enabled": true,

  // Configurazione Markdown (Prettier)
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  }
}
```

Questa configurazione permette un'esperienza di sviluppo coerente per tutti i membri del team e applica automaticamente le regole di stile del progetto.

## 🔄 Formattazione automatica dei template HTML

I template HTML Django vengono formattati automaticamente in due modi:

1. **Durante il pre-commit**: Ogni commit esegue djlint sui template modificati
2. **In VS Code**: Al salvataggio di un file HTML, viene eseguito djlint tramite "Run on Save"

## 🛠️ Automazione con Make

Questo template include un sistema di automazione basato su Make per semplificare l'esecuzione di comandi comuni:

```bash
# Avvia il server di sviluppo Django
make run-server
```

Per una lista completa dei comandi disponibili e istruzioni su come installare Make, consulta la [documentazione su Make](docs/make.md).

### Installazione di Make

**Windows:**

```powershell
.\scripts\install-make-windows.ps1
```

**macOS:**

```bash
chmod +x scripts/install-make-macos.sh
./scripts/install-make-macos.sh
```

**Linux:**

```bash
chmod +x scripts/install-make-linux.sh
./scripts/install-make-linux.sh
```

## 📝 Formattazione automatica dei file Markdown

I file Markdown vengono formattati e controllati automaticamente:

1. **Durante il pre-commit**: Prettier formatta i file Markdown seguendo le regole in `.prettierrc.json`
2. **Controllo della qualità**: Markdownlint controlla i file Markdown secondo le regole in `.markdownlint-cli2.jsonc`
3. **In VS Code**: Al salvataggio di un file Markdown, vengono eseguiti Prettier e markdownlint-cli2-fix tramite "Run on Save"

Per personalizzare le regole:

- Modifica `.prettierrc.json` per la formattazione
- Modifica `.markdownlint-cli2.jsonc` per le regole di linting

Per dettagli completi, consulta la [documentazione sulla formattazione Markdown](docs/markdown-formatting.md).

Per configurare gli strumenti necessari:

```bash
# Windows (PowerShell)
.\scripts\install-markdown-tools.ps1

# macOS/Linux (Bash)
chmod +x scripts/install-markdown-tools.sh
./scripts/install-markdown-tools.sh
```

## 🚢 CI/CD

Il repository include workflow GitHub Actions preconfigurati:

1. **Pre-commit workflow**: Esegue tutti i check di pre-commit su ogni PR e push
2. **Django CI workflow**: Esegue i test Django automaticamente

## 📋 Struttura del progetto

```bash
deploy-django/
├── .config/              # File di configurazione centralizzati
│   ├── djlintrc          # Configurazione per djlint
│   ├── flake8            # Configurazione per flake8
│   ├── markdownlint.json # Configurazione per markdownlint
│   ├── .pylintrc         # Configurazione per pylint (backup)
│   └── ruff.toml         # Configurazione per ruff
├── .github/workflows/    # Configurazioni GitHub Actions
├── .vscode/              # Configurazioni VS Code
├── docs/                 # Documentazione
├── examples/             # Esempi di utilizzo
│   ├── logging_example.py # Esempio di utilizzo del logging
│   └── README.md         # Guida agli esempi
├── logs/                 # Directory per i file di log
├── scripts/              # Script di utilità per setup del progetto
│   ├── setup.ps1         # Script di setup per Windows
│   ├── setup.sh          # Script di setup per macOS/Linux
│   ├── install-markdown-tools.ps1  # Installazione strumenti Markdown per Windows
│   ├── install-markdown-tools.sh   # Installazione strumenti Markdown per macOS/Linux
│   ├── install-make-windows.ps1    # Installazione Make per Windows
│   ├── install-make-macos.sh       # Installazione Make per macOS
│   ├── install-make-linux.sh       # Installazione Make per Linux
│   └── README.md         # Documentazione degli script
├── tools/                # Script di utilità per sviluppo e debug
│   ├── check_env.py      # Verifica variabili d'ambiente
│   ├── check_import.py   # Verifica importazione moduli
│   ├── check_settings.py # Verifica impostazioni Django
│   └── env_test.py       # Test delle variabili d'ambiente
├── src/                  # Codice sorgente Django
│   ├── manage.py         # Script di gestione Django
│   └── home/             # Progetto Django principale
├── .pre-commit-config.yaml # Configurazione pre-commit
├── .markdownlint.json    # Configurazione markdownlint per strumenti che la cercano nella root
├── .pylintrc             # Configurazione pylint
├── .flake8               # Configurazione flake8
├── Makefile              # Automazione con Make
├── pyproject.toml        # Configurazione strumenti Python
└── README.md             # Questo file
```

## 📚 Documentazione

Questo progetto include documentazione dettagliata per aiutarti a comprendere le funzionalità e le configurazioni:

- [Variabili d'ambiente](docs/environment-variables.md): Configurazione delle variabili d'ambiente
- [Configurazione dei logs](docs/logs_configuration.md): Come funziona il sistema di logging
- [Make e automazione](docs/make.md): Utilizzo di Make per automatizzare i task
- [Formattazione Markdown](docs/markdown-formatting.md): Linee guida per la formattazione
- [Note sul linting](docs/linting_notes.md): Configurazione e utilizzo degli strumenti di linting
- [Analisi del codice](docs/code_analysis.md): Strumenti per l'analisi della qualità del codice
- [SonarQube/SonarCloud](docs/sonarqube.md): Configurazione e utilizzo di SonarQube
- [Generazione di docstring](docs/docstring_generation.md): Aggiunta automatica di docstring
- [Quick Start](docs/quick-start.md): Guida rapida per iniziare

## 🤝 Contribuire

Se vuoi migliorare questo template, sentiti libero di aprire una issue o una pull request nel repository originale.

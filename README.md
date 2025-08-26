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
[![Quality Pipeline](https://img.shields.io/badge/Quality%20Pipeline-Local%20Dashboard-success)](tools/quality_dashboard.md)
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
- **Pipeline locale**: Dashboard di qualità completa (`make stats`) con analisi dettagliata alternativa a servizi cloud

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

# Genera dashboard di qualità del codice completa (alternativa locale a Codacy)
make stats

# Corregge automaticamente tutti i problemi di qualità del codice
make fix-all
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
- [Generazione di docstring](docs/docstring_generation.md): Aggiunta automatica di docstring
- [Quick Start](docs/quick-start.md): Guida rapida per iniziare

## 🚀 Best Practices per Progetti in Produzione

Questo template è progettato per essere flessibile e permetterti di iniziare rapidamente. Tuttavia, quando il tuo progetto è pronto per la produzione, dovresti implementare alcune best practices aggiuntive per garantire sicurezza, affidabilità e mantenibilità.

### 🔒 Sicurezza e Branch Protection

#### Protezione del Branch Principale

Per progetti in produzione, è **fortemente raccomandato** configurare la protezione del branch principale:

1. **Vai alle Impostazioni del Repository** → `Settings` → `Branches`
2. **Clicca su "Add rule"** per il branch `main` (o `master`)
3. **Configura le seguenti opzioni**:

   ```yaml
   Branch name pattern: main
   ✅ Restrict pushes that create files: false
   ✅ Require a pull request before merging:
       ✅ Require approvals: 1-2 (a seconda del team)
       ✅ Dismiss stale PR approvals when new commits are pushed
       ✅ Require review from CODEOWNERS
   ✅ Require status checks to pass before merging:
       ✅ Require branches to be up to date before merging
       Required status checks:
         - Pre-commit / pre-commit (GitHub Actions)
         - Django CI / test (ubuntu-latest, 3.13) (GitHub Actions)
         - CodeQL-Analysis / Analyze (python) (GitHub Actions)
   ✅ Require conversation resolution before merging
   ✅ Require signed commits (opzionale, per massima sicurezza)
   ✅ Include administrators (consigliato)
   ```

#### Il File CODEOWNERS: Disciplina per Sviluppatori Singoli

Il file `CODEOWNERS` definisce automaticamente chi deve revieware specifici file quando vengono modificati in una Pull Request. **Anche lavorando da solo**, questo strumento ti aiuta a mantenere disciplina e qualità del codice.

##### 🎯 Perché usare CODEOWNERS da sviluppatore singolo?

- **Review forzata**: Ti obbliga a rivedere criticamente ogni modifica prima del merge
- **Pausa di riflessione**: Rallenta il processo su file critici (cosa buona!)
- **Storico pulito**: Tutte le modifiche documentate tramite Pull Request
- **Protezione da errori**: Una pausa prima di modifiche critiche
- **Preparazione per il team**: Ti abitua a workflow professionali

##### 🔧 Setup pratico

**1. Crea un file CODEOWNERS** nella root del progetto (quando usi questo template):

```bash
# CODEOWNERS - Configurazione per sviluppatore singolo

# File critici - richiedono sempre review attenta
/src/home/settings/ @tuousername
/.github/workflows/ @tuousername
/pyproject.toml @tuousername
**/migrations/ @tuousername
/Makefile @tuousername

# File di configurazione
/.codacy.yml @tuousername
/.pylintrc @tuousername
/.pre-commit-config.yaml @tuousername

# File meno critici (puoi essere più veloce)
*.md @tuousername
/docs/ @tuousername
```

**2. Pattern avanzati supportati:**

```bash
*                          # Tutti i file
*.py                       # Solo file Python
/path/                     # Directory specifica
**/migrations/             # Pattern ricorsivo (migrations ovunque)
*.{yml,yaml}              # Multiple estensioni
/src/home/settings/*.py   # Solo .py in directory specifica
```

##### 🚀 Workflow di sviluppo disciplinato

```bash
# 1. Nuova feature
git checkout -b feature/user-authentication

# 2. Sviluppo normale
# ... modifiche, commit, test ...

# 3. Push e Pull Request
git push origin feature/user-authentication

# 4. Su GitHub:
#    - Crei la Pull Request
#    - GitHub ti chiede automaticamente di revieware i file CODEOWNERS
#    - Fai una review seria: "Tra 6 mesi capirò questo codice?"
#    - Documenti cosa cambia nella descrizione della PR
#    - Solo dopo review attenta, approvi e fai merge

# 5. Il codice arriva in main solo dopo questo processo
```

##### 🎭 Trucchi psicologici per auto-disciplinarsi

- **"Future Self Review"**: Scrivi come se dovessi spiegarlo a te stesso tra 6 mesi
- **"Junior Developer Mindset"**: Documenta come se stessi formando un collega junior
- **"Production Mindset"**: Ogni merge in `main` = deploy in produzione

##### 💡 Vantaggi a lungo termine

- **Storico dettagliato**: Ogni modifica documentata e motivata
- **Rollback facile**: Puoi sempre tornare indietro tramite PR
- **Preparazione team**: Quando arriveranno altri sviluppatori, il processo è già rodato
- **Quality gate**: Errori catturati prima che arrivino in produzione
- **Best practices**: Ti abitui a standard professionali

> **Nota**: Questo approccio può sembrare "overhead" all'inizio, ma ti renderà uno sviluppatore molto più disciplinato e professionale. Inoltre, quando lavorerai in team, sarai già abituato a questi workflow!

#### Variabili d'Ambiente e Segreti

1. **Non committare mai file `.env` in produzione**:

   ```bash
   # Aggiungi al .gitignore (già presente nel template)
   .env
   .env.local
   .env.production
   ```

2. **Usa GitHub Secrets per CI/CD**:

   - `Settings` → `Secrets and variables` → `Actions`
   - Aggiungi segreti come:
     - `DJANGO_SECRET_KEY`
     - `DATABASE_URL`
     - `REDIS_URL`
     - `EMAIL_HOST_PASSWORD`

3. **Gestione Segreti in Produzione**:
   - **Docker**: Usa Docker Secrets o variabili d'ambiente
   - **Cloud**: AWS Parameter Store, Azure Key Vault, Google Secret Manager
   - **Heroku**: Config Vars
   - **Kubernetes**: Secrets e ConfigMaps

### 🤖 AI Code Review: Il Tuo Secondo Parere Automatico

Per avere un confronto objective durante le review, puoi integrare **agenti AI** che analizzano automaticamente ogni Pull Request. Questo ti dà una prospettiva diversa dalla tua e ti aiuta a individuare problemi che potresti non vedere.

#### Agenti AI Raccomandati per Django

**1. CodeRabbit** ⭐ (Review generali)

- Review dettagliate con suggerimenti specifici
- Commenti inline nel codice
- Gratuito per progetti open source
- Setup: [coderabbit.ai](https://coderabbit.ai) → Install GitHub App

**2. Sourcery** 🔥 (Ottimizzazione Python/Django)

- Refactoring automatico per Python
- Specializzato in ottimizzazioni performance
- Suggerimenti pythonic
- Setup: [sourcery.ai](https://sourcery.ai) → GitHub integration

**3. GitHub Copilot Autofix** ⚡ (Correzioni automatiche)

- Suggerisce fix nei commenti delle PR
- Integrazione nativa GitHub
- Incluso con GitHub Copilot ($10/mese)

#### Setup AI Review per il Template

Il template include configurazioni pronte per:

```bash
.coderabbit.yml      # Configurazione CodeRabbit
.sourcery.yaml       # Configurazione Sourcery
.github/workflows/ai-review.yml  # Workflow completo AI review
```

**Workflow automatico:**

1. **Apri Pull Request** → Gli AI iniziano l'analisi
2. **CodeRabbit** commenta miglioramenti e problemi
3. **Sourcery** suggerisce refactoring Python
4. **CodeQL** analizza vulnerabilità di sicurezza
5. **Summary automatico** con tutti i risultati

**Segreti da configurare:**

```bash
# GitHub Secrets → Settings → Secrets and variables → Actions
SOURCERY_TOKEN=your_sourcery_token
# GITHUB_TOKEN è automatico
```

#### Vantaggi del Doppio Review (Tu + AI)

**🧠 Prospettive diverse:**

- **Tu**: Logica business, architettura, UX
- **AI**: Patterns, security, performance, best practices

**🔍 Completezza:**

- **Tu**: "Questo codice fa quello che deve?"
- **AI**: "Questo codice è scritto nel modo migliore possibile?"

**📚 Apprendimento:**

- **L'AI ti insegna** patterns e tecniche che non conoscevi
- **Tu insegni all'AI** il contesto business tramite commenti

**⚡ Velocità:**

- **Review AI immediate** appena apri la PR
- **La tua review** può concentrarsi su logica e architettura

#### Esempio di Review AI Tipica

```diff
// Il tuo codice:
def get_user_posts(user_id):
    user = User.objects.get(id=user_id)
    posts = []
    for post in Post.objects.filter(user=user):
        posts.append(post)
    return posts

// Commento CodeRabbit:
🤖 "Consider optimizing this function:
1. Use get_object_or_404 for better error handling
2. Use select_related to avoid N+1 queries
3. Return queryset directly instead of list"

// Suggerimento Sourcery:
🔧 "Refactor to: return Post.objects.select_related('user').filter(user_id=user_id)"
```

Questo approccio ti **allena a pensare come un senior developer** perché vedi costantemente suggerimenti di qualità professionale! 🚀

### 📊 Monitoring e Logging

#### Configurazione Logging Avanzata

Estendi la configurazione di logging per produzione:

```python
# src/home/settings/prod.py
import logging.config

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '[{levelname}] {asctime} {name} {process:d} {thread:d} {message}',
            'style': '{',
        },
        'json': {
            '()': 'pythonjsonlogger.jsonlogger.JsonFormatter',
            'format': '%(levelname)s %(asctime)s %(name)s %(process)d %(thread)d %(message)s'
        },
    },
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': '/var/log/django/django.log',
            'maxBytes': 1024*1024*50,  # 50 MB
            'backupCount': 5,
            'formatter': 'json',
        },
        'error_file': {
            'level': 'ERROR',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': '/var/log/django/django_errors.log',
            'maxBytes': 1024*1024*50,  # 50 MB
            'backupCount': 5,
            'formatter': 'json',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['file', 'error_file'],
            'level': 'INFO',
            'propagate': True,
        },
        'myapp': {  # Sostituisci con il nome della tua app
            'handlers': ['file', 'error_file'],
            'level': 'INFO',
            'propagate': True,
        },
    },
}
```

#### Monitoring e Alerting

1. **Sentry per Error Tracking**:

   ```bash
   uv add sentry-sdk
   ```

   ```python
   # settings/prod.py
   import sentry_sdk
   from sentry_sdk.integrations.django import DjangoIntegration

   sentry_sdk.init(
       dsn="YOUR_SENTRY_DSN",
       integrations=[DjangoIntegration()],
       traces_sample_rate=1.0,
       send_default_pii=True
   )
   ```

2. **Health Checks**:

   ```python
   # src/home/urls.py
   from django.http import JsonResponse
   from django.db import connections
   from django.core.cache import cache

   def health_check(request):
       checks = {
           'database': False,
           'cache': False,
           'status': 'unhealthy'
       }

       # Database check
       try:
           connections['default'].cursor()
           checks['database'] = True
       except Exception:
           pass

       # Cache check
       try:
           cache.set('health_check', 'ok', 30)
           checks['cache'] = cache.get('health_check') == 'ok'
       except Exception:
           pass

       checks['status'] = 'healthy' if all([checks['database'], checks['cache']]) else 'unhealthy'

       return JsonResponse(checks, status=200 if checks['status'] == 'healthy' else 503)

   urlpatterns = [
       path('health/', health_check, name='health_check'),
       # ... altre URL
   ]
   ```

### 🔧 Performance e Scalabilità

#### Database Optimization

1. **Indici del Database**:

   ```python
   # models.py
   class MyModel(models.Model):
       name = models.CharField(max_length=100, db_index=True)  # Semplice indice

       class Meta:
           indexes = [
               models.Index(fields=['created_at', 'status']),  # Indice composto
               models.Index(fields=['-created_at']),  # Indice per ordinamento DESC
           ]
   ```

2. **Query Optimization**:

   ```python
   # Usa select_related per ForeignKey
   posts = Post.objects.select_related('author').all()

   # Usa prefetch_related per ManyToMany e reverse ForeignKey
   posts = Post.objects.prefetch_related('tags').all()

   # Query con annotazioni per evitare N+1
   from django.db.models import Count
   authors = Author.objects.annotate(post_count=Count('posts'))
   ```

#### Caching Strategy

```python
# settings/prod.py
CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': config('REDIS_URL'),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    }
}

# Cache per sessioni
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
SESSION_CACHE_ALIAS = 'default'

# Template caching
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'OPTIONS': {
            'loaders': [
                ('django.template.loaders.cached.Loader', [
                    'django.template.loaders.filesystem.Loader',
                    'django.template.loaders.app_directories.Loader',
                ]),
            ],
        },
    },
]
```

### 🛡️ Security Best Practices

#### Configurazione Sicurezza

```python
# settings/prod.py

# HTTPS Settings
SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SECURE_HSTS_SECONDS = 31536000  # 1 anno
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True

# Cookie Security
SESSION_COOKIE_SECURE = True
SESSION_COOKIE_HTTPONLY = True
SESSION_COOKIE_SAMESITE = 'Strict'
CSRF_COOKIE_SECURE = True
CSRF_COOKIE_HTTPONLY = True
CSRF_COOKIE_SAMESITE = 'Strict'

# Content Security
SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_BROWSER_XSS_FILTER = True
X_FRAME_OPTIONS = 'DENY'

# Allowed Hosts
ALLOWED_HOSTS = config('ALLOWED_HOSTS', default='').split(',')

# Content Security Policy (richiede django-csp)
CSP_DEFAULT_SRC = ("'self'",)
CSP_STYLE_SRC = ("'self'", "'unsafe-inline'")
CSP_SCRIPT_SRC = ("'self'",)
CSP_IMG_SRC = ("'self'", "data:", "https:")
```

### 🚀 Deployment e DevOps

#### Docker Production Setup

```dockerfile
# Dockerfile.prod
FROM python:3.13-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_ENV production

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        gettext \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Install UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Install dependencies
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Copy project
COPY . .

# Collect static files
RUN uv run python src/manage.py collectstatic --noinput

# Create non-root user
RUN adduser --disabled-password --gecos '' appuser
RUN chown -R appuser:appuser /app
USER appuser

# Run gunicorn
CMD ["uv", "run", "gunicorn", "--bind", "0.0.0.0:8000", "--chdir", "src", "home.wsgi:application"]
```

#### CI/CD Pipeline Avanzata

```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: test_db
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - uses: actions/checkout@v4

      - name: Install uv
        uses: astral-sh/setup-uv@v2

      - name: Set up Python
        run: uv python install 3.13

      - name: Install dependencies
        run: uv sync

      - name: Run tests
        run: |
          uv run python src/manage.py test
          uv run coverage run --source='.' src/manage.py test
          uv run coverage report
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost/test_db
          DJANGO_ENV: test

  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: "fs"
          scan-ref: "."
          format: "sarif"
          output: "trivy-results.sarif"

      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: "trivy-results.sarif"

  deploy:
    needs: [test, security-scan]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'

    steps:
      - uses: actions/checkout@v4

      - name: Deploy to production
        run: |
          # Qui aggiungi i comandi specifici per il tuo deployment
          # Es: kubectl, docker, heroku, etc.
          echo "Deploying to production..."
```

### 📈 Metriche e Analytics

#### Performance Monitoring

```python
# settings/prod.py

# Django Debug Toolbar per staging
if config('ENABLE_DEBUG_TOOLBAR', default=False, cast=bool):
    INSTALLED_APPS += ['debug_toolbar']
    MIDDLEWARE.insert(0, 'debug_toolbar.middleware.DebugToolbarMiddleware')
    INTERNAL_IPS = ['127.0.0.1', '10.0.2.2']

# Database query logging per debug
if config('LOG_DATABASE_QUERIES', default=False, cast=bool):
    LOGGING['loggers']['django.db.backends'] = {
        'level': 'DEBUG',
        'handlers': ['console'],
    }

# New Relic (opzionale)
NEW_RELIC_APP_NAME = config('NEW_RELIC_APP_NAME', default='Django App')
NEW_RELIC_LICENSE_KEY = config('NEW_RELIC_LICENSE_KEY', default=None)
```

### 🔄 Backup e Disaster Recovery

#### Database Backup

```bash
#!/bin/bash
# scripts/backup_db.sh

set -e

DB_NAME=${DATABASE_NAME:-myapp}
BACKUP_DIR=${BACKUP_DIR:-/backups}
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.sql"

# Crea directory backup se non existe
mkdir -p $BACKUP_DIR

# Esegui backup
pg_dump $DATABASE_URL > $BACKUP_FILE

# Comprimi backup
gzip $BACKUP_FILE

# Rimuovi backup più vecchi di 30 giorni
find $BACKUP_DIR -name "db_backup_*.sql.gz" -mtime +30 -delete

echo "Backup completato: ${BACKUP_FILE}.gz"
```

#### Media Files Backup

```python
# management/commands/backup_media.py
from django.core.management.base import BaseCommand
from django.conf import settings
import boto3
import os

class Command(BaseCommand):
    def handle(self, *args, **options):
        s3 = boto3.client('s3')
        media_root = settings.MEDIA_ROOT

        for root, dirs, files in os.walk(media_root):
            for file in files:
                local_path = os.path.join(root, file)
                relative_path = os.path.relpath(local_path, media_root)
                s3_key = f"media-backup/{relative_path}"

                s3.upload_file(local_path, 'my-backup-bucket', s3_key)

        self.stdout.write("Media backup completato")
```

### 📚 Documentazione e Team

#### API Documentation

```python
# settings/base.py
INSTALLED_APPS += [
    'rest_framework',
    'drf_spectacular',  # OpenAPI 3.0
]

REST_FRAMEWORK = {
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
}

SPECTACULAR_SETTINGS = {
    'TITLE': 'My API',
    'DESCRIPTION': 'API documentation',
    'VERSION': '1.0.0',
    'SERVE_INCLUDE_SCHEMA': False,
}

# urls.py
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

urlpatterns += [
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
]
```

#### Team Guidelines

Crea un file `CONTRIBUTING.md` con linee guida per il team:

```markdown
# Contributing Guidelines

## Development Workflow

1. Crea un branch per ogni feature: `git checkout -b feature/nome-feature`
2. Fai commit frequenti con messaggi descrittivi
3. Esegui sempre `make fix-all` prima del commit
4. Apri una Pull Request verso `main`
5. Richiedi almeno una review prima del merge

## Code Standards

- Segui PEP 8 e le configurazioni del progetto
- Scrivi test per ogni nuova feature
- Docstring obbligatorie per funzioni pubbliche
- Maximum line length: 120 caratteri
- Usa type hints quando possibile

## Testing

- `make test` - Esegui tutti i test
- `make test-coverage` - Test con coverage report
- `make fix-all` - Correggi automaticamente problemi di stile
```

Questa guida completa alle best practices mantiene il template flessibile ma fornisce tutte le informazioni necessarie per trasformare un progetto da sviluppo a produzione in modo sicuro e scalabile.

## 🤝 Contribuire

Se vuoi migliorare questo template, sentiti libero di aprire una issue o una pull request nel repository originale.

## 🛠️ Correzione automatica di Ruff e Pylint in VS Code

Questa repository è configurata per correggere automaticamente la maggior parte dei problemi di stile, docstring e import segnalati da **Ruff** e **Pylint** ogni volta che salvi un file Python in VS Code.

### Come funziona

- **Ruff**: corregge automaticamente errori di formattazione, docstring, import, linee troppo lunghe e naming.
- **autopep8**: corregge ulteriori problemi di stile compatibili con Pylint.
- **Script custom**: aggiunge docstring mancanti a moduli, funzioni e metodi secondo lo stile Google richiesto da Ruff.

### Cosa devi fare

1. Assicurati di avere installato le estensioni VS Code:
   - [Run on Save](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave)
   - [Ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff)
2. Salva un file Python (`Ctrl+S`):
   - Verranno eseguiti in sequenza:
     - Ruff (`ruff --fix --unsafe-fixes`)
     - Script docstring custom (`tools/add_docstring.py`)
     - autopep8 (`autopep8 --in-place --aggressive --aggressive`)
   - La maggior parte dei warning di Ruff e Pylint verrà risolta automaticamente.

### Limitazioni

- Alcuni warning di Pylint (es. design, naming non standard, errori logici) non possono essere corretti automaticamente e richiedono intervento manuale.
- Le regole di Ruff sono configurate in `pyproject.toml`.
- Puoi lanciare manualmente la correzione su tutto il progetto con:

  ```bash
  uv run ruff check . --fix --unsafe-fixes
  uv run python tools/add_docstring_batch.py .
  uv run autopep8 --in-place --aggressive --aggressive $(git ls-files '*.py')
  ```

Per dettagli vedi la sezione `.vscode/settings.json` e i file in `tools/`.

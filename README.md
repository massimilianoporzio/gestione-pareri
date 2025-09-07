# 🚀 Deploy Django - Template Repository

## Indice

- [Quick Start](#quick-start-guide)
- [Documentazione principale](#documentazione-hub)
- [Requisiti](#requisiti)
- [Sicurezza](#sicurezza)
- [FAQ](#faq)
- [Contributi & Support](#contributi--support)

## Requisiti

Per utilizzare questo template sono necessari:

- **Python >= 3.13**
- **uv** (gestore pacchetti Python moderno)
- **Node.js** (solo se vuoi integrare strumenti frontend)
- **Git**
- **Make** o **Just** (task runner)

Consigliato:

- **VS Code** come editor di sviluppo
- **Docker** per ambienti isolati (opzionale)

Per dettagli sull'installazione consulta la documentazione nelle sezioni dedicate.

## Quick Start Guide

1. Clona il repository
2. Installa Python, uv, Node.js (se serve)
3. Esegui `just setup` per configurare tutto
4. Consulta la guida [Quick Start](docs/quick-start.md)
5. Usa i comandi `just` per gestire ambienti e test

## Sicurezza

- [ ] Usa sempre HTTPS in produzione
- [ ] Configura ALLOWED_HOSTS con domini specifici
- [ ] Non usare mai DEBUG=True in produzione
- [ ] Usa password complesse per database
- [ ] Configura backup automatici
- [ ] Monitora metriche e log
- [ ] Usa secrets e variabili d'ambiente, mai hardcoded **Come cambio ambiente?** Usa i comandi `just check-env-<env>` e
      modifica le variabili in `.env`. **Come gestisco le secrets?** Vedi la guida
      [Database Security](docs/database-security.md) e
      [Safety CLI](docs/database-security.md#come-usare-safety-cli-e-api-key). **Come risolvo errori act/CodeQL?**
      Consulta la sezione troubleshooting in [docs/environments-guide.md](docs/environments-guide.md).

## Contributi & Support

Consulta anche:

- [Environments Guide](docs/environments-guide.md)

```bash
npm install --save-dev @tailwindcss/cli autoprefixer
npm install --save-dev webpack webpack-cli
npm install --save-dev @babel/core @babel/preset-env
```

```bash
# (empty)
```

```json
{
  "scripts": {
    "build": "webpack --mode production",
    "dev": "webpack --mode development --watch",
    "css": "tailwindcss -i src/static/css/input.css -o src/static/css/style.css"
  }
}
```

[![Prettier](https://img.shields.io/badge/prettier-markdown-ff69b4)](https://prettier.io/)
[![markdownlint](https://img.shields.io/badge/markdownlint-enabled-brightgreen)](https://github.com/DavidAnson/markdownlint)
[![Bandit](https://img.shields.io/badge/Bandit-security--scan-blue?logo=python&logoColor=white)](https://bandit.readthedocs.io/en/latest/)
[![Safety Scan](https://github.com/massimilianoporzio/gestione-pareri/actions/workflows/safety.yml/badge.svg)](https://github.com/massimilianoporzio/gestione-pareri/actions/workflows/safety.yml)
[![Dependabot](https://img.shields.io/badge/dependabot-enabled-brightgreen?logo=dependabot)](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically)

## Documentazione Hub

- [Environments Guide](docs/environments-guide.md) 🌍 - **Guida completa ai 4 ambienti**
- [Just Commands](docs/just.md) 📋 - Task runner moderno (47 comandi)
- [Database Setup](docs/database-setup.md) 🗄️ - PostgreSQL multi-ambiente
- [Database Security](docs/database-security.md) 🔐 - Gestione sicura password
- [Environment Variables](docs/environment-variables.md) 🔧 - Configurazione ambienti
- [Code Quality](tools/quality_dashboard.md) 📊 - Pipeline qualità locale
- [VS Code Setup](docs/vscode-configuration.md) 🔍 - Configurazione editore
  <!-- Framework & Language -->
  [![Django](https://img.shields.io/badge/Django-5.2.0-green.svg)](https://www.djangoproject.com/)
  [![Python 3.13+](https://img.shields.io/badge/python-3.13+-blue.svg)](https://www.python.org/downloads/release/python-3130/)
  [![Node.js Ready](https://img.shields.io/badge/Node.js-Ready-green?logo=node.js&logoColor=white)](docs/nodejs-integration.md)
  <!-- Package Management & Tools -->
  [![uv](https://img.shields.io/badge/uv-Python%20Package%20Manager-blueviolet?logo=python&logoColor=white)](https://github.com/astral-sh/uv)
  [![Make](https://img.shields.io/badge/Make-automation-brightgreen)](https://www.gnu.org/software/make/)
  [![Just](https://img.shields.io/badge/Just-Task%20Runner%20⚡-blueviolet)](https://github.com/casey/just)
  <!-- Deployment & Static Files -->
  [![Uvicorn](https://img.shields.io/badge/Uvicorn-ASGI%20%E2%9A%A1-blueviolet?logo=fastapi&logoColor=white)](https://www.uvicorn.org/)
  [![Gunicorn](https://img.shields.io/badge/Gunicorn-WSGI%20Server-green?logo=gunicorn&logoColor=white)](https://gunicorn.org/)
  [![Waitress](https://img.shields.io/badge/Waitress-WSGI%20Server-yellow)](https://github.com/Pylons/waitress)
  [![PostgreSQL Ready](https://img.shields.io/badge/PostgreSQL-Ready-blue?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
  [![Cross Platform](https://img.shields.io/badge/Cross%20Platform-Windows%20%7C%20macOS%20%7C%20Linux-brightgreen)](scripts/deployment/README.md)
  <!-- Development Environment -->
  [![VS Code](https://img.shields.io/badge/VS%20Code-Ready-007ACC?logo=visual-studio-code)](https://code.visualstudio.com/)
  [![Run on Save](https://img.shields.io/badge/Run%20on%20Save-enabled-success)](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave)
  [![Quality Pipeline](https://img.shields.io/badge/Quality%20Pipeline-Local%20Dashboard-success)](tools/quality_dashboard.md)
  <!-- CI/CD & GitHub Actions -->
  [![Pre-commit](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml)
  [![Django CI](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml)
  [![CodeQL](https://github.com/massimilianoporzio/deploy-django/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/codeql-analysis.yml)
  [![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%20enabled-2088FF)](https://github.com/features/actions)
  <!-- AI Code Review -->
  [![CodeRabbit](https://img.shields.io/badge/CodeRabbit-AI%20Review-purple?logo=ai&logoColor=white)](https://coderabbit.ai)
  [![Codacy Ready](https://img.shields.io/badge/Codacy-Ready-blue?logo=codacy&logoColor=white)](https://www.codacy.com/)
  [![pre-commit-hooks](https://img.shields.io/badge/pre--commit--hooks-enabled-brightgreen)](https://github.com/pre-commit/pre-commit-hooks)
  <!-- Template Features -->
  [![Template Ready](https://img.shields.io/badge/Template-Production%20Ready-success?style=flat-square)](https://github.com/massimilianoporzio/deploy-django)
  [![Multi Environment](https://img.shields.io/badge/Environments-Dev%20%7C%20Test%20%7C%20Prod-blue)](src/home/settings/)
  [![Smart Deploy](https://img.shields.io/badge/Deploy-uvicorn%20%7C%20gunicorn%20%7C%20waitress-orange)](justfile)
  [![Server Management](https://img.shields.io/badge/Server%20Management-ASGI%20%7C%20WSGI%20%7C%20Auto-green)](justfile)
  [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
  [![Template](https://img.shields.io/badge/Template-Use%20This-brightgreen)](https://github.com/massimilianoporzio/deploy-django/generate)
  [![Stars](https://img.shields.io/github/stars/massimilianoporzio/deploy-django?style=social)](https://github.com/massimilianoporzio/deploy-django/stargazers)
  [![Forks](https://img.shields.io/github/forks/massimilianoporzio/deploy-django?style=social)](https://github.com/massimilianoporzio/deploy-django/network/members)
  Questo è un **template repository** per progetti Django, già configurato con strumenti moderni per lo sviluppo, la
  qualità del codice e il deployment. Questo template è progettato per aiutarti a iniziare rapidamente un nuovo progetto
  Django con best practices già implementate.

## FAQ

1. Clicca sul pulsante verde **"Use this template"** in alto a destra della pagina GitHub
2. Seleziona **"Create a new repository"**
3. Inserisci il nome del tuo nuovo repository e altre informazioni
4. Clicca su **"Create repository from template"**
5. Una volta creato, clona il nuovo repository sulla tua macchina:

```bash
git clone <https://github.com/tuousername/tuo-nuovo-repo.git>
```

- [Setup iniziale](setup-iniziale - Configurazione progetto - #%f0%9f%94%a8)
- [Task Runner Just](task-runner-just - Comandi moderni e cross-platform - #%f0%9f%9a%80)
- [Integrazione VS Code](vs-code-integration) - Configurazione editor #%f0%9f%93%9d

### 🌐 Deployment Guides

- [⚡ Uvicorn Integration](docs/uvicorn-integration.md) - ASGI server configuration

### 📖 Documentazione Just & Quality

- [📋 Just Commands](docs/just.md) - Task runner moderno (47 comandi)
- [🗄️ Database Setup](docs/database-setup.md) - PostgreSQL multi-ambiente
- [🔧 Environment Variables](docs/environment-variables.md) - Configurazione ambienti
- [📊 Code Quality](tools/quality_dashboard.md) - Pipeline qualità locale
- [🔍 VS Code Setup](docs/vscode-configuration.md) - Configurazione editore

## 🛠️ Correzione automatica script bash (shfmt)

Per correggere automaticamente la formattazione e alcune best practice degli script bash (es. variabili non quotate,
word splitting), usa **shfmt**.

### Installazione shfmt

**macOS (Homebrew):**

```bash
brew install shfmt
```

**Linux (Debian/Ubuntu):**

```bash
sudo apt-get install shfmt
```

**Windows:**

- Scarica il binario da [shfmt releases](https://github.com/mvdan/sh/releases)
- Aggiungi la cartella del binario a PATH
- Oppure usa [Scoop](https://scoop.sh/):

```powershell
scoop install shfmt
```

**Manuale (tutti gli OS):**

- Scarica da [shfmt releases](https://github.com/mvdan/sh/releases)
- Oppure, se hai Go installato:

```bash
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

### Utilizzo

Correggi tutti gli script bash di deployment:

```bash
shfmt -w scripts/deployment/*.sh
```

Puoi anche usare Just:

```bash
just fix-codacy
```

Questo comando applica le correzioni automatiche a tutti gli script bash di deploy.

## 🔨 Setup iniziale

### Utilizzo degli script di setup automatici

Per un setup completo e automatico, puoi usare gli script forniti: **Windows (PowerShell):**

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

5. **Importante**: Se desideri usare un modello User personalizzato, crealo **prima** di eseguire le migrazioni.
   Consulta la [guida rapida](docs/quick-start.md) per maggiori dettagli.

6. Avvia il server di sviluppo:

   ```bash
   # Usando uv (consigliato):
   uv run python manage.py runserver
   # Usando l'ambiente virtuale:
   # Attiva prima l'ambiente (.\.venv\Scripts\Activate.ps1 o source .venv/bin/activate)
   python manage.py runserver
   ```

## 💻 Esecuzione di comandi Python

Questo template utilizza [uv](https://github.com/astral-sh/uv) come gestore di pacchetti e ambiente virtuale. Ci sono
due modi per eseguire comandi Python:

### 1. Usando uv direttamente (consigliato)

Con uv, non è necessario attivare l'ambiente virtuale. Basta usare `uv run` seguito dal comando:

```bash
# Eseguire uno script Python
uv run mio_script.py
# Eseguire comandi Django
uv run python src/manage.py migrate
uv run python src/manage.py runserver
# Eseguire altri pacchetti Python
uv run black .
```

### 2. Attivando manualmente l'ambiente virtuale

```powershell
# Windows PowerShell
.venv\Scripts\Activate.ps1
```

```bash
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
- **prettier**: Formattore per file Markdown e altri linguaggi
- **markdownlint**: Linter specifico per file Markdown
- **pre-commit**: Esegue automaticamente tutti i controlli di qualità prima di ogni commit
- **GitHub Actions**: Pipeline CI/CD preconfigurate per verificare automaticamente la qualità del codice
- **Pipeline locale**: Dashboard di qualità completa (`just stats` o `make stats`) con analisi dettagliata alternativa a
  servizi cloud
  > **Nota**: I file del modulo `settings` sono esclusi dai controlli di linting per permettere la massima flessibilità.
  > Per maggiori dettagli, consulta [docs/linting_notes.md](docs/linting_notes.md).

## 🚀 Task Runner: Just

Questo template usa **Just** come task runner moderno per un'esperienza di sviluppo ottimale:

### ⚡ **Just - Task Runner Moderno**

```bash
# Mostra help colorato con emoji
just
# Esempi di comandi più utilizzati
just setup           #  Setup completo progetto
just dev             # 25 Server sviluppo con hot-reload
just fix-all         # 50 Pipeline qualità completa

just deploy          # 0f Deploy automatico multi-platform
just stats           # dcca Statistiche progetto
```

**Perché Just invece di Make?**

- ✅ Sintassi moderna e pulita
- ✅ Supporto nativo Windows PowerShell
- ✅ Output colorato con emoji
- ✅ 47 comandi disponibili vs 30+ Make
- ✅ Help system integrato **Documentazione completa:** ✅ **Cross-platform** nativo (Windows/Linux/macOS) ✅ **Sintassi
  moderna** e leggibile ✅ **Help colorato** con emoji ✅ **Variabili** e logica avanzata ✅ **Performance** superiori

### 📖 **Installazione Just**

Se non hai Just installato:

```powershell
# Windows (Chocolatey)
choco install just
```

```bash
# macOS (Homebrew)
brew install just

# Linux (Snap)
snap install --edge --classic just
# Oppure usa uv direttamente
uv run python src/manage.py migrate  # Invece di just migrate
```

**📖 [Guida Just Completa](docs/just.md)** - Tutti i 47 comandi disponibili

## 📊 Logging configurato

Il template include un sistema di logging avanzato:

- **Log colorati in console**: Durante lo sviluppo (DEBUG=True), i log vengono visualizzati in console con colori per
  ogni livello di severità
- **Log su file**: In produzione, i log vengono salvati automaticamente in file con rotazione
- **Facile integrazione**: Logger già configurati per l'uso immediato nei tuoi moduli
- **Directory dei log personalizzabile**: Puoi specificare una directory personalizzata per i log tramite la variabile
  d'ambiente `DJANGO_LOGS_DIR`

```powershell
# Windows PowerShell
$env:DJANGO_LOGS_DIR = "E:\percorso\personalizzato\logs"
```

```bash
# macOS/Linux
export DJANGO_LOGS_DIR="/percorso/personalizzato/logs"
# Verifica configurazione
just check-custom-logs LOGS_DIR="/percorso/personalizzato/logs" ENV=dev|test|prod
```

Per maggiori dettagli, consulta la [documentazione sul logging](docs/logs_configuration.md).

## 🌐 Compatibilità multipiattaforma

Questo template è progettato per funzionare su tutte le principali piattaforme:

- **Windows**: Script PowerShell completi per setup e configurazione
- **macOS/Linux**: Script Bash equivalenti per tutte le operazioni
- **CI/CD**: Workflow GitHub Actions che funzionano indipendentemente dalla piattaforma Tutti gli strumenti di sviluppo
  sono configurati per funzionare in modo identico su tutte le piattaforme, garantendo un'esperienza di sviluppo
  coerente per tutti i membri del team.

## 📝 VS Code Integration

Questo template include **configurazioni VS Code ottimizzate** per Django: ✅ **Formattazione automatica** al
salvataggio ✅ **Error Lens** per evidenziazione errori inline ✅ **Run on Save** per template HTML Django ✅ **Python +
Django** intellisense completo

### Quick Setup

1. Apri progetto in VS Code
2. Installa estensioni consigliate (VS Code chiederà automaticamente)
3. Sistema pronto! 🚀 **📖 [Guida VS Code Dettagliata](docs/vscode-detailed.md)** - Configurazione completa e
   troubleshooting

## 🌐 Supporto Frontend (Node.js Ready)

Questo template è già predisposto per l'integrazione con Node.js e strumenti frontend moderni:

### 📦 **Configurazione pre-integrata:**

- ✅ **`.gitignore`**: Esclude `node_modules/`, build outputs, e file temporanei
- ✅ **Pre-commit**: Configurato per ignorare directory Node.js durante i controlli di qualità
- ✅ **Struttura directory**: Pronto per `package.json` nella root del progetto

### 🚀 **Setup futuro (quando necessario):**

```bash
# 1. Inizializza package.json
npm init -y
# 2. Installa dipendenze frontend (esempi)
npm install --save-dev @tailwindcss/cli autoprefixer
npm install --save-dev webpack webpack-cli
npm install --save-dev @babel/core @babel/preset-env
# 3. Build script esempio per package.json
{
  "scripts": {
    "build": "webpack --mode production",
    "dev": "webpack --mode development --watch",
    "css": "tailwindcss -i src/static/css/input.css -o src/static/css/style.css"
  }
}
```

### 📁 **Struttura consigliata con Node.js:**

```markdown
deploy-django/
├── src/ # Django source code
│ ├── static/
│ │ ├── css/ # CSS sorgente e compilato
│ │ ├── js/ # JavaScript sorgente
│ │ └── dist/ # Build outputs (ignorato da Git)
├── node_modules/ # Dipendenze Node.js (ignorato da Git)
├── package.json # Configurazione Node.js
├── webpack.config.js # Build configuration
├── tailwind.config.js # Tailwind configuration
└── staticfiles/ # Django collected static files
```

### ⚙️ **Integrazione con Django:**

- I file compilati da Node.js vanno in `src/static/`
- Django collectstatic raccoglie tutto in `staticfiles/`
- WhiteNoise serve i file in produzione con ottimizzazioni
  > **📚 Per maggiori dettagli sull'integrazione Node.js**, consulta la
  > [documentazione Node.js](docs/nodejs-integration.md).

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

## 📝 Markdown Formatting

**Formattazione automatica** per documentazione professionale: 🔄 **Auto-format** su salvataggio VS Code ✅ **Pre-commit
hooks** per consistenza 📖 **Prettier + markdownlint** integration **📖
[Guida Markdown Dettagliata](docs/markdown-formatting.md)** - Configurazione completa e regole

### Quick Commands

```bash
# Format tutti i markdown
just format-markdown
# Linting completo
just lint-markdown
```

## 🚀 Deployment & Production

Supporto completo per **deployment enterprise** con proxy reverso: 🪟 **Windows Server + IIS** - Configurazione
automatica 🐧 **Linux/macOS + Nginx** - Setup production-ready ⚡ **ASGI/WSGI** servers ottimizzati per OS 🔒
**SSL/HTTPS** e sicurezza enterprise

### Quick Deployment

```bash
# Setup automatico
just setup
# Database migration
just migrate-prod
# Deploy production
just deploy
```

### � Guide Complete

- **🪟 [IIS Deployment Guide](docs/iis-deployment.md)** - Windows Server setup completo
- **🐧 [Nginx Deployment Guide](docs/nginx-deployment.md)** - Linux/macOS production setup
- **� [Scripts Deployment](scripts/deployment/README.md)** - Multi-environment e troubleshooting

## 🚢 CI/CD Ready

**GitHub Actions** preconfigurati per qualità e testing: ✅ **Pre-commit workflow** - Check automatici su PR 🧪 **Django
CI** - Test automatici su push 📊 **Quality gates** - Linting e formattazione

## 📁 Project Structure

```text
deploy-django/
├── docs/                    # 📖 Guide specializzate
├── scripts/deployment/      # 🚀 Scripts deployment
├── src/home/                # 🏠 Django app
├── .vscode/                 # ⚙️ VS Code config
├── justfile                 # ⚡ Task runner
├── justfile                 # ⚡ Task runner moderno
└── pyproject.toml           # 🐍 Python config
```

```text
deploy-django/
├── docs/                    # 📖 Guide specializzate
├── scripts/deployment/      # 🚀 Scripts deployment
├── src/home/               # 🏠 Django app
├── .vscode/                # ⚙️ VS Code config
├── justfile                # ⚡ Task runner
├── justfile                # ⚡ Task runner moderno
└── pyproject.toml         # 🐍 Python config
```

## 📚 Documentazione tecnica

Questo progetto include documentazione dettagliata per aiutarti a comprendere le funzionalità e le configurazioni:

- [Uvicorn ASGI Integration](docs/uvicorn-integration.md): 🎯 **Nuovo!** Server ASGI cross-platform raccomandato
- [Variabili d'ambiente](docs/environment-variables.md): Configurazione delle variabili d'ambiente
- [Configurazione dei logs](docs/logs_configuration.md): Come funziona il sistema di logging
- [Just Task Runner](docs/just.md): Task runner moderno con 47 comandi

## 📖 Documentazione Hub

Documentazione specializzata per ogni aspetto del progetto: **📝 Development**

- [Quick Start Guide](docs/quick-start.md) - Inizia qui!
- [Environment Variables](docs/environment-variables.md) - Configurazione sistema
- [Logging Configuration](docs/logs_configuration.md) - Sistema di log avanzato **🔧 Quality & Tools**
- [Markdown Formatting](docs/markdown-formatting.md) - Documentazione professionale
- [Code Analysis](docs/code_analysis.md) - Analisi qualità codice
- [Linting Notes](docs/linting_notes.md) - Configurazione linter **🚀 Advanced**
- [Just Task Runner](docs/just.md) - 47 comandi disponibili
- [Docstring Generation](docs/docstring_generation.md) - Documentazione automatica

---

## 🤝 Contributi & Support

🐛 **Bug Report**: [Apri una Issue](https://github.com/tuousername/deploy-django) ⭐ **Feature Request**:
[Discussioni](https://github.com/tuousername/deploy-django/discussions) 📧 **Support**:
[Template Issues](https://github.com/tuousername/deploy-django/issues) **Made with ❤️ for Django developers**

## 🔒 Controllo vulnerabilità dipendenze con Safety

Safety è installato come dipendenza di sviluppo (`dev`) e viene eseguito automaticamente tramite GitHub Actions su ogni
push e pull request.

### Come funziona la scansione automatica

- Il workflow `Safety Scan` esegue:
  - Installazione ambiente Python
  - Installazione uv
  - Sincronizzazione dipendenze con `uv sync`
  - Scansione delle dipendenze con `uv run safety scan --output screen`
- Se vengono rilevate vulnerabilità, la Action fallisce e segnala il problema direttamente su GitHub.

### Esecuzione manuale locale

- Puoi comunque eseguire Safety localmente con:

  ```bash
  uv sync
  just safety-scan
  ```

### Documentazione Safety

- [Guida Safety](https://github.com/pyupio/safety)

## 🔄 Aggiornamento automatico dipendenze con Dependabot

Questo progetto usa **Dependabot** per mantenere aggiornate le dipendenze Python e le GitHub Actions.

- Dependabot controlla settimanalmente se esistono nuove versioni o patch di sicurezza.
- Crea pull request automatiche per ogni aggiornamento rilevante.
- Puoi gestire le PR direttamente da GitHub, revisionare e fare merge.
- La configurazione si trova in `.github/dependabot.yml`.

### Documentazione Dependabot

- [Guida Dependabot](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically)

## Come usare Safety CLI e API Key

### Registrazione e login

1. Vai su [Safety CLI](https://app.safetycli.com/) e registrati gratuitamente.
2. Dopo la registrazione, accedi e vai sul tuo profilo/account.
3. Trova la sezione “API Key” o “Account Settings” e copia la tua chiave.

### Creazione della secret su GitHub

1. Vai su GitHub, nella pagina del tuo repository.
2. Clicca su **Settings** > **Secrets and variables** > **Actions**.
3. Clicca su **New repository secret**.
4. Inserisci come nome: `SAFETY_API_KEY`
5. Incolla la tua API Key come valore.
6. Salva con **Add secret**.

### Uso in locale

- Per usare Safety CLI localmente, esegui:

  ```bash
  safety login
  # oppure
  safety auth login
  ```

- Incolla la tua API Key quando richiesto.
- Ora puoi eseguire:

  ```bash
  uv run safety scan --output screen
  ```

### Uso in GitHub Actions

- La scansione automatica userà la secret `SAFETY_API_KEY`.
- Non serve login interattivo: la chiave viene letta dal secret tramite la variabile d'ambiente.
- Esempio di configurazione:

```yaml
env:
  SAFETY_API_KEY: ${{ secrets.SAFETY_API_KEY }}
```

- Workflow di esempio e guida ufficiale: [Safety CLI GitHub Actions Docs](https://docs.safetycli.com/ci/github-actions/)

### Note

- Safety richiede la registrazione e login anche per l’uso base.
- La scansione delle dipendenze funziona solo se la chiave è valida.

## 🛡️ Best practice: versioni fisse per tool di linting

Per garantire risultati coerenti tra locale e CI, è consigliato:

- Fissare la versione di tutti i tool di linting, formatting e sicurezza (es. djlint, ruff, flake8, bandit, safety)
  nelle dipendenze e nella configurazione pre-commit.
- Aggiornare la versione solo dopo aver testato e validato le nuove regole.
- Evitare update automatici per questi tool, per non introdurre breaking change o falsi positivi. Questa strategia
  riduce i problemi di divergenza tra ambienti e assicura una pipeline di qualità affidabile.

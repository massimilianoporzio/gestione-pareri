# 🚀 Guida UV - Python Package Manager

UV è il moderno package manager per Python che abbiamo scelto per questo progetto. È incredibilmente veloce (scritto in Rust) e compatibile con pip/virtualenv.

## 📋 Indice

- [🔧 Installazione](#-installazione)
- [⚡ Comandi Quotidiani](#-comandi-quotidiani)
- [🛠️ Setup Ambiente](#️-setup-ambiente)
- [📦 Gestione Dipendenze](#-gestione-dipendenze)
- [🧪 Testing con UV](#-testing-con-uv)
- [🔨 Integrazione con Pre-commit](#-integrazione-con-pre-commit)
- [🎯 Best Practices](#-best-practices)
- [🔍 Troubleshooting](#-troubleshooting)

## 🔧 Installazione

### Windows (PowerShell)

```powershell
# Installazione via pip (se non hai UV)
pip install uv

# Verifica installazione
uv --version
```

### Alternative (Cross-platform)

```bash
# Via pipx (raccomandato)
pipx install uv

# Via pip globale
pip install --user uv

# Via Homebrew (macOS/Linux)
brew install uv
```

## ⚡ Comandi Quotidiani

### 🔥 Setup Iniziale Progetto

```powershell
# 1. Clona e entra nel progetto
git clone <repo-url> gestione-pareri
cd gestione-pareri

# 2. Installa dipendenze (crea automaticamente venv)
uv sync

# 3. Attiva ambiente virtuale
# Windows PowerShell:
.venv\Scripts\Activate.ps1

# Bash/Zsh:
source .venv/bin/activate
```

### 💼 Workflow Sviluppatore Quotidiano

```powershell
# Mattina - Setup rapido
uv sync                    # Aggiorna dipendenze
just test-quick           # Test rapidi (2-3 min)
just run-dev              # Avvia server sviluppo

# Durante sviluppo
uv add requests           # Aggiungi nuova dipendenza
uv add --dev pytest      # Aggiungi dipendenza sviluppo
just test-quick           # Test rapidi dopo modifiche

# Fine giornata - Controlli qualità
just test-pre-deploy      # Test completi (5 min)
just precommit-corporate  # Controlli pre-commit
```

## 🛠️ Setup Ambiente

### 📁 Struttura UV nel Progetto

```
gestione-pareri/
├── pyproject.toml        # Configurazione UV + Django
├── uv.lock              # Lock file (come requirements.txt)
├── .venv/               # Ambiente virtuale (auto-creato)
├── .python-version      # Versione Python fissata
└── src/                 # Codice Django
```

### ⚙️ pyproject.toml - Configurazione

```toml
[project]
name = "gestione-pareri"
version = "0.1.0"
description = "Sistema Gestione Pareri ASL CN1"
requires-python = ">=3.11"

dependencies = [
    "django>=5.2.0,<5.3.0",
    "psycopg[binary]>=3.1.0",
    # ... altre dipendenze core
]

[dependency-groups]
dev = [
    "django-debug-toolbar",
    "django-extensions",
    # ... dipendenze sviluppo
]

test = [
    "pytest",
    "coverage",
    "pytest-django",
    # ... dipendenze testing
]

prod = [
    "gunicorn",
    "uvicorn[standard]",
    "whitenoise",
    # ... dipendenze produzione
]
```

## 📦 Gestione Dipendenze

### ➕ Aggiungere Dipendenze

```powershell
# Dipendenza produzione
uv add "django>=5.2.0"
uv add "requests"

# Dipendenza sviluppo
uv add --dev "django-debug-toolbar"
uv add --dev "pytest"

# Dipendenza specifica gruppo
uv add --group test "coverage"
uv add --group prod "gunicorn"

# Da requirements.txt esistente
uv add -r requirements.txt
```

### 🔄 Aggiornare Dipendenze

```powershell
# Aggiorna tutto
uv sync

# Aggiorna specifico package
uv add "django@latest"

# Aggiorna solo gruppi specifici
uv sync --group prod
uv sync --group test
```

### 🗑️ Rimuovere Dipendenze

```powershell
# Rimuovi pacchetto
uv remove requests

# Rimuovi da gruppo dev
uv remove --dev django-debug-toolbar

# Rimuovi da gruppo specifico
uv remove --group test coverage
```

## 🧪 Testing con UV

### 🚀 Esecuzione Test

```powershell
# Test con uv run (consigliato)
uv run python src/manage.py test

# Test quotidiani (via justfile + uv)
just test-quick           # Usa uv automaticamente

# Test con coverage
uv run coverage run --source='.' src/manage.py test
uv run coverage report
uv run coverage html
```

### 📊 Test Performance

```powershell
# UV è fino a 10-100x più veloce di pip
# Esempio confronto:

# Con pip (OLD - lento):
# pip install -r requirements.txt  # ~60 secondi

# Con UV (NEW - veloce):
uv sync                           # ~5 secondi ⚡

# Creazione venv:
python -m venv .venv             # ~10 secondi
uv venv                          # ~1 secondo ⚡
```

## 🔨 Integrazione con Pre-commit

### 🚀 Installazione Pre-commit via UV

```powershell
# Metodo raccomandato - tool installer UV
uv tool install pre-commit --with pre-commit-uv

# Verifica installazione
pre-commit --version
which pre-commit  # Deve essere in ~/.local/share/uv/tools/pre-commit/bin/
```

### ⚙️ Configurazione Pre-commit

```powershell
# Setup hooks (una sola volta)
pre-commit install

# Test manuale tutti i file
pre-commit run --all-files

# Via justfile (configurato per UV)
just precommit-corporate
```

### 📝 .pre-commit-config.yaml per UV

```yaml
repos:
  # Ruff (linting veloce)
  - repo: <https://github.com/astral-sh/ruff-pre-commit>
    rev: v0.1.6
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]
      - id: ruff-format

  # Django checks
  - repo: local
    hooks:
      - id: django-check
        name: Django Check
        entry: uv run python src/manage.py check
        language: system
        pass_filenames: false

      - id: django-test-quick
        name: Django Quick Tests
        entry: uv run python src/manage.py test --settings=home.settings.test_local accounts.tests.SecurityTest --keepdb -v 0
        language: system
        pass_filenames: false
        stages: [pre-push]
```

## 🎯 Best Practices

### 1. 🔒 Sicurezza Dipendenze

```powershell
# Sempre usare version pinning in produzione
uv add "django==5.2.0"     # Versione fissa
uv add "django>=5.2.0,<5.3.0"  # Range sicuro

# Audit sicurezza (se disponibile)
uv audit  # Futura feature UV
```

### 2. ⚡ Performance

```powershell
# Cache UV (automatica)
# UV mantiene cache globale in ~/.cache/uv/

# Sync senza dev dependencies in produzione
uv sync --group prod --no-dev

# Lock file sempre in git
git add uv.lock
```

### 3. 🔄 Workflow Team

```powershell
# Developer A aggiunge dipendenza
uv add "requests"
git add pyproject.toml uv.lock
git commit -m "Add requests dependency"

# Developer B aggiorna
git pull
uv sync  # Automaticamente installa requests
```

## 🔍 Troubleshooting

### ❌ Problema: "uv: command not found"

```powershell
# Soluzione 1: Reinstalla UV
pip install --user --upgrade uv

# Soluzione 2: Verifica PATH
echo $env:PATH  # Windows PowerShell
echo $PATH      # Bash/Zsh

# Soluzione 3: Usa Python -m
python -m uv --version
```

### ❌ Problema: "No such file or directory: python"

```powershell
# Soluzione: Specifica versione Python
uv python install 3.11
uv venv --python 3.11
```

### ❌ Problema: Pre-commit non trova UV

```powershell
# Soluzione 1: Reinstalla con uv tool
uv tool uninstall pre-commit
uv tool install pre-commit --with pre-commit-uv

# Soluzione 2: Usa sistema PATH
which uv    # Verifica UV nel PATH
pre-commit run --config .pre-commit-config.yaml --all-files
```

### ❌ Problema: Test lenti con UV

```powershell
# Soluzione: Usa --keepdb e cache
uv run python src/manage.py test --keepdb --parallel

# Cache risultati per test-quick
just test-quick  # Usa SQLite + keepdb per velocità
```

## 📚 Risorse Utili

### 🔗 Links Ufficiali

- [UV Documentation](https://docs.astral.sh/uv/)
- [UV GitHub](https://github.com/astral-sh/uv)
- [UV Roadmap](https://github.com/astral-sh/uv/blob/main/ROADMAP.md)

### 📖 Guide Avanzate

- [UV vs pip/pipenv/poetry](https://docs.astral.sh/uv/concepts/projects/)
- [UV Docker Integration](https://docs.astral.sh/uv/guides/integration/docker/)
- [UV CI/CD Setup](https://docs.astral.sh/uv/guides/integration/github/)

### 🤝 Support Interno

- 📋 Vedi `docs/testing-guide.md` per comandi test specifici
- 🔧 Usa `just help` per comandi disponibili
- 🏥 Esegui `just test-health` per diagnostica completa

---

💡 **Tip**: UV è velocissimo! Un `uv sync` completo richiede ~5 secondi vs ~60 secondi con pip tradizionale.

🎯 **Prossimo Passo**: Leggi `docs/testing-guide.md` per il workflow test completo con UV.

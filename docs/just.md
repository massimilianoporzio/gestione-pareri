# Utilizzo di Just Task Runner

[![Just](https://img.shields.io/badge/Just-Task%20Runner-blueviolet)](https://github.com/casey/just)
Questo progetto include un `justfile` che fornisce un moderno task runner per semplificare l'esecuzione di comandi comuni. Just è un'alternativa moderna a Make, con sintassi più pulita e funzionalità avanzate.

## 🚀 Quick Start

```bash
# Mostra tutti i comandi disponibili
just
# Mostra elenco completo
just --list
# Esempi di comandi
just stats          # 📊 Statistiche progetto
just fix-all         # ⭐ Correzione globale
just run-uvicorn     # ⚡ Server ASGI produzione
```

## 📋 Comandi Disponibili (47 comandi)

### 📊 DJANGO & DATABASE

| Comando               | Emoji | Descrizione               |
| --------------------- | ----- | ------------------------- |
| `just run-server`     | 🚀    | Server di sviluppo Django |
| `just run-dev`        | 🔧    | Server sviluppo (DEV)     |
| `just run-test`       | 🧪    | Server sviluppo (TEST)    |
| `just run-prod`       | ⚡    | Server sviluppo (PROD)    |
| `just migrate`        | 📦    | Migrazioni database       |
| `just makemigrations` | 📝    | Crea migrazioni           |
| `just shell`          | 🐚    | Shell Django              |
| `just test`           | 🧪    | Esegue test progetto      |

### 🌐 SERVER & DEPLOY

| Comando               | Emoji | Descrizione                 |
| --------------------- | ----- | --------------------------- |
| `just waitress`       | 🪟    | Server Waitress (Windows)   |
| `just run-uvicorn`    | ⚡    | Server Uvicorn ASGI         |
| `just deploy`         | 🎯    | Deploy automatico           |
| `just deploy-dev`     | 🔧    | Deploy development          |
| `just deploy-staging` | 🧪    | Deploy staging              |
| `just deploy-prod`    | 🚀    | Deploy production           |
| `just stop-servers`   | 🛑    | Ferma tutti i server        |
| `just kill-port`      | 🔪    | Termina processo porta 8000 |

### 🔧 QUALITY & FORMAT

| Comando                    | Emoji | Descrizione                   |
| -------------------------- | ----- | ----------------------------- |
| `just fix-all`             | ⭐    | CORREZIONE GLOBALE completa   |
| `just lint-codacy`         | 🔍    | Controlli qualità Codacy      |
| `just add-docstrings`      | 📝    | Aggiunge docstring mancanti   |
| `just precommit-corporate` | 🏢    | Pre-commit aziendale          |
| `just quality-corporate`   | 🏢    | Quality controlli alternativi |
| `just fix-markdown`        | 📝    | Corregge problemi Markdown    |

### ℹ️ UTILITY

| Comando                    | Emoji | Descrizione              |
| -------------------------- | ----- | ------------------------ |
| `just stats`               | 📊    | Statistiche progetto     |
| `just check-env`           | 🔍    | Controllo ambiente       |
| `just generate-secret-key` | 🔑    | Genera Django SECRET_KEY |

### 🏢 INTRANET AZIENDALE

| Comando                | Emoji | Descrizione                |
| ---------------------- | ----- | -------------------------- |
| `just setup-iis`       | 🌐    | Configura IIS per intranet |
| `just deploy-intranet` | 🚀    | Deploy completo intranet   |

### 🐧 LINUX/macOS NGINX

| Comando             | Emoji | Descrizione                   |
| ------------------- | ----- | ----------------------------- |
| `just setup-nginx`  | 🌐    | Configura Nginx reverse proxy |
| `just deploy-nginx` | 🚀    | Deploy completo con Nginx     |
| `just status-nginx` | 📊    | Status servizi Nginx          |

## 🔧 Installazione di Just

### Windows (PowerShell)

```powershell
# Tramite cargo (Rust)
cargo install just
# Tramite scoop
scoop install just
# Tramite chocolatey
choco install just
```

### macOS

```bash
# Tramite Homebrew
brew install just
# Tramite cargo
cargo install just
```

### Linux

```bash
# Ubuntu/Debian
sudo apt install just
# Arch Linux
pacman -S just
# Tramite cargo
cargo install just
```

## 🎯 Vantaggi di Just rispetto a Make

### ✅ **Sintassi Moderna**

```bash
# Just - Più pulito
run-server:
    @Write-Host "🚀 Avvio server..." -ForegroundColor Cyan
    uv run python src/manage.py runserver
# Make - Più verboso
run-server:
 @echo "Avvio server..."
 uv run python src/manage.py runserver
```

### ✅ **Supporto Nativo Windows**

- Supporto PowerShell nativo
- Colori nel terminale Windows
- Gestione path Windows corretta

### ✅ **Funzionalità Avanzate**

- Variabili globali
- Parametri per ricette
- Dipendenze tra comandi
- Configurazione per shell specifica

### ✅ **Help System Integrato**

```bash
just           # Mostra help personalizzato
just --list    # Lista tutti i comandi
```

## 🔄 Compatibilità con Make

Questo progetto supporta **sia Make che Just**:

- **Make**: Per utenti che preferiscono lo standard tradizionale
- **Just**: Per chi vuole sintassi moderna e funzionalità avanzate
  Puoi usare entrambi interscambiabilmente:

```bash
# Stesso risultato
make stats
just stats
# Stesso risultato
make run-server
just run-server
```

## 📊 Esempio: Pipeline Qualità

```bash
# Just - con colori e emoji
just fix-all
# ⭐ CORREZIONE GLOBALE: Risolve tutti i problemi di qualità del codice
# 🔧 1/10 - Installazione dipendenze sviluppo...
# ✅ 2/10 - Formattazione codice Python (black)...
# ✅ 3/10 - Organizzazione import (isort)...
# ...
# 🎉 Pipeline completata: 10/10 step completati!
# Make - output tradizionale
make fix-all
# CORREZIONE GLOBALE: Risolve tutti i problemi di qualità del codice
# Installazione dipendenze sviluppo...
# Formattazione codice Python (black)...
```

## 🌟 Caratteristiche Principali

### 🎨 **Interfaccia Colorata**

- Output colorato su Windows/macOS/Linux
- Emoji per identificazione rapida comandi
- Progress bar per operazioni lunghe

### ⚡ **Performance**

- Avvio istantaneo (scritto in Rust)
- Parallel execution dove possibile
- Caching intelligente

### 🔧 **Multi-Environment Support**

- Configurazioni per dev/test/prod
- Variabili d'ambiente automatiche
- Server ottimizzati per piattaforma

### 🏢 **Enterprise Ready**

- Configurazioni corporate
- IIS reverse proxy support (Windows)
- Nginx reverse proxy support (Linux/macOS)
- SSL bypass per ambienti aziendali

## 🖥️ Justfile Cross-Platform

Il `justfile` di questo progetto è stato progettato per funzionare su Windows, macOS e Linux. La selezione della shell e la gestione dei comandi avvengono in modo automatico, garantendo output colorato e compatibilità su tutte le piattaforme.

### Esempio di ricetta cross-platform

```just
run-server:
  if [ "$OS" = "Windows_NT" ]; then
    Write-Host "🚀 Avvio server..." -ForegroundColor Cyan
    uv run python src/manage.py runserver
  else
    printf "\033[36m🚀 Avvio server...\033[0m\n"
    uv run python src/manage.py runserver
  fi
```

### Best practice per ricette cross-platform

- Usa variabili per rilevare l'OS (`$OS` o logica shell)
- Gestisci output colorato con PowerShell su Windows e ANSI su Linux/macOS
- Escludi directory di dipendenze e cache in tutti gli strumenti di linting e test
- Documenta le differenze tra ambienti nelle ricette

### Tabella compatibilità ricette

| Ricetta           | Windows | macOS | Linux |
| ----------------- | ------- | ----- | ----- |
| run-server        | ✅      | ✅    | ✅    |
| setup-iis         | ✅      | ❌    | ❌    |
| setup-nginx       | ❌      | ✅    | ✅    |
| quality-corporate | ✅      | ✅    | ✅    |
| deploy-intranet   | ✅      | ❌    | ❌    |
| deploy-nginx      | ❌      | ✅    | ✅    |

## 🔧 Directory da ignorare

Tutti gli strumenti di linting e test sono configurati per ignorare directory di dipendenze e cache:

- `node_modules`, `.venv`, `venv`, `build`, `dist`, `__pycache__`, `.pytest_cache`, `*.egg-info`, `migrations`

Consulta i file di configurazione (`.flake8`, `.pylintrc`, `pytest.ini`, `ruff.toml`, `djlintrc`, `.pre-commit-config.yaml`) per i dettagli.

## 🛠️ Troubleshooting

- Se vedi errori di linting su file di dipendenze, verifica che le directory siano escluse nei file di configurazione.
- Se un comando non funziona su un OS, controlla la logica di shell nel justfile.
- Per output colorato, assicurati che la ricetta usi PowerShell su Windows e ANSI su Linux/macOS.

## 🔒 Controlli di Sicurezza Python

Per analizzare la sicurezza del codice Python viene utilizzato **Bandit**. Assicurati che Bandit sia installato nel tuo ambiente:

```bash
uv add bandit
```

Puoi eseguire la scansione di sicurezza con:

```bash
just security-scan
```

La ricetta è cross-platform e ignora le directory di dipendenze e cache.

### Gestione dei warning nei test e negli script

- Nei test, le password hardcoded sono accettabili. Per evitare warning Bandit, aggiungi il commento `# nosec` accanto alle stringhe di password:

  ```python
  self.password = "testpass123"  # nosec
  user = authenticate(username=self.valid_email, password="wrongpass")  # nosec
  ```

- Negli script che usano `subprocess` in modo sicuro, aggiungi `# nosec` accanto all'import e alle chiamate:

  ```python
  import subprocess  # nosec
  result = subprocess.run(cmd_args, ...)  # nosec
  ```

Consulta la documentazione di Bandit per interpretare i risultati: [Bandit documentation](https://bandit.readthedocs.io/en/latest/).

## 📚 Documentazione Avanzata

Per configurazioni avanzate, consulta:

- [Multi-environment setup](environment-variables.md)
- [IIS Deployment Guide](iis-deployment.md) - Windows Server
- [Nginx Deployment Guide](nginx-deployment.md) - Linux/macOS
- [Deployment scripts](../scripts/deployment/README.md)
- [Quality pipeline](../tools/quality_dashboard.md)
- [Logging configuration](logging_utils.md)

# Deploy Django Template - Comandi disponibili con Just (Cross-platform)
# Per visualizzare tutti i comandi: just --list o just

# Configurazione shell cross-platform
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Variabili globali
python := "uv run"
django_manage := "uv run src/manage.py"

# Helper per OS detection
os_type := if os_family() == "windows" { "windows" } else { "unix" }

# 📋 Comando default: mostra l'help
default:
    #!/usr/bin/env bash
    just color_print "magenta" "🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI"
    just color_print "gray" "============================================================"
    echo ""
    just color_print "green" "📊 DJANGO & DATABASE:"
    just color_print "green" "  just run-server         🚀 Server di sviluppo Django"
    just color_print "green" "  just run-dev            🔧 Server sviluppo (DEV)"
    just color_print "green" "  just run-test           🧪 Server sviluppo (TEST)"
    just color_print "green" "  just run-staging        🎭 Server sviluppo (STAGING)"
    just color_print "green" "  just run-prod           ⚡ Server sviluppo (PROD)"
    just color_print "green" "  just migrate            📦 Migrazioni database"
    just color_print "green" "  just makemigrations     📝 Crea migrazioni"
    just color_print "green" "  just shell              🐚 Shell Django"
    just color_print "green" "  just createsuperuser    👤 Crea superuser"
    just color_print "green" "  just test               🧪 Esegue test progetto"
    echo ""
    just color_print "cyan" "🌐 SERVER & DEPLOY:"
    just color_print "cyan" "  just run-uvicorn        ⚡ Server Uvicorn ASGI"
    just color_print "cyan" "  just deploy-dev         🔧 Deploy development"
    just color_print "cyan" "  just stop-servers       🛑 Ferma tutti i server"
    just color_print "cyan" "  just kill-port PORT     🔪 Termina processo su porta"
    echo ""
    just color_print "yellow" "🔧 QUALITY & FORMAT:"
    just color_print "yellow" "  just fix-all            ⭐ CORREZIONE GLOBALE completa"
    just color_print "yellow" "  just add-docstrings     📝 Aggiunge docstring mancanti"
    echo ""
    just color_print "white" "ℹ️  UTILITY:"
    just color_print "white" "  just check-env          🔍 Controllo ambiente"
    just color_print "white" "  just generate-secret-key 🔑 Genera Django SECRET_KEY"
    just color_print "white" "  just --list             📋 Lista completa comandi"

# Helper functions per colori cross-platform
[private]
color_print color message:
    #!/usr/bin/env bash
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
        # Unix/Linux/macOS - usa codici ANSI
        case "{{color}}" in
            "red")     echo -e "\033[31m{{message}}\033[0m" ;;
            "green")   echo -e "\033[32m{{message}}\033[0m" ;;
            "yellow")  echo -e "\033[33m{{message}}\033[0m" ;;
            "blue")    echo -e "\033[34m{{message}}\033[0m" ;;
            "magenta") echo -e "\033[35m{{message}}\033[0m" ;;
            "cyan")    echo -e "\033[36m{{message}}\033[0m" ;;
            "white")   echo -e "\033[37m{{message}}\033[0m" ;;
            "gray")    echo -e "\033[90m{{message}}\033[0m" ;;
            *)         echo "{{message}}" ;;
        esac
    else
        # Fallback senza colori
        echo "{{message}}"
    fi

# === DJANGO COMMANDS ===

# 🚀 Server di sviluppo
run-server:
    #!/usr/bin/env bash
    just color_print "cyan" "🚀 Avvio del server di sviluppo Django..."
    {{django_manage}} runserver

# 🔧 Server di sviluppo in ambiente DEV
run-dev:
    #!/usr/bin/env bash
    just color_print "cyan" "🔧 Avvio del server di sviluppo in ambiente DEV..."
    export DJANGO_ENV="dev"
    {{django_manage}} runserver

# 🧪 Server di sviluppo in ambiente TEST
run-test:
    #!/usr/bin/env bash
    just color_print "cyan" "🧪 Avvio del server di sviluppo in ambiente TEST..."
    export DJANGO_ENV="test"
    {{django_manage}} runserver

# 🎭 Server di sviluppo in ambiente STAGING
run-staging:
    #!/usr/bin/env bash
    just color_print "cyan" "🎭 Avvio del server di sviluppo in ambiente STAGING..."
    just color_print "yellow" "⚠️  STAGING usa sempre PostgreSQL!"
    export DJANGO_ENV="staging"
    {{django_manage}} runserver

# ⚡ Server di sviluppo in ambiente PROD
run-prod:
    #!/usr/bin/env bash
    just color_print "cyan" "⚡ Avvio del server di sviluppo in ambiente PROD..."
    export DJANGO_ENV="prod"
    {{django_manage}} runserver

# 📦 Migrazioni database
migrate:
    #!/usr/bin/env bash
    just color_print "cyan" "📦 Applicazione delle migrazioni..."
    {{django_manage}} migrate

# 📝 Creazione migrazioni
makemigrations:
    #!/usr/bin/env bash
    just color_print "cyan" "📝 Creazione delle migrazioni..."
    {{django_manage}} makemigrations

# 🐚 Shell Django
shell:
    #!/usr/bin/env bash
    just color_print "cyan" "🐚 Avvio della shell Django..."
    {{django_manage}} shell

# 👤 Crea superuser
createsuperuser:
    #!/usr/bin/env bash
    just color_print "cyan" "👤 Creazione di un superuser..."
    just color_print "yellow" "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it"
    {{django_manage}} createsuperuser

# 🧪 Test del progetto
test:
    #!/usr/bin/env bash
    echo "🧪 Esecuzione dei test..."
    echo "📋 Ambiente: LOCAL con PostgreSQL"
    {{python}} src/manage.py test accounts --settings=home.settings.test_local

# === SERVER & DEPLOYMENT ===

# ⚡ Uvicorn ASGI server - RACCOMANDATO
run-uvicorn:
    #!/usr/bin/env bash
    echo "⚡ Avvio Django con Uvicorn ASGI..."
    echo "🚀 Starting Uvicorn ASGI Server"
    echo "Environment: prod"
    echo "Host: 0.0.0.0:8000"
    echo "📊 Running migrations..."
    {{django_manage}} migrate --no-input
    echo "📁 Collecting static files..."
    {{django_manage}} collectstatic --no-input --clear
    echo "⚡ Starting server..."
    export DJANGO_ENV="prod"
    cd src && {{python}} -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --log-level info --access-log

# 🔧 Deploy development
deploy-dev:
    #!/usr/bin/env bash
    echo "🔧 Avvio server di sviluppo..."
    export DJANGO_ENV="dev"
    {{django_manage}} runserver

# 🛑 Ferma tutti i server Django (cross-platform)
stop-servers:
    #!/usr/bin/env bash
    echo "🛑 Arresto di tutti i server Django..."
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
        # macOS/Linux
        pkill -f "manage.py runserver" || echo "Nessun server Django trovato"
        pkill -f "uvicorn" || echo "Nessun server Uvicorn trovato"
        pkill -f "waitress" || echo "Nessun server Waitress trovato"
    else
        # Windows (tramite Git Bash o WSL)
        taskkill //F //IM python.exe //FI "COMMANDLINE eq *manage.py*" 2>/dev/null || echo "Nessun server Django trovato"
        taskkill //F //IM python.exe //FI "COMMANDLINE eq *uvicorn*" 2>/dev/null || echo "Nessun server Uvicorn trovato"
    fi
    echo "✅ Comando completato"

# 🔪 Termina processi su una specifica porta
kill-port PORT:
    #!/usr/bin/env bash
    echo "🔪 Terminazione processi sulla porta {{PORT}}..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        lsof -ti:{{PORT}} | xargs kill -9 2>/dev/null || echo "Nessun processo trovato sulla porta {{PORT}}"
    elif [[ "$OSTYPE" == "linux"* ]]; then
        # Linux
        fuser -k {{PORT}}/tcp 2>/dev/null || echo "Nessun processo trovato sulla porta {{PORT}}"
    else
        # Windows
        for /f "tokens=5" %a in ('netstat -aon ^| findstr :{{PORT}}') do taskkill /f /pid %a 2>nul || echo "Nessun processo trovato sulla porta {{PORT}}"
    fi

# === QUALITY COMMANDS ===

# 📝 Aggiunge docstring mancanti
add-docstrings:
    #!/usr/bin/env bash
    echo "📝 Aggiunta docstring ai file Python del progetto..."
    {{python}} tools/add_docstring_batch.py .

# ⭐ CORREZIONE GLOBALE: Fix all code quality issues
fix-all:
    #!/usr/bin/env bash
    echo "⭐ Correzione completa di tutti i problemi di qualità del codice..."
    echo "1/6 - Ordinamento import (isort style)..."
    {{python}} -m ruff check --select I --fix . || true
    echo "2/6 - Formattazione con Ruff..."
    {{python}} -m ruff format . || true
    echo "3/6 - Correzione automatica con Ruff..."
    {{python}} -m ruff check . --fix || true
    echo "4/6 - Aggiunta docstring..."
    {{python}} tools/add_docstring_batch.py . || true
    echo "5/6 - Formattazione finale con Ruff..."
    {{python}} -m ruff format . || true
    echo "6/6 - Controlli finali..."
    {{python}} -m ruff check . || true
    echo "✅ Tutti i problemi di qualità del codice sono stati corretti!"

# === UTILITY COMMANDS ===

# 🔍 Controllo ambiente corrente
check-env:
    #!/usr/bin/env bash
    echo "🔍 Controllo dell'ambiente corrente..."
    {{python}} src/test_logging.py

# 🔑 Genera Django SECRET_KEY
generate-secret-key:
    #!/usr/bin/env bash
    echo "🔑 Generazione Django SECRET_KEY..."
    {{python}} -c "from django.core.management.utils import get_random_secret_key; print('SECRET_KEY:', get_random_secret_key())"

# 📊 Statistiche progetto
stats:
    #!/usr/bin/env bash
    echo "📊 Generazione statistiche progetto..."
    {{python}} tools/project_stats.py || echo "⚠️ Strumento statistiche non disponibile"

# 🔐 Genera password PostgreSQL sicure per tutti gli ambienti
generate-db-passwords:
    #!/usr/bin/env bash
    echo "🔐 Generazione password PostgreSQL sicure..."
    {{python}} tools/generate_db_passwords.py || echo "⚠️ Strumento password non disponibile"

# === SYSTEM SPECIFIC COMMANDS ===

# 🍎 Comandi specifici per macOS/Linux
[macos]
[linux]
setup-nginx:
    #!/usr/bin/env bash
    echo "🌐 Configurazione Nginx per Unix/Linux..."
    echo "⚠️  Richiede privilegi sudo!"
    if [ ! -f deployment/nginx.conf ]; then
        echo "❌ File deployment/nginx.conf non trovato!"
        exit 1
    fi
    echo "1/4 - Copia configurazione Nginx..."
    sudo cp deployment/nginx.conf /etc/nginx/sites-available/gestione-pareri
    echo "2/4 - Abilita sito..."
    sudo ln -sf /etc/nginx/sites-available/gestione-pareri /etc/nginx/sites-enabled/
    echo "3/4 - Test configurazione..."
    sudo nginx -t
    echo "4/4 - Ricarica Nginx..."
    sudo systemctl reload nginx
    echo "✅ Nginx configurato con successo!"

# 🪟 Comandi specifici per Windows (solo se necessario)
[windows]
setup-iis:
    @Write-Host "🌐 Configurazione IIS per Windows..." -ForegroundColor Cyan
    @Write-Host "⚠️  Richiede privilegi di amministratore!" -ForegroundColor Yellow
    @PowerShell -ExecutionPolicy Bypass -File "scripts\deployment\setup-iis.ps1"

# === HELP & INFO ===

# 📋 Lista comandi con descrizioni estese
help-extended:
    #!/usr/bin/env bash
    echo "📋 GUIDA ESTESA COMANDI JUST"
    echo "============================================================"
    echo ""
    echo "🚀 COMANDI PRINCIPALI PER SVILUPPO:"
    echo "  just                    - Mostra questo help"
    echo "  just run-dev            - Avvia server sviluppo (porta 8000)"
    echo "  just migrate            - Applica migrazioni database"
    echo "  just makemigrations     - Crea nuove migrazioni"
    echo "  just test              - Esegue test del progetto"
    echo ""
    echo "⚡ COMANDI RAPIDI:"
    echo "  just shell             - Apre shell Django interattiva"
    echo "  just createsuperuser   - Crea account amministratore"
    echo "  just fix-all           - Corregge tutti i problemi di formattazione"
    echo "  just stop-servers      - Ferma tutti i server in esecuzione"
    echo ""
    echo "🔧 TROUBLESHOOTING:"
    echo "  just kill-port 8000    - Libera la porta 8000 se occupata"
    echo "  just check-env         - Verifica configurazione ambiente"
    echo ""
    echo "💡 Per vedere tutti i comandi disponibili: just --list"

# 🎯 Quick start per nuovi sviluppatori
quick-start:
    #!/usr/bin/env bash
    echo "🎯 QUICK START - Setup progetto per sviluppo"
    echo "============================================================"
    echo "1/5 - Installazione dipendenze..."
    uv sync
    echo "2/5 - Applicazione migrazioni..."
    just migrate
    echo "3/5 - Creazione superuser..."
    echo "⚠️  Inserisci i dati amministratore quando richiesto:"
    just createsuperuser
    echo "4/5 - Test configurazione..."
    just check-env
    echo "5/5 - Avvio server di sviluppo..."
    echo "🚀 Il server sarà disponibile su http://localhost:8000"
    echo "📋 Admin panel: http://localhost:8000/admin"
    just run-dev

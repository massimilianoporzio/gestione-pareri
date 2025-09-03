# Ricetta unica per help colorato cross-platform
print_help:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
    printf "\033[35m🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI\033[0m\n"; \
    printf "\033[90m============================================================\033[0m\n"; \
    printf "\033[32m📊 DJANGO & DATABASE:\033[0m\n"; \
    printf "\033[32m  just run-server         🚀 Server di sviluppo Django\033[0m\n"; \
    printf "\033[32m  just run-dev            🔧 Server sviluppo (DEV)\033[0m\n"; \
    printf "\033[32m  just run-test           🧪 Server sviluppo (TEST)\033[0m\n"; \
    printf "\033[32m  just run-staging        🎭 Server sviluppo (STAGING)\033[0m\n"; \
    printf "\033[32m  just run-prod           ⚡ Server sviluppo (PROD)\033[0m\n"; \
    printf "\033[32m  just migrate            📦 Migrazioni database\033[0m\n"; \
    printf "\033[32m  just makemigrations     📝 Crea migrazioni\033[0m\n"; \
    printf "\033[32m  just shell              🐚 Shell Django\033[0m\n"; \
    printf "\033[32m  just createsuperuser    👤 Crea superuser\033[0m\n"; \
    printf "\033[32m  just init-groups        🔐 Inizializza gruppi base\033[0m\n"; \
    printf "\033[32m  just dump-initial-data  💾 Dump dati iniziali\033[0m\n"; \
    printf "\033[32m  just setup-all-environments 🔄 Setup tutti ambienti\033[0m\n"; \
    printf "\033[32m  just test               🧪 Esegue test progetto\033[0m\n"; \
    printf "\033[32m  just test-quick         ⚡ Test rapidi quotidiani\033[0m\n"; \
    printf "\033[32m  just test-security      🔒 Test sicurezza critica\033[0m\n"; \
    printf "\033[32m  just test-pre-deploy    🚀 Test completi pre-deploy\033[0m\n"; \
    printf "\033[32m  just test-dev           🔧 Test ambiente DEV\033[0m\n"; \
    printf "\033[32m  just test-test          🧪 Test ambiente TEST\033[0m\n"; \
    printf "\033[32m  just test-staging       🎭 Test ambiente STAGING\033[0m\n"; \
    printf "\033[32m  just test-prod          ⚡ Test ambiente PROD\033[0m\n"; \
    printf "\n"; \
    printf "\033[36m🌐 SERVER & DEPLOY:\033[0m\n"; \
    printf "\033[36m  just waitress           🪟 Server Waitress (Windows)\033[0m\n"; \
    printf "\033[36m  just run-uvicorn        ⚡ Server Uvicorn ASGI\033[0m\n"; \
    printf "\033[36m  just iis-test-local     🧪 Test IIS locale\033[0m\n"; \
    printf "\033[36m  just iis-deploy         🚀 Deploy completo IIS\033[0m\n"; \
    printf "\033[36m  just iis-setup          ⚙️  Setup iniziale IIS\033[0m\n"; \
    printf "\033[36m  just production-deploy  🏭 Deploy produzione completo\033[0m\n"; \
    printf "\033[36m  just production-update  🔄 Update produzione esistente\033[0m\n"; \
    printf "\033[36m  just deploy             🎯 Deploy automatico\033[0m\n"; \
    printf "\033[36m  just deploy-dev         🔧 Deploy development\033[0m\n"; \
    printf "\033[36m  just deploy-staging     🧪 Deploy staging\033[0m\n"; \
    printf "\033[36m  just deploy-prod        🚀 Deploy production\033[0m\n"; \
    printf "\033[36m  just stop-servers       🛑 Ferma tutti i server\033[0m\n"; \
    printf "\033[36m  just kill-port          🔪 Termina processo porta 8000\033[0m\n"; \
    printf "\n"; \
    printf "\033[33m🔧 QUALITY & FORMAT:\033[0m\n"; \
    printf "\033[33m  just fix-all            ⭐ CORREZIONE GLOBALE completa\033[0m\n"; \
    printf "\033[33m  just lint-codacy        🔍 Controlli qualità Codacy\033[0m\n"; \
    printf "\033[33m  just add-docstrings     📝 Aggiunge docstring mancanti\033[0m\n"; \
    printf "\033[33m  just precommit-corporate 🏢 Pre-commit aziendale\033[0m\n"; \
    printf "\033[33m  just quality-corporate  🏢 Quality controlli alternativi\033[0m\n"; \
    printf "\033[33m  just fix-markdown       📝 Corregge problemi Markdown\033[0m\n"; \
    printf "\n"; \
    printf "\033[97mℹ️  UTILITY:\033[0m\n"; \
    printf "\033[97m  just stats              📊 Statistiche progetto\033[0m\n"; \
    printf "\033[97m  just check-env          🔍 Controllo ambiente\033[0m\n"; \
    printf "\033[97m  just check-env-dev      🔍 Controllo ambiente DEV\033[0m\n"; \
    printf "\033[97m  just check-env-test     🧪 Controllo ambiente TEST\033[0m\n"; \
    printf "\033[97m  just check-env-staging  🎭 Controllo ambiente STAGING\033[0m\n"; \
    printf "\033[97m  just check-env-prod     ⚡ Controllo ambiente PROD\033[0m\n"; \
    printf "\033[97m  just generate-secret-key 🔑 Genera Django SECRET_KEY\033[0m\n"; \
    printf "\033[97m  just generate-secret-keys-all 🔐 Genera tutte le SECRET_KEY\033[0m\n"; \
    printf "\033[97m  just generate-db-passwords 🔐 Genera password DB\033[0m\n"; \
    printf "\033[97m  just create-db-script   🗄️ Crea script SQL\033[0m\n"; \
    printf "\033[97m  just --list             📋 Lista completa comandi\033[0m\n"; \
    printf "\n"; \
    printf "\033[90m# Comandi solo Windows/IIS/PowerShell: vedi commenti nel justfile\033[0m\n"; \
    printf "\033[90m# just iis-test-local, iis-setup, iis-deploy, waitress, open-home, ecc.\033[0m\n"; \
    else \
        powershell -Command "Write-Host '🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI' -ForegroundColor Magenta"; \
        powershell -Command "Write-Host '============================================================' -ForegroundColor Gray"; \
        powershell -Command "Write-Host '📊 DJANGO & DATABASE:' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-server         🚀 Server di sviluppo Django' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-dev            🔧 Server sviluppo (DEV)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-test           🧪 Server sviluppo (TEST)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-staging        🎭 Server sviluppo (STAGING)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-prod           ⚡ Server sviluppo (PROD)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just migrate            📦 Migrazioni database' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just makemigrations     📝 Crea migrazioni' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just shell              🐚 Shell Django' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just createsuperuser    👤 Crea superuser' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just init-groups        🔐 Inizializza gruppi base' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just dump-initial-data  💾 Dump dati iniziali' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just setup-all-environments 🔄 Setup tutti ambienti' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test               🧪 Esegue test progetto' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-quick         ⚡ Test rapidi quotidiani' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-security      🔒 Test sicurezza critica' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-pre-deploy    🚀 Test completi pre-deploy' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-dev           🔧 Test ambiente DEV' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-test          🧪 Test ambiente TEST' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-staging       🎭 Test ambiente STAGING' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-prod          ⚡ Test ambiente PROD' -ForegroundColor Green"; \
        powershell -Command "Write-Host '🌐 SERVER & DEPLOY:' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just waitress           🪟 Server Waitress (Windows)' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just run-uvicorn        ⚡ Server Uvicorn ASGI' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just iis-test-local     🧪 Test IIS locale' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just iis-deploy         🚀 Deploy completo IIS' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just iis-setup          ⚙️  Setup iniziale IIS' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just production-deploy  🏭 Deploy produzione completo' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just production-update  🔄 Update produzione esistente' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy             🎯 Deploy automatico' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy-dev         🔧 Deploy development' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy-staging     🧪 Deploy staging' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy-prod        🚀 Deploy production' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just stop-servers       🛑 Ferma tutti i server' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just kill-port          🔪 Termina processo porta 8000' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '🔧 QUALITY & FORMAT:' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just fix-all            ⭐ CORREZIONE GLOBALE completa' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just lint-codacy        🔍 Controlli qualità Codacy' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just add-docstrings     📝 Aggiunge docstring mancanti' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just precommit-corporate 🏢 Pre-commit aziendale' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just quality-corporate  🏢 Quality controlli alternativi' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just fix-markdown       📝 Corregge problemi Markdown' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host 'ℹ️  UTILITY:' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just stats              📊 Statistiche progetto' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env          🔍 Controllo ambiente' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-dev      🔍 Controllo ambiente DEV' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-test     🧪 Controllo ambiente TEST' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-staging  🎭 Controllo ambiente STAGING' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-prod     ⚡ Controllo ambiente PROD' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just generate-secret-key 🔑 Genera Django SECRET_KEY' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just generate-secret-keys-all 🔐 Genera tutte le SECRET_KEY' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just generate-db-passwords 🔐 Genera password DB' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just create-db-script   🗄️ Crea script SQL' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just --list             📋 Lista completa comandi' -ForegroundColor White"; \
        powershell -Command "Write-Host '# Comandi solo Windows/IIS/PowerShell: vedi commenti nel justfile' -ForegroundColor Gray"; \
        powershell -Command "Write-Host '# just iis-test-local, iis-setup, iis-deploy, waitress, open-home, ecc.' -ForegroundColor Gray"; \
    fi
# Ricette dedicate per stampa colorata
print_magenta:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        printf "\033[35m🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI\033[0m\n"; \
    else \
        powershell -Command "Write-Host '🚀 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI' -ForegroundColor Magenta"; \
    fi

print_gray:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        printf "\033[90m============================================================\033[0m\n"; \
    else \
        powershell -Command "Write-Host '============================================================' -ForegroundColor Gray"; \
    fi

print_green:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        printf "\033[32m📊 DJANGO & DATABASE:\033[0m\n"; \
        printf "\033[32m  just run-server         🚀 Server di sviluppo Django\033[0m\n"; \
        printf "\033[32m  just run-dev            🔧 Server sviluppo (DEV)\033[0m\n"; \
        printf "\033[32m  just run-test           🧪 Server sviluppo (TEST)\033[0m\n"; \
        printf "\033[32m  just run-staging        🎭 Server sviluppo (STAGING)\033[0m\n"; \
        printf "\033[32m  just run-prod           ⚡ Server sviluppo (PROD)\033[0m\n"; \
        printf "\033[32m  just migrate            📦 Migrazioni database\033[0m\n"; \
        printf "\033[32m  just makemigrations     📝 Crea migrazioni\033[0m\n"; \
        printf "\033[32m  just shell              🐚 Shell Django\033[0m\n"; \
        printf "\033[32m  just createsuperuser    👤 Crea superuser\033[0m\n"; \
        printf "\033[32m  just init-groups        🔐 Inizializza gruppi base\033[0m\n"; \
        printf "\033[32m  just dump-initial-data  💾 Dump dati iniziali\033[0m\n"; \
        printf "\033[32m  just setup-all-environments 🔄 Setup tutti ambienti\033[0m\n"; \
        printf "\033[32m  just test               🧪 Esegue test progetto\033[0m\n"; \
        printf "\033[32m  just test-quick         ⚡ Test rapidi quotidiani\033[0m\n"; \
        printf "\033[32m  just test-security      🔒 Test sicurezza critica\033[0m\n"; \
        printf "\033[32m  just test-pre-deploy    🚀 Test completi pre-deploy\033[0m\n"; \
        printf "\033[32m  just test-dev           🔧 Test ambiente DEV\033[0m\n"; \
        printf "\033[32m  just test-test          🧪 Test ambiente TEST\033[0m\n"; \
        printf "\033[32m  just test-staging       🎭 Test ambiente STAGING\033[0m\n"; \
        printf "\033[32m  just test-prod          ⚡ Test ambiente PROD\033[0m\n"; \
    else \
        powershell -Command "Write-Host '📊 DJANGO & DATABASE:' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-server         🚀 Server di sviluppo Django' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-dev            🔧 Server sviluppo (DEV)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-test           🧪 Server sviluppo (TEST)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-staging        🎭 Server sviluppo (STAGING)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just run-prod           ⚡ Server sviluppo (PROD)' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just migrate            📦 Migrazioni database' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just makemigrations     📝 Crea migrazioni' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just shell              🐚 Shell Django' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just createsuperuser    👤 Crea superuser' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just init-groups        🔐 Inizializza gruppi base' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just dump-initial-data  💾 Dump dati iniziali' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just setup-all-environments 🔄 Setup tutti ambienti' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test               🧪 Esegue test progetto' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-quick         ⚡ Test rapidi quotidiani' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-security      🔒 Test sicurezza critica' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-pre-deploy    🚀 Test completi pre-deploy' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-dev           🔧 Test ambiente DEV' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-test          🧪 Test ambiente TEST' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-staging       🎭 Test ambiente STAGING' -ForegroundColor Green"; \
        powershell -Command "Write-Host '  just test-prod          ⚡ Test ambiente PROD' -ForegroundColor Green"; \
    fi

print_cyan:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        printf "\033[36m🌐 SERVER & DEPLOY:\033[0m\n"; \
        printf "\033[36m  just waitress           🪟 Server Waitress (Windows)\033[0m\n"; \
        printf "\033[36m  just run-uvicorn        ⚡ Server Uvicorn ASGI\033[0m\n"; \
        printf "\033[36m  just iis-test-local     🧪 Test IIS locale\033[0m\n"; \
        printf "\033[36m  just iis-deploy         🚀 Deploy completo IIS\033[0m\n"; \
        printf "\033[36m  just iis-setup          ⚙️  Setup iniziale IIS\033[0m\n"; \
        printf "\033[36m  just production-deploy  🏭 Deploy produzione completo\033[0m\n"; \
        printf "\033[36m  just production-update  🔄 Update produzione esistente\033[0m\n"; \
        printf "\033[36m  just deploy             🎯 Deploy automatico\033[0m\n"; \
        printf "\033[36m  just deploy-dev         🔧 Deploy development\033[0m\n"; \
        printf "\033[36m  just deploy-staging     🧪 Deploy staging\033[0m\n"; \
        printf "\033[36m  just deploy-prod        🚀 Deploy production\033[0m\n"; \
        printf "\033[36m  just stop-servers       🛑 Ferma tutti i server\033[0m\n"; \
        printf "\033[36m  just kill-port          🔪 Termina processo porta 8000\033[0m\n"; \
    else \
        powershell -Command "Write-Host '🌐 SERVER & DEPLOY:' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just waitress           🪟 Server Waitress (Windows)' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just run-uvicorn        ⚡ Server Uvicorn ASGI' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just iis-test-local     🧪 Test IIS locale' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just iis-deploy         🚀 Deploy completo IIS' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just iis-setup          ⚙️  Setup iniziale IIS' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just production-deploy  🏭 Deploy produzione completo' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just production-update  🔄 Update produzione esistente' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy             🎯 Deploy automatico' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy-dev         🔧 Deploy development' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy-staging     🧪 Deploy staging' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just deploy-prod        🚀 Deploy production' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just stop-servers       🛑 Ferma tutti i server' -ForegroundColor Cyan"; \
        powershell -Command "Write-Host '  just kill-port          🔪 Termina processo porta 8000' -ForegroundColor Cyan"; \
    fi

print_yellow:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        printf "\033[33m🔧 QUALITY & FORMAT:\033[0m\n"; \
        printf "\033[33m  just fix-all            ⭐ CORREZIONE GLOBALE completa\033[0m\n"; \
        printf "\033[33m  just lint-codacy        🔍 Controlli qualità Codacy\033[0m\n"; \
        printf "\033[33m  just add-docstrings     📝 Aggiunge docstring mancanti\033[0m\n"; \
        printf "\033[33m  just precommit-corporate 🏢 Pre-commit aziendale\033[0m\n"; \
        printf "\033[33m  just quality-corporate  🏢 Quality controlli alternativi\033[0m\n"; \
        printf "\033[33m  just fix-markdown       📝 Corregge problemi Markdown\033[0m\n"; \
    else \
        powershell -Command "Write-Host '🔧 QUALITY & FORMAT:' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just fix-all            ⭐ CORREZIONE GLOBALE completa' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just lint-codacy        🔍 Controlli qualità Codacy' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just add-docstrings     📝 Aggiunge docstring mancanti' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just precommit-corporate 🏢 Pre-commit aziendale' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just quality-corporate  🏢 Quality controlli alternativi' -ForegroundColor Yellow"; \
        powershell -Command "Write-Host '  just fix-markdown       📝 Corregge problemi Markdown' -ForegroundColor Yellow"; \
    fi

print_white:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        printf "\033[97mℹ️  UTILITY:\033[0m\n"; \
        printf "\033[97m  just stats              📊 Statistiche progetto\033[0m\n"; \
        printf "\033[97m  just check-env          🔍 Controllo ambiente\033[0m\n"; \
        printf "\033[97m  just check-env-dev      🔍 Controllo ambiente DEV\033[0m\n"; \
        printf "\033[97m  just check-env-test     🧪 Controllo ambiente TEST\033[0m\n"; \
        printf "\033[97m  just check-env-staging  🎭 Controllo ambiente STAGING\033[0m\n"; \
        printf "\033[97m  just check-env-prod     ⚡ Controllo ambiente PROD\033[0m\n"; \
        printf "\033[97m  just generate-secret-key 🔑 Genera Django SECRET_KEY\033[0m\n"; \
        printf "\033[97m  just generate-secret-keys-all 🔐 Genera tutte le SECRET_KEY\033[0m\n"; \
        printf "\033[97m  just generate-db-passwords 🔐 Genera password DB\033[0m\n"; \
        printf "\033[97m  just create-db-script   🗄️ Crea script SQL\033[0m\n"; \
        printf "\033[97m  just --list             📋 Lista completa comandi\033[0m\n"; \
    else \
        powershell -Command "Write-Host 'ℹ️  UTILITY:' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just stats              📊 Statistiche progetto' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env          🔍 Controllo ambiente' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-dev      🔍 Controllo ambiente DEV' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-test     🧪 Controllo ambiente TEST' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-staging  🎭 Controllo ambiente STAGING' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just check-env-prod     ⚡ Controllo ambiente PROD' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just generate-secret-key 🔑 Genera Django SECRET_KEY' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just generate-secret-keys-all 🔐 Genera tutte le SECRET_KEY' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just generate-db-passwords 🔐 Genera password DB' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just create-db-script   🗄️ Crea script SQL' -ForegroundColor White"; \
        powershell -Command "Write-Host '  just --list             📋 Lista completa comandi' -ForegroundColor White"; \
    fi

print_gray_footer:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        printf "\033[90m# Comandi solo Windows/IIS/PowerShell: vedi commenti nel justfile\033[0m\n"; \
        printf "\033[90m# just iis-test-local, iis-setup, iis-deploy, waitress, open-home, ecc.\033[0m\n"; \
    else \
        powershell -Command "Write-Host '# Comandi solo Windows/IIS/PowerShell: vedi commenti nel justfile' -ForegroundColor Gray"; \
        powershell -Command "Write-Host '# just iis-test-local, iis-setup, iis-deploy, waitress, open-home, ecc.' -ForegroundColor Gray"; \
    fi
# Deploy Django Template - Comandi disponibili con Just
# Per visualizzare tutti i comandi: just --list o just

# Configura shell per Windows
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Variabili globali
python := "uv run"
django_manage := "uv run python src/manage.py"

# Ricetta cross-platform per stampa colorata
color_print color message:
    @if [ "$(uname -s)" != "Windows_NT" ]; then \
        case "$color" in \
            magenta) code='\033[35m' ;; \
            green) code='\033[32m' ;; \
            yellow) code='\033[33m' ;; \
            cyan) code='\033[36m' ;; \
            gray) code='\033[90m' ;; \
            white) code='\033[97m' ;; \
            *) code='\033[0m' ;; \
        esac; \
        echo -e "${code}${message}\033[0m"; \
    else \
        powershell -Command "Write-Host '$message' -ForegroundColor $color"; \
    fi

# 📋 Comando default: mostra l'help
default:
    # Cross-platform color print (bash/macOS/Linux/Windows)
    # Stampa colorata cross-platform
    @just print_help

# === IIS DEPLOYMENT (Windows Server) ===

# 🌐 Setup IIS reverse proxy per Windows Server
setup-iis:
    @Write-Host "🌐 Configurazione IIS reverse proxy..." -ForegroundColor Cyan
    @Write-Host "⚠️  Richiede privilegi di amministratore!" -ForegroundColor Yellow
    @PowerShell -ExecutionPolicy Bypass -File "deployment\setup-iis.ps1"

# 🚀 Deploy completo per IIS
deploy-iis:
    @Write-Host "🚀 Deploy completo con IIS reverse proxy..." -ForegroundColor Magenta
    @Write-Host "1/4 - Installazione dipendenze produzione..." -ForegroundColor Yellow
    @uv sync --frozen
    @Write-Host "2/4 - Migrazioni database..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} migrate --no-input
    @Write-Host "3/4 - Raccolta file statici..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} collectstatic --no-input --clear
    @Write-Host "4/4 - Avvio server Uvicorn per IIS..." -ForegroundColor Yellow
    @Write-Host "🌐 Server disponibile per reverse proxy IIS" -ForegroundColor Green
    @$env:DJANGO_ENV="prod"; cd src; {{python}} -m uvicorn home.asgi:application --host 127.0.0.1 --port 8000 --workers 1 --log-level info

# === NGINX DEPLOYMENT (Linux/macOS) ===

# 🌐 Setup Nginx per Linux/macOS
setup-nginx:
    @Write-Host "🌐 Configurazione Nginx per Linux/macOS..." -ForegroundColor Blue
    @Write-Host "⚠️  Richiede privilegi sudo!" -ForegroundColor Yellow
    @Write-Host "1/4 - Copia configurazione Nginx..." -ForegroundColor Yellow
    sudo cp deployment/nginx.conf /etc/nginx/sites-available/gestione-pareri
    @Write-Host "2/4 - Abilita sito..." -ForegroundColor Yellow
    sudo ln -sf /etc/nginx/sites-available/gestione-pareri /etc/nginx/sites-enabled/
    @Write-Host "3/4 - Test configurazione..." -ForegroundColor Yellow
    sudo nginx -t
    @Write-Host "4/4 - Ricarica Nginx..." -ForegroundColor Yellow
    sudo systemctl reload nginx
    @Write-Host "✅ Nginx configurato con successo!" -ForegroundColor Green
    @Write-Host "🌐 Sito disponibile su: http://localhost" -ForegroundColor Green

# 🚀 Deploy completo con Nginx
deploy-nginx: install-prod
    @Write-Host "🚀 Deploy completo con Nginx..." -ForegroundColor Blue
    @Write-Host "1/5 - Installazione dipendenze..." -ForegroundColor Yellow
    @uv sync --frozen
    @Write-Host "2/5 - Migrazioni database..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} migrate --no-input
    @Write-Host "3/5 - Raccolta file statici..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} collectstatic --no-input --clear
    @Write-Host "4/5 - Riavvio Django service..." -ForegroundColor Yellow
    sudo systemctl restart gestione-pareri || echo "Service gestione-pareri non configurato"
    @Write-Host "5/5 - Reload Nginx..." -ForegroundColor Yellow
    sudo systemctl reload nginx
    @Write-Host "✅ Deploy Nginx completato!" -ForegroundColor Green
    @Write-Host "🌐 Server disponibile tramite Nginx reverse proxy" -ForegroundColor Green

# 📊 Status servizi Nginx
status-nginx:
    @Write-Host "📊 Status servizi Nginx..." -ForegroundColor Blue
    @Write-Host "=== NGINX STATUS ===" -ForegroundColor Cyan
    sudo systemctl status nginx --no-pager
    @Write-Host "" -ForegroundColor White
    @Write-Host "=== DJANGO SERVICE STATUS ===" -ForegroundColor Cyan
    sudo systemctl status gestione-pareri --no-pager || echo "Service gestione-pareri non configurato"

# === DJANGO COMMANDS ===

# 🚀 Server di sviluppo
run-server:
    @Write-Host "🚀 Avvio del server di sviluppo Django..." -ForegroundColor Cyan
    @{{django_manage}} runserver

# 🔧 Server di sviluppo in ambiente DEV
run-dev:
    @Write-Host "🔧 Avvio del server di sviluppo in ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} runserver

# 🧪 Server di sviluppo in ambiente TEST
run-test:
    @Write-Host "🧪 Avvio del server di sviluppo in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} runserver

# 🎭 Server di sviluppo in ambiente STAGING
run-staging:
    @Write-Host "🎭 Avvio del server di sviluppo in ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa sempre PostgreSQL!" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{django_manage}} runserver

# ⚡ Server di sviluppo in ambiente PROD
run-prod:
    @Write-Host "⚡ Avvio del server di sviluppo in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} runserver

# 🧪 Test del progetto
test:
    @Write-Host "🧪 Esecuzione dei test..." -ForegroundColor Cyan
    @Write-Host "📋 Ambiente: LOCAL con PostgreSQL" -ForegroundColor Gray
    @uv run python src/manage.py test accounts --settings=home.settings.test_local

# 🧪 Test in ambiente DEV
test-dev:
    @Write-Host "🧪 Test in ambiente DEV..." -ForegroundColor Cyan
    @Write-Host "📋 Ambiente: DEV con SQLite/PostgreSQL" -ForegroundColor Gray
    @$env:DJANGO_SETTINGS_MODULE="home.settings.dev"; uv run pytest src/accounts/tests.py -v

# 🧪 Test in ambiente TEST
test-test:
    @Write-Host "🧪 Test in ambiente TEST..." -ForegroundColor Cyan
    @Write-Host "📋 Ambiente: TEST con PostgreSQL" -ForegroundColor Gray
    @Write-Host "⚡ PostgreSQL deve essere configurato!" -ForegroundColor Yellow
    @$env:DJANGO_SETTINGS_MODULE="home.settings.test"; uv run pytest src/accounts/tests.py -v

# 🧪 Test in ambiente STAGING
test-staging:
    @Write-Host "🎭 Esecuzione dei test in ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "📋 Ambiente: STAGING con PostgreSQL" -ForegroundColor Gray
    @Write-Host "⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; uv run python src/manage.py test accounts --settings=home.settings.staging --verbosity=2

# 🧪 Test in ambiente PROD
test-prod:
    @Write-Host "🧪 Test in ambiente PROD..." -ForegroundColor Cyan
    @Write-Host "📋 Ambiente: PROD con PostgreSQL" -ForegroundColor Gray
    @Write-Host "🚨 ATTENZIONE: Test in ambiente PRODUZIONE!" -ForegroundColor Red
    @Write-Host "💡 Usa solo per validazione post-deploy" -ForegroundColor Yellow
    @$env:DJANGO_SETTINGS_MODULE="home.settings.prod"; $env:DJANGO_TEST_DB="1"; uv run pytest src/accounts/tests.py -v

# 📦 Migrazioni database
migrate:
    @Write-Host "📦 Applicazione delle migrazioni..." -ForegroundColor Cyan
    @{{django_manage}} migrate

# 📦 Migrazioni in ambiente DEV
migrate-dev:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} migrate

# 📦 Migrazioni in ambiente TEST
migrate-test:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} migrate

# 📦 Migrazioni in ambiente STAGING
migrate-staging:
    @Write-Host "🎭 Applicazione delle migrazioni in ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{django_manage}} migrate

# 📦 Migrazioni in ambiente PROD
migrate-prod:
    @Write-Host "📦 Applicazione delle migrazioni in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} migrate

# 📝 Creazione migrazioni
makemigrations:
    @Write-Host "📝 Creazione delle migrazioni..." -ForegroundColor Cyan
    @{{django_manage}} makemigrations

# 🐚 Shell Django
shell:
    @Write-Host "🐚 Avvio della shell Django..." -ForegroundColor Cyan
    @{{django_manage}} shell

# 🐚 Shell Django DEV
shell-dev:
    @Write-Host "🐚 Avvio della shell Django in ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} shell

# 🐚 Shell Django TEST
shell-test:
    @Write-Host "🐚 Avvio della shell Django in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} shell

# 🐚 Shell Django STAGING
shell-staging:
    @Write-Host "🎭 Avvio della shell Django in ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL!" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{django_manage}} shell

# 🐚 Shell Django PROD
shell-prod:
    @Write-Host "🐚 Avvio della shell Django in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} shell

# 👤 Crea superuser
createsuperuser:
    @Write-Host "👤 Creazione di un superuser..." -ForegroundColor Cyan
    @Write-Host "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it" -ForegroundColor Yellow
    @{{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente DEV
createsuperuser-dev:
    @Write-Host "👤 Creazione di un superuser in ambiente DEV..." -ForegroundColor Cyan
    @Write-Host "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it" -ForegroundColor Yellow
    @$env:DJANGO_ENV="dev"; {{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente TEST
createsuperuser-test:
    @Write-Host "👤 Creazione di un superuser in ambiente TEST..." -ForegroundColor Cyan
    @Write-Host "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it" -ForegroundColor Yellow
    @$env:DJANGO_ENV="test"; {{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente STAGING
createsuperuser-staging:
    @Write-Host "🎭 Creazione di un superuser in ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL!" -ForegroundColor Yellow
    @Write-Host "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente PROD
createsuperuser-prod:
    @Write-Host "👤 Creazione di un superuser in ambiente PROD..." -ForegroundColor Cyan
    @Write-Host "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it" -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} createsuperuser

# === GROUPS & PERMISSIONS ===

# 🔐 Inizializza gruppi e permessi di base
init-groups:
    @Write-Host "🔐 Inizializzazione gruppi e permessi di base..." -ForegroundColor Cyan
    @{{django_manage}} init_groups_permissions
    @Write-Host "✅ Gruppi e permessi inizializzati" -ForegroundColor Green

# 🔐 Inizializza gruppi in ambiente TEST
init-groups-test:
    @Write-Host "🔐 Inizializzazione gruppi in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} init_groups_permissions
    @Write-Host "✅ Gruppi TEST inizializzati" -ForegroundColor Green

# 🔐 Inizializza gruppi in ambiente STAGING
init-groups-staging:
    @Write-Host "🔐 Inizializzazione gruppi in ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL!" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{django_manage}} init_groups_permissions
    @Write-Host "✅ Gruppi STAGING inizializzati" -ForegroundColor Green

# 🔐 Inizializza gruppi in ambiente PROD
init-groups-prod:
    @Write-Host "🔐 Inizializzazione gruppi in ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} init_groups_permissions
    @Write-Host "✅ Gruppi PROD inizializzati" -ForegroundColor Green

# === DATABASE DUMP & LOAD ===

# 💾 Crea dump dei dati iniziali (superuser + gruppi + permessi)
dump-initial-data:
    @Write-Host "💾 Creazione dump dei dati iniziali..." -ForegroundColor Cyan
    @Write-Host "ℹ️  Salva superuser, gruppi e permessi da ambiente DEV" -ForegroundColor Yellow
    @$env:DJANGO_ENV="dev"; {{django_manage}} dumpdata accounts auth.group auth.permission --format=json --indent=2 --output=fixtures/initial_data.json
    @Write-Host "✅ Dump salvato in fixtures/initial_data.json" -ForegroundColor Green

# 📥 Carica dati iniziali in ambiente TEST
load-initial-data-test:
    @Write-Host "📥 Caricamento dati iniziali in ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} loaddata fixtures/initial_data.json
    @Write-Host "✅ Dati caricati in ambiente TEST" -ForegroundColor Green

# 📥 Carica dati iniziali in ambiente STAGING
load-initial-data-staging:
    @Write-Host "📥 Caricamento dati iniziali in ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL!" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{django_manage}} loaddata fixtures/initial_data.json
    @Write-Host "✅ Dati caricati in ambiente STAGING" -ForegroundColor Green

# 📥 Carica dati iniziali in ambiente PROD
load-initial-data-prod:
    @Write-Host "📥 Caricamento dati iniziali in ambiente PROD..." -ForegroundColor Cyan
    @Write-Host "⚠️  ATTENZIONE: Stai caricando dati in PRODUZIONE!" -ForegroundColor Red
    @$env:DJANGO_ENV="prod"; {{django_manage}} loaddata fixtures/initial_data.json
    @Write-Host "✅ Dati caricati in ambiente PROD" -ForegroundColor Green

# 🔄 Setup completo tutti gli ambienti (migrate + load data)
setup-all-environments:
    @Write-Host "🔄 Setup completo di tutti gli ambienti..." -ForegroundColor Cyan
    @Write-Host "1/4 - Migrazioni ambiente TEST..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="test"; {{django_manage}} migrate
    @Write-Host "2/4 - Migrazioni ambiente STAGING..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{django_manage}} migrate
    @Write-Host "3/4 - Migrazioni ambiente PROD..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; {{django_manage}} migrate
    @Write-Host "4/4 - Caricamento dati iniziali in tutti gli ambienti..." -ForegroundColor Yellow
    just load-initial-data-test
    just load-initial-data-staging
    just load-initial-data-prod
    @Write-Host "✅ Setup completo di tutti gli ambienti completato!" -ForegroundColor Green

# === QUALITY COMMANDS ===

# 📝 Aggiunge docstring mancanti
add-docstrings:
    @Write-Host "📝 Aggiunta docstring ai file Python del progetto..." -ForegroundColor Cyan
    @{{python}} tools/add_docstring_batch.py .

# ⭐ CORREZIONE GLOBALE: Fix all code quality issues
fix-all:
    @Write-Host "⭐ Correzione completa di tutti i problemi di qualità del codice..." -ForegroundColor Cyan
    @Write-Host "1/10 - Rimozione spazi finali..." -ForegroundColor Yellow
    @-pre-commit run trailing-whitespace --all-files
    @Write-Host "2/10 - Correzione fine file..." -ForegroundColor Yellow
    @-pre-commit run end-of-file-fixer --all-files
    @Write-Host "3/10 - Aggiunta docstring..." -ForegroundColor Yellow
    @-{{python}} tools/add_docstring_batch.py .
    @Write-Host "4/10 - Ordinamento import (isort style)..." -ForegroundColor Yellow
    @-{{python}} ruff check --select I --fix .
    @Write-Host "5/10 - Formattazione con Ruff..." -ForegroundColor Yellow
    @-{{python}} ruff format .
    @Write-Host "6/10 - Correzione automatica con Ruff..." -ForegroundColor Yellow
    @-{{python}} ruff check . --fix --unsafe-fixes
    @Write-Host "7/10 - Correzioni aggressive con autopep8..." -ForegroundColor Yellow
    @-{{python}} autopep8 --in-place --aggressive --aggressive --recursive .
    @Write-Host "8/10 - Formattazione finale con Ruff..." -ForegroundColor Yellow
    @-{{python}} ruff format .
    @Write-Host "9/10 - Formattazione Markdown..." -ForegroundColor Yellow
    @just format-markdown
    @Write-Host "10/10 - Correzione problemi Markdown..." -ForegroundColor Yellow
    @just fix-markdown
    @Write-Host "✅ Tutti i problemi di qualità del codice sono stati corretti!" -ForegroundColor Green

# 🔍 Test pre-commit hooks senza modifiche
test-precommit:
    @Write-Host "🔍 Test di tutti i controlli pre-commit..." -ForegroundColor Cyan
    @pre-commit run --all-files
    @Write-Host "✅ Test pre-commit completato!" -ForegroundColor Green

# 🔧 Correzione automatica script bash
fix-codacy:
    @Write-Host "🔧 Correzione automatica script bash..." -ForegroundColor Cyan
    @Get-ChildItem -Path "scripts/deployment" -Filter "*.sh" | ForEach-Object { shfmt -w $_.FullName }
    @Write-Host "✅ Correzioni applicate!" -ForegroundColor Green

# 📝 Formattazione file Markdown
format-markdown:
    @Write-Host "📝 Formattazione file Markdown..." -ForegroundColor Cyan
    @Get-ChildItem -Path . -Include "*.md" -Recurse | ForEach-Object { Write-Host "Formatting" $_.FullName; $content = Get-Content $_.FullName -Raw; if ($content) { $formatted = $content -replace "(?m)^[ \t]+$", "" -replace "(?m)\r?\n{3,}", "`n`n" -replace "(?m)[ \t]+$", ""; Set-Content $_.FullName -Value $formatted -NoNewline } }
    @Write-Host "✅ File Markdown formattati con successo!" -ForegroundColor Green

# 📝 Correzione problemi Markdown
fix-markdown:
    @Write-Host "📝 Correzione problemi Markdown..." -ForegroundColor Cyan
    @Write-Host "1/3 - Correzioni automatiche..." -ForegroundColor Yellow
    @{{python}} tools/fix_markdown.py
    @Write-Host "2/3 - Prettier formatting..." -ForegroundColor Yellow
    @-pre-commit run prettier --all-files
    @Write-Host "3/3 - Markdownlint validation..." -ForegroundColor Yellow
    @-pre-commit run markdownlint-cli2 --all-files
    @Write-Host "✅ Problemi Markdown corretti!" -ForegroundColor Green

# 🔍 Controlli qualità stile Codacy (semplificato)
lint-codacy:
    @Write-Host "🔍 Controlli qualità stile Codacy..." -ForegroundColor Cyan
    @Write-Host "1/3 - Ruff check..." -ForegroundColor Yellow
    @-{{python}} ruff check --output-format=github .
    @Write-Host "2/3 - Flake8..." -ForegroundColor Yellow
    @-{{python}} flake8 --format=default .
    @Write-Host "3/3 - Pylint..." -ForegroundColor Yellow
    @-{{python}} pylint src/home/ --output-format=colorized
    @Write-Host "✅ Controlli completati!" -ForegroundColor Green

# 📊 Statistiche progetto
stats:
    @Write-Host "📊 Generazione statistiche progetto..." -ForegroundColor Cyan
    @{{python}} tools/project_stats.py
    @Write-Host "📊 Dashboard disponibile in tools/quality_dashboard.md" -ForegroundColor Green

# 🔑 Genera Django SECRET_KEY
generate-secret-key:
    @Write-Host "🔑 Generazione Django SECRET_KEY..." -ForegroundColor Cyan
    @Write-Host "Genero SECRET_KEY generica:" -ForegroundColor Yellow
    @{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

# 🔑 Genera SECRET_KEY per tutti i 4 ambienti
generate-secret-keys-all:
    @Write-Host "🔐 Generazione SECRET_KEY per tutti gli ambienti..." -ForegroundColor Cyan
    @Write-Host ""
    @Write-Host "🔧 DEV Environment:" -ForegroundColor Green
    @$dev_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_DEV=$dev_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "🧪 TEST Environment:" -ForegroundColor Blue
    @$test_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_TEST=$test_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "🎭 STAGING Environment:" -ForegroundColor Magenta
    @$staging_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_STAGING=$staging_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "⚡ PROD Environment:" -ForegroundColor Red
    @$prod_key = &{{python}} python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
    @Write-Host "DJANGO_SECRET_KEY_PROD=$prod_key" -ForegroundColor White
    @Write-Host ""
    @Write-Host "💡 CONFIGURAZIONE .env:" -ForegroundColor Cyan
    @Write-Host "=======================" -ForegroundColor Cyan
    @Write-Host "DJANGO_SECRET_KEY_DEV=$dev_key"
    @Write-Host "DJANGO_SECRET_KEY_TEST=$test_key"
    @Write-Host "DJANGO_SECRET_KEY_STAGING=$staging_key"
    @Write-Host "DJANGO_SECRET_KEY_PROD=$prod_key"
    @Write-Host ""
    @Write-Host "⚠️  IMPORTANTE: Ogni ambiente deve avere la sua SECRET_KEY!" -ForegroundColor Yellow
    @Write-Host "📖 Vedi docs/environments-guide.md per configurazione completa" -ForegroundColor Gray

# === DEPLOYMENT COMMANDS ===

# 📦 Installazione dipendenze produzione
install-prod:
    @Write-Host "📦 Installazione dipendenze produzione..." -ForegroundColor Cyan
    @uv sync --group prod

# 🔧 Deploy development
deploy-dev:
    @Write-Host "🔧 Avvio server di sviluppo..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="dev"; {{django_manage}} runserver

# 🧪 Deploy staging
deploy-staging:
    @Write-Host "🧪 Deploy staging (Windows - Uvicorn)..." -ForegroundColor Yellow
    @$env:DJANGO_ENV="test"; powershell -ExecutionPolicy Bypass -File scripts/deployment/start-uvicorn.ps1 -DjangoEnv test

# 🚀 Deploy production
deploy-prod: install-prod
    @Write-Host "🚀 Deploy produzione (Windows - Uvicorn ASGI)..." -ForegroundColor Green
    @just run-uvicorn

# 🎯 Smart deploy automatico
deploy: install-prod
    @Write-Host "🎯 Smart deployment - Windows rilevato, usando Uvicorn ASGI..." -ForegroundColor Cyan
    @just run-uvicorn

# 🪟 Waitress server (Windows/Cross-platform)
waitress: install-prod
    @Write-Host "🪟 Avvio Django con Waitress (Windows)..." -ForegroundColor Green
    @Write-Host "🚀 Starting Django with Waitress" -ForegroundColor Green
    @Write-Host "Environment: prod" -ForegroundColor Cyan
    @Write-Host "Host: 0.0.0.0:8000" -ForegroundColor Cyan
    @Write-Host "Threads: 4" -ForegroundColor Cyan
    @Write-Host "📊 Running migrations..." -ForegroundColor Yellow
    @{{django_manage}} migrate --no-input
    @Write-Host "📁 Collecting static files..." -ForegroundColor Yellow
    @{{django_manage}} collectstatic --no-input --clear
    @Write-Host "🌟 Starting Waitress server..." -ForegroundColor Green
    @$env:DJANGO_ENV="prod"; cd src; {{python}} -m waitress --host=0.0.0.0 --port=8000 --threads=4 --connection-limit=1000 --channel-timeout=120 home.wsgi:application

# ⚡ Uvicorn ASGI server - RACCOMANDATO
run-uvicorn: install-prod
    @Write-Host "⚡ Avvio Django con Uvicorn ASGI (Windows)..." -ForegroundColor Green
    @Write-Host "🚀 Starting Uvicorn ASGI Server" -ForegroundColor Blue
    @Write-Host "Environment: prod" -ForegroundColor Yellow
    @Write-Host "Host: 0.0.0.0:8000" -ForegroundColor Yellow
    @Write-Host "📊 Running migrations..." -ForegroundColor Yellow
    @{{django_manage}} migrate --no-input
    @Write-Host "📁 Collecting static files..." -ForegroundColor Yellow
    @{{django_manage}} collectstatic --no-input --clear
    @Write-Host "⚡ Modalità produzione: single worker (Windows optimized)" -ForegroundColor Yellow
    @$env:DJANGO_ENV="prod"; cd src; {{python}} -m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --log-level info --access-log --timeout-keep-alive 2

# 🧪 Test Uvicorn locale (debug)
test-uvicorn-local:
    @Write-Host "🧪 Test locale Uvicorn ASGI (debug, singolo worker)..." -ForegroundColor Cyan
    @bash scripts/deployment/test-uvicorn-local.sh

# 📦 Raccolta file statici
collectstatic:
    @Write-Host "📦 Raccolta file statici..." -ForegroundColor Cyan
    @{{django_manage}} collectstatic --noinput

# 📦 Raccolta file statici DEV
collectstatic-dev:
    @Write-Host "📦 Raccolta file statici (DEV)..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{django_manage}} collectstatic --noinput

# 📦 Raccolta file statici TEST
collectstatic-test:
    @Write-Host "📦 Raccolta file statici (TEST)..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{django_manage}} collectstatic --noinput

# 📦 Raccolta file statici PROD
collectstatic-prod:
    @Write-Host "📦 Raccolta file statici (PROD)..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{django_manage}} collectstatic --noinput

# 🌐 Apre la home page nel browser
open-home:
    @Write-Host "🌐 Apertura pagina home nel browser..." -ForegroundColor Cyan
    @Start-Process "http://localhost:8000"

# === SERVER MANAGEMENT ===

# 🛑 Ferma tutti i server Django
stop-servers:
    @Write-Host "🛑 Arresto di tutti i server Django..." -ForegroundColor Yellow
    @Write-Host "ℹ️  Nota: Eseguire da un terminale DIVERSO da quello che esegue il server" -ForegroundColor Cyan
    @Get-Process | Where-Object {$_.ProcessName -match "python|gunicorn|waitress|uvicorn"} | Where-Object {$_.CommandLine -match "django|manage.py|wsgi|asgi"} | Stop-Process -Force

# 🔪 Termina processi sulla porta 8000
kill-port:
    @Write-Host "🔪 Terminazione processi sulla porta 8000..." -ForegroundColor Yellow
    @Write-Host "ℹ️  Nota: Eseguire da un terminale DIVERSO da quello che esegue il server" -ForegroundColor Cyan
    @$processes = Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess; if ($processes) { $processes | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }; Write-Host "Processi sulla porta 8000 terminati" } else { Write-Host "Nessun processo trovato sulla porta 8000" }

# === ENVIRONMENT CHECKS ===

# 🔍 Controllo ambiente corrente
check-env:
    @Write-Host "🔍 Controllo dell'ambiente corrente..." -ForegroundColor Cyan
    @{{python}} src/test_logging.py

# 🔍 Controllo ambiente DEV
check-env-dev:
    @Write-Host "🔍 Controllo dell'ambiente DEV..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="dev"; {{python}} src/test_logging.py

# 🔍 Controllo ambiente TEST
check-env-test:
    @Write-Host "🔍 Controllo dell'ambiente TEST..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="test"; {{python}} src/test_logging.py

# 🔍 Controllo ambiente STAGING
check-env-staging:
    @Write-Host "🎭 Controllo dell'ambiente STAGING..." -ForegroundColor Cyan
    @Write-Host "⚠️  STAGING usa PostgreSQL e logging su file!" -ForegroundColor Yellow
    @$env:DJANGO_ENV="staging"; {{python}} src/test_logging.py

# 🔍 Controllo ambiente PROD
check-env-prod:
    @Write-Host "🔍 Controllo dell'ambiente PROD..." -ForegroundColor Cyan
    @$env:DJANGO_ENV="prod"; {{python}} src/test_logging.py

# === CORPORATE COMMANDS ===

# 🏢 Pre-commit con configurazione corporate
precommit-corporate:
    @Write-Host "🏢 Esecuzione pre-commit con configurazione corporate..." -ForegroundColor Magenta
    @if (Test-Path ".pre-commit-config-corporate.yaml") { \
        $result = pre-commit run --all-files --config .pre-commit-config-corporate.yaml; \
        if ($LASTEXITCODE -eq 0) { \
            Write-Host "✅ Tutti i controlli pre-commit superati!" -ForegroundColor Green \
        } elseif ($LASTEXITCODE -eq 1) { \
            Write-Host "🔧 Pre-commit ha corretto automaticamente alcuni problemi!" -ForegroundColor Yellow; \
            Write-Host "💡 Rivedi le modifiche e committa se necessario." -ForegroundColor Cyan \
        } else { \
            Write-Host "❌ Errori durante l'esecuzione pre-commit (exit code: $LASTEXITCODE)" -ForegroundColor Red; \
            exit $LASTEXITCODE \
        } \
    } else { \
        Write-Host "⚠️  File .pre-commit-config-corporate.yaml non trovato!" -ForegroundColor Red; \
        Write-Host "💡 Usando configurazione standard..." -ForegroundColor Yellow; \
        $result = pre-commit run --all-files; \
        if ($LASTEXITCODE -eq 0) { \
            Write-Host "✅ Tutti i controlli pre-commit superati!" -ForegroundColor Green \
        } elseif ($LASTEXITCODE -eq 1) { \
            Write-Host "🔧 Pre-commit ha corretto automaticamente alcuni problemi!" -ForegroundColor Yellow; \
            Write-Host "💡 Rivedi le modifiche e committa se necessario." -ForegroundColor Cyan \
        } else { \
            Write-Host "❌ Errori durante l'esecuzione pre-commit (exit code: $LASTEXITCODE)" -ForegroundColor Red; \
            exit $LASTEXITCODE \
        } \
    }

# 🏢 Quality checks corporate (alternativi)
quality-corporate:
    @Write-Host "🏢 Controlli qualità corporate..." -ForegroundColor Magenta
    @Write-Host "🔍 1. Controlli pre-commit corporate..." -ForegroundColor Cyan
    just precommit-corporate
    @Write-Host "📊 2. Controlli Codacy..." -ForegroundColor Cyan
    just lint-codacy
    @Write-Host "📝 3. Aggiunta docstring..." -ForegroundColor Cyan
    just add-docstrings
    @Write-Host "🎯 4. Fix markdown..." -ForegroundColor Cyan
    just fix-markdown
    @Write-Host "✅ Controlli quality corporate completati!" -ForegroundColor Green

# === DATABASE UTILITIES ===

# 🔐 Genera password PostgreSQL sicure per tutti gli ambienti
generate-db-passwords:
    @{{python}} tools/generate_db_passwords.py

# 🗄️ Crea script SQL con password reali per setup PostgreSQL
create-db-script:
    @Write-Host "🗄️ Creazione script SQL con password reali..." -ForegroundColor Cyan
    @if (Test-Path "update_postgresql_staging.template.sql") { \
        Copy-Item "update_postgresql_staging.template.sql" "update_postgresql_staging.sql" -Force; \
        Write-Host "✅ Script copiato: update_postgresql_staging.sql" -ForegroundColor Green; \
        Write-Host "🔧 Ora sostituisci manualmente i placeholder YOUR_*_PASSWORD" -ForegroundColor Yellow; \
        Write-Host "🔐 Usa le password generate da: just generate-db-passwords" -ForegroundColor Yellow; \
        Write-Host "⚠️  ATTENZIONE: File contiene password - elimina dopo l'uso!" -ForegroundColor Red; \
    } else { \
        Write-Host "❌ Template non trovato: update_postgresql_staging.template.sql" -ForegroundColor Red; \
    }

# === ENHANCED TESTING COMMANDS ===

# ⚡ Test rapidi quotidiani per sviluppatori
test-quick:
    @Write-Host "⚡ Test rapidi quotidiani..." -ForegroundColor Yellow
    @Write-Host "🎯 Focus: CustomUser, sicurezza base, autenticazione" -ForegroundColor Gray
    @Write-Host "🗄️ Database: SQLite (veloce)" -ForegroundColor Gray
    @uv run python src/manage.py test accounts.tests.CustomUserModelTest accounts.tests.CustomUserAuthenticationTest accounts.tests.SecurityTest --settings=home.settings.test_local --keepdb --verbosity=1

# 🔒 Test sicurezza critica
test-security:
    @Write-Host "🔒 Test sicurezza critica..." -ForegroundColor Red
    @Write-Host "🎯 Focus: Validazione domini, password, CSRF" -ForegroundColor Gray
    @Write-Host "🗄️ Database: SQLite (veloce)" -ForegroundColor Gray
    @uv run python src/manage.py test accounts.tests.SecurityTest accounts.tests.CustomUserFormsTest --settings=home.settings.test_local --keepdb --verbosity=2

# 🚀 Test completi pre-deploy
test-pre-deploy:
    @Write-Host "🚀 Test completi pre-deploy..." -ForegroundColor Green
    @Write-Host "📋 Tutti i 42 test con report dettagliato" -ForegroundColor Gray
    @Write-Host "⚡ Performance + Sicurezza + Funzionalità" -ForegroundColor Gray
    @Write-Host "🗄️ Database: PostgreSQL (realistico)" -ForegroundColor Gray
    @uv run python src/manage.py test accounts --settings=home.settings.test --verbosity=2

# 📊 Test con coverage
test-coverage:
    @Write-Host "📊 Test con coverage report..." -ForegroundColor Cyan
    @Write-Host "📋 Generazione report di copertura" -ForegroundColor Gray
    @cd src; uv run coverage run --source='.' manage.py test --settings=home.settings.test_local
    @cd src; uv run coverage report
    @cd src; uv run coverage html
    @Write-Host "🌐 Report HTML: src/htmlcov/index.html" -ForegroundColor Green

# 🏥 Test health check
test-health:
    @Write-Host "🏥 Health check del sistema..." -ForegroundColor Cyan
    @Write-Host "1/4 - Verifica ambienti..." -ForegroundColor Yellow
    just check-env
    @Write-Host "2/4 - Test rapidi..." -ForegroundColor Yellow
    just test-quick
    @Write-Host "3/4 - Verifica migrazioni..." -ForegroundColor Yellow
    @cd src; {{django_manage}} showmigrations --settings=home.settings.test_local
    @Write-Host "4/4 - Test connessione database..." -ForegroundColor Yellow
    @cd src; {{django_manage}} dbshell --settings=home.settings.test_local -c "SELECT 1;"
    @Write-Host "✅ Health check completato!" -ForegroundColor Green

# ============================================================================
# 🌐 IIS DEPLOYMENT COMMANDS
# ============================================================================

# 🧪 Test IIS locale con subpath
iis-test-local:
    @Write-Host "🧪 Avvio test IIS locale..." -ForegroundColor Cyan
    @Write-Host "📍 URL: http://localhost:8000/pratiche-pareri/" -ForegroundColor Yellow
    @Write-Host "📊 Admin: http://localhost:8000/pratiche-pareri/admin/" -ForegroundColor Yellow
    PowerShell -ExecutionPolicy Bypass -File scripts/deployment/test-iis-local.ps1

# ⚙️ Setup iniziale per IIS
iis-setup:
    @Write-Host "⚙️ Setup iniziale IIS..." -ForegroundColor Cyan
    @if (!(Test-Path .env.prod)) { if (Test-Path config/environments/.env.prod) { Copy-Item config/environments/.env.prod .env.prod; Write-Host "✅ .env.prod copiato da config/environments/" -ForegroundColor Green } elseif (Test-Path config/environments/.env.prod.template) { Copy-Item config/environments/.env.prod.template .env.prod; Write-Host "✅ .env.prod creato da template - MODIFICA I VALORI!" -ForegroundColor Yellow } } else { Write-Host "📄 File .env.prod già presente" -ForegroundColor Green }
    @if (!(Test-Path web.config)) { Copy-Item web.config.template web.config; Write-Host "✅ File web.config creato da template - MODIFICA I VALORI!" -ForegroundColor Yellow } else { Write-Host "� File web.config già presente" -ForegroundColor Green }
    @Write-Host "�📋 Prossimi passi:" -ForegroundColor Yellow
    @Write-Host "1. Modifica .env.prod con i tuoi valori" -ForegroundColor White
    @Write-Host "2. Modifica web.config con percorsi e credenziali reali" -ForegroundColor White
    @Write-Host "3. Configura PostgreSQL per produzione" -ForegroundColor White
    @Write-Host "4. Esegui: just iis-test-local" -ForegroundColor White
    @Write-Host "5. Quando tutto funziona: just iis-deploy" -ForegroundColor White

# 🔐 Setup credenziali per tutti gli ambienti
setup-credentials:
    @Write-Host "🔐 Setup credenziali per tutti gli ambienti..." -ForegroundColor Cyan
    @if (!(Test-Path .env.dev)) { Copy-Item config/environments/.env.dev.template .env.dev; Write-Host "✅ .env.dev creato" -ForegroundColor Green } else { Write-Host "📄 .env.dev già presente" -ForegroundColor Yellow }
    @if (!(Test-Path .env.test)) { Copy-Item config/environments/.env.test.template .env.test; Write-Host "✅ .env.test creato" -ForegroundColor Green } else { Write-Host "📄 .env.test già presente" -ForegroundColor Yellow }
    @if (!(Test-Path .env.staging)) { Copy-Item config/environments/.env.staging.template .env.staging; Write-Host "✅ .env.staging creato" -ForegroundColor Green } else { Write-Host "📄 .env.staging già presente" -ForegroundColor Yellow }
    @if (!(Test-Path .env.prod)) { Copy-Item config/environments/.env.prod.template .env.prod; Write-Host "✅ .env.prod creato" -ForegroundColor Green } else { Write-Host "📄 .env.prod già presente" -ForegroundColor Yellow }
    @if (!(Test-Path db_credentials.md)) { Copy-Item config/database/db_credentials.template.md db_credentials.md; Write-Host "✅ db_credentials.md creato" -ForegroundColor Green } else { Write-Host "📄 db_credentials.md già presente" -ForegroundColor Yellow }
    @Write-Host "⚠️  IMPORTANTE: Modifica TUTTI i file .env con le password reali!" -ForegroundColor Red
    @Write-Host "📋 File creati (NON tracciati da git):" -ForegroundColor Yellow
    @Write-Host "  - .env.dev (password DEV)" -ForegroundColor White
    @Write-Host "  - .env.test (password TEST)" -ForegroundColor White
    @Write-Host "  - .env.staging (password STAGING)" -ForegroundColor White
    @Write-Host "  - .env.prod (password PROD)" -ForegroundColor White
    @Write-Host "  - db_credentials.md (reference file)" -ForegroundColor White

# 🚀 Deploy completo su IIS
iis-deploy:
    @Write-Host "🚀 Deploy completo IIS..." -ForegroundColor Cyan
    @Write-Host "⚠️  ATTENZIONE: Questo comando richiede privilegi amministratore!" -ForegroundColor Red
    @Write-Host "Continuare? (Premi Enter per procedere, Ctrl+C per annullare)" -ForegroundColor Yellow
    @cmd /c "pause > nul"
    PowerShell -ExecutionPolicy Bypass -File scripts/deployment/deploy-iis.ps1 -ServerIP "192.168.1.100"

# 🔧 Deploy IIS con IP personalizzato
iis-deploy-custom ip:
    @Write-Host "🚀 Deploy IIS su {{ip}}..." -ForegroundColor Cyan
    PowerShell -ExecutionPolicy Bypass -File scripts/deployment/deploy-iis.ps1 -ServerIP "{{ip}}"

# 🏥 Health check IIS
iis-health:
    @Write-Host "🏥 Health check IIS..." -ForegroundColor Cyan
    @$ip = if ($env:IIS_SERVER_IP) { $env:IIS_SERVER_IP } else { "localhost" }
    @try { $response = Invoke-WebRequest -Uri "http://$ip/pratiche-pareri/admin/" -TimeoutSec 5 -UseBasicParsing; Write-Host "✅ IIS raggiungibile: $($response.StatusCode)" -ForegroundColor Green } catch { Write-Host "❌ IIS non raggiungibile: $($_.Exception.Message)" -ForegroundColor Red }

# 🏭 Deploy produzione completo (installazione da zero)
production-deploy:
    @Write-Host "🏭 Deploy produzione completo..." -ForegroundColor Cyan
    @Write-Host "⚠️  ATTENZIONE: Questo comando installa l'applicazione da zero!" -ForegroundColor Red
    @Write-Host "Continuare? (Premi Enter per procedere, Ctrl+C per annullare)" -ForegroundColor Yellow
    @cmd /c "pause > nul"
    PowerShell -ExecutionPolicy Bypass -File scripts/deployment/production-deploy.ps1

# 🔄 Update produzione esistente
production-update:
    @Write-Host "🔄 Update produzione esistente..." -ForegroundColor Cyan
    PowerShell -ExecutionPolicy Bypass -File scripts/deployment/production-deploy.ps1 -UpdateOnly

# 🏭 Deploy produzione con IP personalizzato
production-deploy-custom ip:
    @Write-Host "🏭 Deploy produzione su {{ip}}..." -ForegroundColor Cyan
    PowerShell -ExecutionPolicy Bypass -File scripts/deployment/production-deploy.ps1 -ServerIP "{{ip}}" \

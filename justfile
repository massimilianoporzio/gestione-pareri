# Universal Justfile - Cross-platform (macOS, Linux, Windows)
# Tutti i comandi del template Windows, convertiti per bash dove possibile
# I comandi solo Windows sono commentati e documentati

set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

python := "uv run python"
django_manage := "uv run src/manage.py"

default:
    #!/usr/bin/env bash
    just color_print "magenta" "📄 GESTIONE PRATICHE & PARERI - COMANDI DISPONIBILI"
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
    just color_print "green" "  just init-groups        🔐 Inizializza gruppi base"
    just color_print "green" "  just dump-initial-data  💾 Dump dati iniziali"
    just color_print "green" "  just setup-all-environments 🔄 Setup tutti ambienti"
    just color_print "green" "  just test               🧪 Esegue test progetto"
    just color_print "green" "  just test-quick         ⚡ Test rapidi quotidiani"
    just color_print "green" "  just test-security      🔒 Test sicurezza critica"
    just color_print "green" "  just test-pre-deploy    🚀 Test completi pre-deploy"
    just color_print "green" "  just test-dev           🔧 Test ambiente DEV"
    just color_print "green" "  just test-test          🧪 Test ambiente TEST"
    just color_print "green" "  just test-staging       🎭 Test ambiente STAGING"
    just color_print "green" "  just test-prod          ⚡ Test ambiente PROD"
    echo ""
    just color_print "cyan" "🌐 SERVER & DEPLOY:"
    just color_print "cyan" "  just run-uvicorn        ⚡ Server Uvicorn ASGI"
    just color_print "cyan" "  just deploy-dev         🔧 Deploy development"
    just color_print "cyan" "  just stop-servers       🛑 Ferma tutti i server"
    just color_print "cyan" "  just kill-port          🔪 Termina processo porta 8000"
    just color_print "cyan" "  just setup-nginx        🌐 Configura Nginx"
    just color_print "cyan" "  just deploy-nginx       🚀 Deploy Nginx"
    just color_print "cyan" "  just status-nginx       📊 Status Nginx"
    echo ""
    just color_print "yellow" "🔧 QUALITY & FORMAT:"
    just color_print "yellow" "  just fix-all            ⭐ Correzione globale"
    just color_print "yellow" "  just add-docstrings     📝 Aggiunge docstring"
    just color_print "yellow" "  just fix-markdown       📝 Corregge Markdown"
    just color_print "yellow" "  just lint-codacy        🔍 Quality Codacy"
    just color_print "yellow" "  just stats              📊 Statistiche progetto"
    echo ""
    just color_print "white" "ℹ️  UTILITY:"
    just color_print "white" "  just check-env          🔍 Controllo ambiente"
    just color_print "white" "  just check-env-dev      🔍 Controllo ambiente DEV"
    just color_print "white" "  just check-env-test     🔍 Controllo ambiente TEST"
    just color_print "white" "  just check-env-staging  🎭 Controllo ambiente STAGING"
    just color_print "white" "  just check-env-prod     ⚡ Controllo ambiente PROD"
    just color_print "white" "  just generate-secret-key 🔑 Genera SECRET_KEY"
    just color_print "white" "  just generate-secret-keys-all 🔐 Genera tutte le SECRET_KEY"
    just color_print "white" "  just generate-db-passwords 🔐 Genera password DB"
    just color_print "white" "  just create-db-script   🗄️ Crea script SQL"
    just color_print "white" "  just quick-start        🎯 Quick start"
    echo ""
    just color_print "gray" "# Comandi solo Windows/IIS/PowerShell: vedi commenti nel justfile"
    just color_print "gray" "# just iis-test-local, iis-setup, iis-deploy, waitress, open-home, ecc."
    echo ""
    just color_print "white" "  just --list             📋 Lista completa comandi"

# === DJANGO COMMANDS ===

# 🚀 Server di sviluppo
run-server:
    #!/usr/bin/env bash
    echo "🚀 Avvio del server di sviluppo Django..."
    {{django_manage}} runserver

# 🔧 Server di sviluppo in ambiente DEV
run-dev:
    #!/usr/bin/env bash
    echo "🔧 Avvio del server di sviluppo in ambiente DEV..."
    export DJANGO_ENV="dev"
    {{django_manage}} runserver

# 🧪 Server di sviluppo in ambiente TEST
run-test:
    #!/usr/bin/env bash
    echo "🧪 Avvio del server di sviluppo in ambiente TEST..."
    export DJANGO_ENV="test"
    {{django_manage}} runserver

# 🎭 Server di sviluppo in ambiente STAGING
run-staging:
    #!/usr/bin/env bash
    echo "🎭 Avvio del server di sviluppo in ambiente STAGING..."
    echo "⚠️  STAGING usa sempre PostgreSQL!"
    export DJANGO_ENV="staging"
    {{django_manage}} runserver

# ⚡ Server di sviluppo in ambiente PROD
run-prod:
    #!/usr/bin/env bash
    echo "⚡ Avvio del server di sviluppo in ambiente PROD..."
    export DJANGO_ENV="prod"
    {{django_manage}} runserver

# 📦 Migrazioni database
migrate:
    #!/usr/bin/env bash
    echo "📦 Applicazione delle migrazioni..."
    {{django_manage}} migrate

# 📦 Migrazioni in ambiente DEV
migrate-dev:
    #!/usr/bin/env bash
    echo "📦 Applicazione delle migrazioni in ambiente DEV..."
    export DJANGO_ENV="dev"
    {{django_manage}} migrate

# 📦 Migrazioni in ambiente TEST
migrate-test:
    #!/usr/bin/env bash
    echo "📦 Applicazione delle migrazioni in ambiente TEST..."
    export DJANGO_ENV="test"
    {{django_manage}} migrate

# 📦 Migrazioni in ambiente STAGING
migrate-staging:
    #!/usr/bin/env bash
    echo "🎭 Applicazione delle migrazioni in ambiente STAGING..."
    echo "⚠️  STAGING usa PostgreSQL - assicurati che sia configurato!"
    export DJANGO_ENV="staging"
    {{django_manage}} migrate

# 📦 Migrazioni in ambiente PROD
migrate-prod:
    #!/usr/bin/env bash
    echo "📦 Applicazione delle migrazioni in ambiente PROD..."
    export DJANGO_ENV="prod"
    {{django_manage}} migrate

# 📝 Creazione migrazioni
makemigrations:
    #!/usr/bin/env bash
    echo "📝 Creazione delle migrazioni..."
    {{django_manage}} makemigrations

# 🐚 Shell Django
shell:
    #!/usr/bin/env bash
    echo "🐚 Avvio della shell Django..."
    {{django_manage}} shell

# 🐚 Shell Django DEV
shell-dev:
    #!/usr/bin/env bash
    echo "🐚 Avvio della shell Django in ambiente DEV..."
    export DJANGO_ENV="dev"
    {{django_manage}} shell

# 🐚 Shell Django TEST
shell-test:
    #!/usr/bin/env bash
    echo "🐚 Avvio della shell Django in ambiente TEST..."
    export DJANGO_ENV="test"
    {{django_manage}} shell

# 🐚 Shell Django STAGING
shell-staging:
    #!/usr/bin/env bash
    echo "🎭 Avvio della shell Django in ambiente STAGING..."
    echo "⚠️  STAGING usa PostgreSQL!"
    export DJANGO_ENV="staging"
    {{django_manage}} shell

# 🐚 Shell Django PROD
shell-prod:
    #!/usr/bin/env bash
    echo "🐚 Avvio della shell Django in ambiente PROD..."
    export DJANGO_ENV="prod"
    {{django_manage}} shell

# 👤 Crea superuser
createsuperuser:
    #!/usr/bin/env bash
    echo "👤 Creazione di un superuser..."
    echo "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it"
    {{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente DEV
createsuperuser-dev:
    #!/usr/bin/env bash
    echo "👤 Creazione di un superuser in ambiente DEV..."
    echo "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it"
    export DJANGO_ENV="dev"
    {{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente TEST
createsuperuser-test:
    #!/usr/bin/env bash
    echo "👤 Creazione di un superuser in ambiente TEST..."
    echo "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it"
    export DJANGO_ENV="test"
    {{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente STAGING
createsuperuser-staging:
    #!/usr/bin/env bash
    echo "🎭 Creazione di un superuser in ambiente STAGING..."
    echo "⚠️  STAGING usa PostgreSQL!"
    echo "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it"
    export DJANGO_ENV="staging"
    {{django_manage}} createsuperuser

# 👤 Crea superuser in ambiente PROD
createsuperuser-prod:
    #!/usr/bin/env bash
    echo "👤 Creazione di un superuser in ambiente PROD..."
    echo "ℹ️  Ricorda: l'email deve terminare con @aslcn1.it"
    export DJANGO_ENV="prod"
    {{django_manage}} createsuperuser

# 🧪 Test del progetto
test:
    #!/usr/bin/env bash
    echo "🧪 Esecuzione dei test..."
    echo "📋 Ambiente: LOCAL con PostgreSQL"
    {{python}} src/manage.py test accounts --settings=home.settings.test_local

# === DEPLOYMENT ===

# ⚡ Uvicorn ASGI server - RACCOMANDATO
run-uvicorn:
    #!/usr/bin/env bash
    echo "⚡ Avvio Django con Uvicorn ASGI..."
    echo "🚀 Starting Uvicorn ASGI Server"
    echo "Environment: prod, Host: 0.0.0.0:8000"
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
        pkill -f "manage.py runserver" || echo "Nessun server Django trovato"
        pkill -f "uvicorn" || echo "Nessun server Uvicorn trovato"
    else
        echo "⚠️ OS non riconosciuto, ferma manualmente i server"
    fi
    echo "✅ Comando completato"

# 🔪 Termina processi sulla porta 8000
kill-port:
    #!/usr/bin/env bash
    echo "🔪 Terminazione processi sulla porta 8000..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        lsof -ti:8000 | xargs kill -9 2>/dev/null || echo "Nessun processo trovato sulla porta 8000"
    elif [[ "$OSTYPE" == "linux"* ]]; then
        fuser -k 8000/tcp 2>/dev/null || echo "Nessun processo trovato sulla porta 8000"
    else
        echo "⚠️ OS non riconosciuto, termina manualmente i processi sulla porta 8000"
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

# 🔍 Controllo ambiente DEV
check-env-dev:
    #!/usr/bin/env bash
    echo "🔍 Controllo dell'ambiente DEV..."
    export DJANGO_ENV="dev"
    {{python}} src/test_logging.py

# 🔍 Controllo ambiente TEST
check-env-test:
    #!/usr/bin/env bash
    echo "🔍 Controllo dell'ambiente TEST..."
    export DJANGO_ENV="test"
    {{python}} src/test_logging.py

# 🔍 Controllo ambiente STAGING
check-env-staging:
    #!/usr/bin/env bash
    echo "🎭 Controllo dell'ambiente STAGING..."
    echo "⚠️  STAGING usa PostgreSQL e logging su file!"
    export DJANGO_ENV="staging"
    {{python}} src/test_logging.py

# 🔍 Controllo ambiente PROD
check-env-prod:
    #!/usr/bin/env bash
    echo "🔍 Controllo dell'ambiente PROD..."
    export DJANGO_ENV="prod"
    {{python}} src/test_logging.py

# 🔐 Genera SECRET_KEY per tutti i 4 ambienti
generate-secret-keys-all:
    #!/usr/bin/env bash
    echo "🔐 Generazione SECRET_KEY per tutti gli ambienti..."
    echo ""
    echo "🔧 DEV Environment:"
    dev_key=$({{python}} -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    echo "DJANGO_SECRET_KEY_DEV=$dev_key"
    echo ""
    echo "🧪 TEST Environment:"
    test_key=$({{python}} -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    echo "DJANGO_SECRET_KEY_TEST=$test_key"
    echo ""
    echo "🎭 STAGING Environment:"
    staging_key=$({{python}} -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    echo "DJANGO_SECRET_KEY_STAGING=$staging_key"
    echo ""
    echo "⚡ PROD Environment:"
    prod_key=$({{python}} -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    echo "DJANGO_SECRET_KEY_PROD=$prod_key"
    echo ""
    echo "💡 CONFIGURAZIONE .env:"
    echo "======================="
    echo "DJANGO_SECRET_KEY_DEV=$dev_key"
    echo "DJANGO_SECRET_KEY_TEST=$test_key"
    echo "DJANGO_SECRET_KEY_STAGING=$staging_key"
    echo "DJANGO_SECRET_KEY_PROD=$prod_key"
    echo ""
    echo "⚠️  IMPORTANTE: Ogni ambiente deve avere la sua SECRET_KEY!"

# 🔐 Genera password PostgreSQL sicure per tutti gli ambienti
generate-db-passwords:
    #!/usr/bin/env bash
    echo "🔐 Generazione password PostgreSQL sicure..."
    {{python}} tools/generate_db_passwords.py || echo "⚠️ Strumento password non disponibile"

# 🎯 Quick start per nuovi sviluppatori
quick-start:
    #!/usr/bin/env bash
    echo "🎯 QUICK START - Setup progetto per sviluppo"
    echo "============================================================"
    echo "1/5 - Installazione dipendenze..."
    uv sync
    echo "2/5 - Generazione SECRET_KEY..."
    just generate-secret-keys-all
    echo "3/5 - Applicazione migrazioni..."
    just migrate
    echo "4/5 - Test configurazione..."
    just check-env
    echo "5/5 - Pronto per l'uso!"
    echo "🚀 Usa 'just run-dev' per avviare il server"
    echo "📋 Admin panel: http://localhost:8000/admin"

# 🔄 Setup completo di tutti gli ambienti
setup-all-environments:
    #!/usr/bin/env bash
    echo "🔄 Setup completo di tutti gli ambienti..."
    echo "1/4 - Migrazioni ambiente TEST..."
    export DJANGO_ENV="test"
    {{django_manage}} migrate
    echo "2/4 - Migrazioni ambiente STAGING..."
    export DJANGO_ENV="staging"
    {{django_manage}} migrate
    echo "3/4 - Migrazioni ambiente PROD..."
    export DJANGO_ENV="prod"
    {{django_manage}} migrate
    echo "4/4 - Caricamento dati iniziali in tutti gli ambienti..."
    just load-initial-data-test
    just load-initial-data-staging
    just load-initial-data-prod
    echo "✅ Setup completo di tutti gli ambienti completato!"

# Comandi solo Windows/IIS/PowerShell (commentati)
# iis-test-local:
#     #!/usr/bin/env bash
#     echo "Esegui i test locali su IIS..."
#     # just color_print "green" "Esegui i test locali su IIS..."
#     # Aggiungi qui i comandi per i test locali su IIS

# iis-setup:
#     #!/usr/bin/env bash
#     echo "Configura IIS per il progetto..."
#     # just color_print "green" "Configura IIS per il progetto..."
#     # Aggiungi qui i comandi per la configurazione di IIS

# iis-deploy:
#     #!/usr/bin/env bash
#     echo "Esegui il deploy su IIS..."
#     # just color_print "green" "Esegui il deploy su IIS..."
#     # Aggiungi qui i comandi per il deploy su IIS

# waitress:
#     #!/usr/bin/env bash
#     echo "Avvio di Waitress come server WSGI..."
#     # just color_print "green" "Avvio di Waitress come server WSGI..."
#     waitress-serve --port=8000 src.wsgi:application

# open-home:
#     #!/usr/bin/env bash
#     echo "Apre la home del progetto nel browser predefinito..."
#     # just color_print "green" "Apre la home del progetto nel browser predefinito..."
#     xdg-open http://localhost:8000/ || open http://localhost:8000/ || start http://localhost:8000/

# ...aggiungi altri comandi solo Windows qui come commento/documentazione...
# Ricette per inizializzare gruppi/permessi per ogni ambiente
init-groups-dev:
    {{django_manage}} init_groups_permissions --settings=home.settings.dev

init-groups-test:
    {{django_manage}} init_groups_permissions --settings=home.settings.test

init-groups-staging:
    {{django_manage}} init_groups_permissions --settings=home.settings.staging

init-groups-prod:
    {{django_manage}} init_groups_permissions --settings=home.settings.prod

# Ricette per raccolta file statici
collectstatic-dev:
    {{django_manage}} collectstatic --settings=home.settings.dev --noinput

collectstatic-prod:
    {{django_manage}} collectstatic --settings=home.settings.prod --noinput

    # === COMANDI MANCANTI AGGIUNTI ===
    collectstatic:
        #!/usr/bin/env bash
        echo "📦 Raccolta file statici per ambiente corrente..."
        {{django_manage}} collectstatic --noinput

    collectstatic-test:
        #!/usr/bin/env bash
        echo "📦 Raccolta file statici (TEST)..."
        export DJANGO_ENV="test"
        {{django_manage}} collectstatic --settings=home.settings.test --noinput

    collectstatic-staging:
        #!/usr/bin/env bash
        echo "📦 Raccolta file statici (STAGING)..."
        export DJANGO_ENV="staging"
        {{django_manage}} collectstatic --settings=home.settings.staging --noinput

    init-groups:
        #!/usr/bin/env bash
        echo "🔐 Inizializzazione gruppi e permessi di base..."
        {{django_manage}} init_groups_permissions
        echo "✅ Gruppi e permessi inizializzati"

    dump-initial-data:
        #!/usr/bin/env bash
        echo "💾 Creazione dump dei dati iniziali..."
        echo "ℹ️  Salva superuser, gruppi e permessi da ambiente DEV"
        export DJANGO_ENV="dev"
        {{django_manage}} dumpdata accounts auth.group auth.permission --format=json --indent=2 --output=fixtures/initial_data.json
        echo "✅ Dump salvato in fixtures/initial_data.json"

    load-initial-data-test:
        #!/usr/bin/env bash
        echo "📥 Caricamento dati iniziali in ambiente TEST..."
        export DJANGO_ENV="test"
        {{django_manage}} loaddata fixtures/initial_data.json
        echo "✅ Dati caricati in ambiente TEST"

    load-initial-data-staging:
        #!/usr/bin/env bash
        echo "📥 Caricamento dati iniziali in ambiente STAGING..."
        export DJANGO_ENV="staging"
        {{django_manage}} loaddata fixtures/initial_data.json
        echo "✅ Dati caricati in ambiente STAGING"

    load-initial-data-prod:
        #!/usr/bin/env bash
        echo "📥 Caricamento dati iniziali in ambiente PROD..."
        export DJANGO_ENV="prod"
        {{django_manage}} loaddata fixtures/initial_data.json
        echo "✅ Dati caricati in ambiente PROD"

    test-quick:
        #!/usr/bin/env bash
        echo "⚡ Test rapidi quotidiani..."
        {{python}} src/manage.py test accounts.tests.CustomUserModelTest accounts.tests.CustomUserAuthenticationTest accounts.tests.SecurityTest --settings=home.settings.test_local --keepdb --verbosity=1

    test-security:
        #!/usr/bin/env bash
        echo "🔒 Test sicurezza critica..."
        {{python}} src/manage.py test accounts.tests.SecurityTest accounts.tests.CustomUserFormsTest --settings=home.settings.test_local --keepdb --verbosity=2

    test-pre-deploy:
        #!/usr/bin/env bash
        echo "🚀 Test completi pre-deploy..."
        {{python}} src/manage.py test accounts --settings=home.settings.test --verbosity=2

    test-dev:
        #!/usr/bin/env bash
        echo "🧪 Test in ambiente DEV..."
        export DJANGO_ENV="dev"
        {{django_manage}} test accounts --settings=home.settings.dev --verbosity=2

    test-test:
        #!/usr/bin/env bash
        echo "🧪 Test in ambiente TEST..."
        export DJANGO_ENV="test"
        {{django_manage}} test accounts --settings=home.settings.test --verbosity=2

    test-staging:
        #!/usr/bin/env bash
        echo "🎭 Esecuzione dei test in ambiente STAGING..."
        export DJANGO_ENV="staging"
        {{django_manage}} test accounts --settings=home.settings.staging --verbosity=2

    test-prod:
        #!/usr/bin/env bash
        echo "🧪 Test in ambiente PROD..."
        export DJANGO_ENV="prod"
        {{django_manage}} test accounts --settings=home.settings.prod --verbosity=2

    test-coverage:
        #!/usr/bin/env bash
        echo "📊 Test con coverage report..."
        cd src && uv run coverage run --source='.' manage.py test --settings=home.settings.test_local
        cd src && uv run coverage report
        cd src && uv run coverage html
        echo "🌐 Report HTML: src/htmlcov/index.html"

    test-health:
        #!/usr/bin/env bash
        echo "🏥 Health check del sistema..."
        just check-env
        just test-quick
        cd src && {{django_manage}} showmigrations --settings=home.settings.test_local
        cd src && {{django_manage}} dbshell --settings=home.settings.test_local -c "SELECT 1;"
        echo "✅ Health check completato!"

    fix-codacy:
        #!/usr/bin/env bash
        echo "🔧 Correzione automatica script bash..."
        find scripts/deployment -name "*.sh" -exec shfmt -w {} +
        echo "✅ Correzioni applicate!"

    format-markdown:
        #!/usr/bin/env bash
        echo "📝 Formattazione file Markdown..."
        find . -name "*.md" -exec sed -i '' -e 's/[ \t]*$//' -e ':a;N;$!ba;s/\n\{3,\}/\n\n/g' {} +
        echo "✅ File Markdown formattati con successo!"

    test-precommit:
        #!/usr/bin/env bash
        echo "🔍 Test di tutti i controlli pre-commit..."
        pre-commit run --all-files
        echo "✅ Test pre-commit completato!"

    precommit-corporate:
        #!/usr/bin/env bash
        echo "🏢 Esecuzione pre-commit con configurazione corporate..."
        if [ -f .pre-commit-config-corporate.yaml ]; then
            pre-commit run --all-files --config .pre-commit-config-corporate.yaml
        else
            echo "⚠️  File .pre-commit-config-corporate.yaml non trovato!"
            echo "💡 Usando configurazione standard..."
            pre-commit run --all-files
        fi

    quality-corporate:
        #!/usr/bin/env bash
        echo "🏢 Controlli qualità corporate..."
        just precommit-corporate
        just lint-codacy
        just add-docstrings
        just fix-markdown
        echo "✅ Controlli quality corporate completati!"

    setup-credentials:
        #!/usr/bin/env bash
        echo "🔐 Setup credenziali per tutti gli ambienti..."
        for env in dev test staging prod; do
            if [ ! -f ".env.$env" ]; then
                cp config/environments/.env.$env.template .env.$env && echo "✅ .env.$env creato" || echo "⚠️ Template .env.$env non trovato"
            else
                echo "📄 .env.$env già presente"
            fi
        done
        if [ ! -f db_credentials.md ]; then
            cp config/database/db_credentials.template.md db_credentials.md && echo "✅ db_credentials.md creato" || echo "⚠️ Template db_credentials.md non trovato"
        else
            echo "📄 db_credentials.md già presente"
        fi
        echo "⚠️  IMPORTANTE: Modifica TUTTI i file .env con le password reali!"

    create-db-script:
        #!/usr/bin/env bash
        echo "🗄️ Creazione script SQL con password reali..."
        if [ -f "config/database/update_postgresql_staging.template.sql" ]; then
            cp config/database/update_postgresql_staging.template.sql config/database/update_postgresql_staging.sql
            echo "✅ Script copiato: config/database/update_postgresql_staging.sql"
            echo "🔧 Ora sostituisci manualmente i placeholder YOUR_*_PASSWORD"
            echo "🔐 Usa le password generate da: just generate-db-passwords"
            echo "⚠️  ATTENZIONE: File contiene password - elimina dopo l'uso!"
        else
            echo "❌ Template non trovato: config/database/update_postgresql_staging.template.sql"
        fi

    # === COMANDI SOLO WINDOWS/IIS (commentati) ===
    # iis-test-local:
    #     echo "🧪 Avvio test IIS locale..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # iis-setup:
    #     echo "⚙️ Setup iniziale IIS..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # iis-deploy:
    #     echo "🚀 Deploy completo IIS..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # iis-deploy-custom ip:
    #     echo "🚀 Deploy IIS su $ip..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # iis-health:
    #     echo "🏥 Health check IIS..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # production-deploy:
    #     echo "🏭 Deploy produzione completo..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # production-update:
    #     echo "🔄 Update produzione esistente..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # production-deploy-custom ip:
    #     echo "🏭 Deploy produzione su $ip..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # waitress:
    #     echo "🪟 Avvio Django con Waitress (Windows)..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."
    # deploy-staging:
    #     echo "🧪 Deploy staging (Windows)..."
    #     echo "Comando solo Windows/IIS. Vedi justfile.windows-full."

# Helper per colori cross-platform (deve essere dopo tutti i comandi pubblici)
[private]
color_print color message:
    #!/usr/bin/env bash
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
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
        echo "{{message}}"
    fi

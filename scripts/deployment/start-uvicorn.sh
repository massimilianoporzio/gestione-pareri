#!/bin/bash
"""
Script per avviare Uvicorn (ASGI server) su sistemi Unix-like.
Supporta configurazione tramite variabili d'ambiente.
"""

set -e

# Configurazione predefinita
DJANGO_ENV=${DJANGO_ENV:-prod}
HOST=${HOST:-0.0.0.0}
PORT=${PORT:-8000}
WORKERS=${WORKERS:-4}
WORKER_CLASS=${WORKER_CLASS:-uvicorn.workers.UvicornWorker}
TIMEOUT=${TIMEOUT:-30}
KEEP_ALIVE=${KEEP_ALIVE:-2}
MAX_REQUESTS=${MAX_REQUESTS:-1000}
MAX_REQUESTS_JITTER=${MAX_REQUESTS_JITTER:-100}
LOG_LEVEL=${LOG_LEVEL:-info}

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Uvicorn ASGI Server${NC}"
echo -e "${YELLOW}Environment: ${DJANGO_ENV}${NC}"
echo -e "${YELLOW}Host: ${HOST}:${PORT}${NC}"

# Verifica che uv sia installato
if ! command -v uv &> /dev/null; then
    echo -e "${RED}❌ uv non trovato. Installa uv per continuare.${NC}"
    exit 1
fi

# Crea directory per i log se necessaria
mkdir -p logs

# Imposta DJANGO_SETTINGS_MODULE in base a DJANGO_ENV
export DJANGO_SETTINGS_MODULE="home.settings.${DJANGO_ENV}"
export PYTHONPATH="${PYTHONPATH}:src"

echo -e "${GREEN}✅ Configurazione completata${NC}"
echo -e "${YELLOW}Django Environment: ${DJANGO_SETTINGS_MODULE}${NC}"

# Determina il comando Uvicorn
if [ "${DJANGO_ENV}" = "dev" ]; then
    # Modalità sviluppo: single process con reload
    echo -e "${YELLOW}🔄 Modalità sviluppo: hot-reload attivo${NC}"
    uv run uvicorn home.asgi:application \
        --host "${HOST}" \
        --port "${PORT}" \
        --reload \
        --log-level "${LOG_LEVEL}" \
        --access-log \
        --app-dir src
else
    # Modalità produzione: multi-worker
    if [ "${WORKERS}" -eq 1 ]; then
        echo -e "${YELLOW}⚡ Modalità produzione: single worker${NC}"
        uv run uvicorn home.asgi:application \
            --host "${HOST}" \
            --port "${PORT}" \
            --log-level "${LOG_LEVEL}" \
            --access-log \
            --app-dir src \
            --timeout-keep-alive "${KEEP_ALIVE}"
    else
        # Multi-worker usando Gunicorn con Uvicorn worker
        echo -e "${YELLOW}⚡ Modalità produzione: ${WORKERS} workers${NC}"
        uv run gunicorn home.asgi:application \
            --bind "${HOST}:${PORT}" \
            --workers "${WORKERS}" \
            --worker-class uvicorn.workers.UvicornWorker \
            --timeout "${TIMEOUT}" \
            --keep-alive "${KEEP_ALIVE}" \
            --max-requests "${MAX_REQUESTS}" \
            --max-requests-jitter "${MAX_REQUESTS_JITTER}" \
            --log-level "${LOG_LEVEL}" \
            --access-logfile - \
            --error-logfile - \
            --chdir src
    fi
fi

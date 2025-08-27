#!/bin/bash
# Start Uvicorn ASGI server for Render (multi-worker, production)
# Usage: ./scripts/deployment/start-uvicorn-render.sh

set -e

APP_MODULE="home.asgi:application"
APP_DIR="src"
HOST="0.0.0.0"
PORT="${PORT:-8000}"
WORKERS="${UVICORN_WORKERS:-4}"
LOG_LEVEL="info"

cd "$APP_DIR"
echo "Starting Uvicorn ASGI server on $HOST:$PORT with $WORKERS workers..."
uvicorn "$APP_MODULE" \
  --host "$HOST" \
  --port "$PORT" \
  --log-level "$LOG_LEVEL" \
  --workers "$WORKERS"

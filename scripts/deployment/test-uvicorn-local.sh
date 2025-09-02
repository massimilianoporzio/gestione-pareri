#!/bin/bash
# Test Uvicorn ASGI app locally (single worker, debug mode)
# Usage: ./scripts/deployment/test-uvicorn-local.sh [PORT]

set -e
PORT=${1:-8000}
APP_MODULE="home.asgi:application"
APP_DIR="src"

cd "$APP_DIR"
echo "Testing Uvicorn ASGI app on http://127.0.0.1:$PORT ..."
uv run uvicorn "$APP_MODULE" \
	--host 0.0.0.0 \
	--port "$PORT" \
	--log-level debug

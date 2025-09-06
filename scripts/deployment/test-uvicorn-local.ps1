# Test Uvicorn ASGI app locally (single worker, debug mode)
# Usage: .\scripts\deployment\test-uvicorn-local.ps1 [PORT]

param(
    [int]$PORT = 8000
)

$APP_MODULE = "home.asgi:application"
$APP_DIR = "src"

Write-Host "Testing Uvicorn ASGI app on http://127.0.0.1:$PORT ..." -ForegroundColor Cyan
Push-Location $APP_DIR
uv run uvicorn $APP_MODULE --host 0.0.0.0 --port $PORT --log-level debug
Pop-Location

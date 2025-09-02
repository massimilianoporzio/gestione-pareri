# Script per avviare Uvicorn (ASGI server) su Windows
# Supporta configurazione tramite parametri e variabili d'ambiente

param(
    [string]$DjangoEnv = $env:DJANGO_ENV ?? "prod",
    [string]$Host = $env:HOST ?? "0.0.0.0",
    [int]$Port = [int]($env:PORT ?? 8000),
    [int]$Workers = [int]($env:WORKERS ?? 1),
    [string]$LogLevel = $env:LOG_LEVEL ?? "info",
    [int]$Timeout = [int]($env:TIMEOUT ?? 30),
    [int]$KeepAlive = [int]($env:KEEP_ALIVE ?? 2),
    [int]$MaxRequests = [int]($env:MAX_REQUESTS ?? 1000),
    [int]$MaxRequestsJitter = [int]($env:MAX_REQUESTS_JITTER ?? 100)
)

Write-Host "🚀 Starting Uvicorn ASGI Server" -ForegroundColor Blue
Write-Host "Environment: $DjangoEnv" -ForegroundColor Yellow
Write-Host "Host: ${Host}:${Port}" -ForegroundColor Yellow

# Verifica che uv sia installato
try {
    $null = Get-Command uv -ErrorAction Stop
} catch {
    Write-Host "❌ uv non trovato. Installa uv per continuare." -ForegroundColor Red
    exit 1
}

# Crea directory per i log se necessaria
if (!(Test-Path "logs")) {
    New-Item -ItemType Directory -Path "logs" -Force | Out-Null
}

# Imposta variabili d'ambiente
$env:DJANGO_SETTINGS_MODULE = "home.settings.$DjangoEnv"
$env:PYTHONPATH = "src;$env:PYTHONPATH"

Write-Host "✅ Configurazione completata" -ForegroundColor Green
Write-Host "Django Environment: $env:DJANGO_SETTINGS_MODULE" -ForegroundColor Yellow

# Determina il comando Uvicorn
if ($DjangoEnv -eq "dev") {
    # Modalità sviluppo: single process con reload
    Write-Host "🔄 Modalità sviluppo: hot-reload attivo" -ForegroundColor Yellow
    uv run uvicorn home.asgi:application --host $Host --port $Port --reload --log-level $LogLevel --access-log --app-dir src
} else {
    # Modalità produzione
    if ($Workers -eq 1) {
        Write-Host "⚡ Modalità produzione: single worker" -ForegroundColor Yellow
        uv run uvicorn home.asgi:application --host $Host --port $Port --log-level $LogLevel --access-log --app-dir src --timeout-keep-alive $KeepAlive
    } else {
        # Su Windows, multi-worker è più complesso, usiamo single worker ottimizzato
        Write-Host "⚡ Modalità produzione: single worker (Windows optimized)" -ForegroundColor Yellow
        uv run uvicorn home.asgi:application --host $Host --port $Port --log-level $LogLevel --access-log --app-dir src --timeout-keep-alive $KeepAlive
    }
}

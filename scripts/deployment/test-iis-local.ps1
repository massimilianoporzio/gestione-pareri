param(
    [string]$ServerIP = "localhost",
    [int]$Port = 8000,
    [string]$SubPath = "/pratiche-pareri"
)

Write-Host "Test IIS locale per Gestione Pareri" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green

# Configurazione variabili d'ambiente
$env:DJANGO_SETTINGS_MODULE = "home.settings.prod"
$env:DJANGO_DATABASE_URL = "postgresql://gestione_pareri_prod:ciK1cFRx6wV8XcFrW8crr120zDsZS8AXjfVVYXGz@localhost:5432/gestione_pareri_prod"
$env:DJANGO_SECRET_KEY = "test-secret-key-for-local-testing-12345"
$env:DJANGO_DEBUG = "False"
$env:DJANGO_ENVIRONMENT = "PROD"
$env:DJANGO_ALLOWED_HOSTS = "localhost,127.0.0.1,$ServerIP"
$env:DJANGO_CSRF_TRUSTED_ORIGINS = "http://localhost:$Port,http://127.0.0.1:$Port,http://$ServerIP`:$Port"
$env:DJANGO_FORCE_SCRIPT_NAME = $SubPath
$env:DJANGO_SECURE_SSL_REDIRECT = "False"
$env:DJANGO_TEST_DB = "True"
$env:DJANGO_LOGS_DIR = "E:\prod\logs\gestione_pratiche"

Write-Host "Cambio directory..." -ForegroundColor Yellow
Set-Location "src"

Write-Host "Controllo database..." -ForegroundColor Yellow
try {
    uv run manage.py check --settings=home.settings.prod
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Check Django fallito!" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "Errore nel check Django: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "Raccolta file statici..." -ForegroundColor Yellow
uv run manage.py collectstatic --noinput --settings=home.settings.prod

Write-Host "Migrazione database..." -ForegroundColor Yellow
uv run manage.py migrate --settings=home.settings.prod

Write-Host "Avvio server Uvicorn (ASGI)..." -ForegroundColor Yellow
Write-Host "URL Principale: http://$ServerIP`:$Port$SubPath/" -ForegroundColor Cyan
Write-Host "URL Admin: http://$ServerIP`:$Port$SubPath/admin/" -ForegroundColor Cyan
Write-Host "Premi Ctrl+C per fermare il server" -ForegroundColor Yellow
Write-Host ""

# Avvia il server Django con Uvicorn
Write-Host "Avvio server Uvicorn (ASGI)..." -ForegroundColor Cyan

# Esegui uvicorn con gestione pulita degli errori
try {
    & uv run uvicorn home.asgi:application --host $ServerIP --port $Port 2>$null
} catch {
    # Ignora errori di interruzione normale (Ctrl+C)
} finally {
    Write-Host "Server fermato." -ForegroundColor Yellow
}

Write-Host "Server fermato." -ForegroundColor Yellow

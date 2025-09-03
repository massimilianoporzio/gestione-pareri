# Waitress deployment script for Windows
# Usage: powershell -ExecutionPolicy Bypass -File start-waitress.ps1

param(
    [string]$DjangoEnv = "prod",
    [string]$BindAddress = "0.0.0.0",
    [int]$Port = 8000,
    [int]$Threads = 4,
    [string]$ConnectionLimit = "1000",
    [string]$ChannelTimeout = "120"
)

# Configuration
$ErrorActionPreference = "Stop"

# Set console output encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Change to project directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectDir = Join-Path $ScriptDir "../.."
Set-Location $ProjectDir

# Activate virtual environment if exists
if (Test-Path ".venv") {
    & ".venv\Scripts\Activate.ps1"
}

Write-Host "[WAITRESS] Starting Django with Waitress" -ForegroundColor Green
Write-Host "Environment: $DjangoEnv" -ForegroundColor Cyan
Write-Host "Host: $BindAddress" -ForegroundColor Cyan
Write-Host "Port: $Port" -ForegroundColor Cyan
Write-Host "Threads: $Threads" -ForegroundColor Cyan

# Set Django environment
$env:DJANGO_ENV = $DjangoEnv

# Run database migrations
Write-Host "📊 Running migrations..." -ForegroundColor Yellow
python src/manage.py migrate --no-input

# Collect static files
Write-Host "📁 Collecting static files..." -ForegroundColor Yellow
# Note: staticfiles/ directory is auto-generated and should not be committed to Git
# It's recreated on each deployment and contains processed/compressed static files
python src/manage.py collectstatic --no-input --clear

# Start Waitress
Write-Host "🌟 Starting Waitress server..." -ForegroundColor Green

# Change to src directory so Python can find the modules
Set-Location "src"

waitress-serve `
    --host=$BindAddress `
    --port=$Port `
    --threads=$Threads `
    --connection-limit=$ConnectionLimit `
    --channel-timeout=$ChannelTimeout `
    "home.wsgi:application"

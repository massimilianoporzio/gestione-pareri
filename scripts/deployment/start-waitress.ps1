# Waitress deployment script for Windows
# Usage: powershell -ExecutionPolicy Bypass -File start-waitress.ps1

param(
    [string]$DjangoEnv = "prod",
    [string]$Host = "0.0.0.0",
    [int]$Port = 8000,
    [int]$Threads = 4,
    [string]$ConnectionLimit = "1000",
    [string]$ChannelTimeout = "120"
)

# Configuration
$ErrorActionPreference = "Stop"

# Change to project directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectDir = Join-Path $ScriptDir "../.."
Set-Location $ProjectDir

# Activate virtual environment if exists
if (Test-Path ".venv") {
    & ".venv\Scripts\Activate.ps1"
}

Write-Host "🚀 Starting Django with Waitress" -ForegroundColor Green
Write-Host "Environment: $DjangoEnv" -ForegroundColor Cyan
Write-Host "Host: $Host" -ForegroundColor Cyan
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
waitress-serve `
    --host=$Host `
    --port=$Port `
    --threads=$Threads `
    --connection-limit=$ConnectionLimit `
    --channel-timeout=$ChannelTimeout `
    --call `
    "src.home.wsgi:application"

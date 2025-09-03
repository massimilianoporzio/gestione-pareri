# 🚀 SCRIPT DEPLOYMENT PRODUZIONE COMPLETO
# production-deploy.ps1

param(
    [string]$ServerIP = "192.168.1.100",
    [string]$DeployPath = "C:\inetpub\wwwroot\pratiche-pareri",
    [string]$SiteName = "GestionePareri", 
    [string]$AppPoolName = "GestionePareriPool",
    [string]$GitRepo = "https://github.com/massimilianoporzio/gestione-pareri.git",
    [switch]$SkipClone = $false,
    [switch]$UpdateOnly = $false
)

Write-Host "🚀 DEPLOYMENT PRODUZIONE - Gestione Pareri" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host "Deploy Path: $DeployPath" -ForegroundColor Cyan
Write-Host "Server IP: $ServerIP" -ForegroundColor Cyan
Write-Host ""

# Verifica privilegi amministratore
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ ERRORE: Questo script richiede privilegi di amministratore!" -ForegroundColor Red
    Write-Host "Esegui PowerShell come amministratore e riprova." -ForegroundColor Yellow
    exit 1
}

if ($UpdateOnly) {
    Write-Host "🔄 MODALITÀ UPDATE - Solo aggiornamento applicazione esistente" -ForegroundColor Yellow
    Set-Location $DeployPath
    
    # Pull latest changes
    Write-Host "📥 Pull delle modifiche dal repository..." -ForegroundColor Yellow
    git pull origin main
    
    # Update dependencies
    Write-Host "📦 Aggiornamento dipendenze..." -ForegroundColor Yellow
    uv sync
    
    # Run migrations
    Write-Host "🗃️  Esecuzione migrazioni..." -ForegroundColor Yellow
    uv run python src/manage.py migrate --settings=home.settings.prod
    
    # Collect static files
    Write-Host "🎨 Raccolta file statici..." -ForegroundColor Yellow
    uv run python src/manage.py collectstatic --noinput --settings=home.settings.prod
    
    # Restart Application Pool
    Write-Host "♻️  Restart Application Pool..." -ForegroundColor Yellow
    Restart-WebAppPool -Name $AppPoolName
    
    Write-Host "✅ Aggiornamento completato!" -ForegroundColor Green
    exit 0
}

# ============================================
# INSTALLAZIONE COMPLETA
# ============================================

# 1. Setup Directory e Repository
if (!$SkipClone) {
    Write-Host "📁 Setup directory di deployment..." -ForegroundColor Yellow
    
    if (Test-Path $DeployPath) {
        $backup = "${DeployPath}_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Write-Host "⚠️  Directory esistente, backup in: $backup" -ForegroundColor Yellow
        Move-Item $DeployPath $backup
    }
    
    # Clone repository
    Write-Host "📥 Clone repository da GitHub..." -ForegroundColor Yellow
    git clone $GitRepo $DeployPath
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Errore nel clone del repository!" -ForegroundColor Red
        exit 1
    }
}

Set-Location $DeployPath

# 2. Setup Files di Configurazione
Write-Host "⚙️  Setup file di configurazione..." -ForegroundColor Yellow

if (!(Test-Path "web.config")) {
    if (Test-Path "config/deployment/web.config.template") {
        Copy-Item "config/deployment/web.config.template" "web.config"
        Write-Host "✅ web.config creato da template" -ForegroundColor Green
    } else {
        Write-Host "❌ Template config/deployment/web.config.template non trovato!" -ForegroundColor Red
        exit 1
    }
}

if (!(Test-Path ".env.prod")) {
    if (Test-Path "config/environments/.env.prod") {
        Copy-Item "config/environments/.env.prod" ".env.prod"
        Write-Host "✅ .env.prod copiato da config/environments/" -ForegroundColor Green
    } elseif (Test-Path "config/environments/.env.prod.template") {
        Copy-Item "config/environments/.env.prod.template" ".env.prod"
        Write-Host "✅ .env.prod creato da template" -ForegroundColor Green
    } else {
        Write-Host "❌ Né .env.prod né template trovati in config/environments/!" -ForegroundColor Red
        exit 1
    }
}

# 3. Verifica prerequisiti
Write-Host "🔍 Verifica prerequisiti..." -ForegroundColor Yellow

# Check uv
if (!(Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "❌ uv package manager non trovato!" -ForegroundColor Red
    Write-Host "Installa uv: https://docs.astral.sh/uv/getting-started/installation/" -ForegroundColor Yellow
    exit 1
}

# Check PostgreSQL
try {
    psql -U postgres -c "SELECT version();" 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ PostgreSQL disponibile" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️  PostgreSQL non trovato o non configurato" -ForegroundColor Yellow
}

# 4. Setup Python Environment
Write-Host "🐍 Setup ambiente Python..." -ForegroundColor Yellow
uv sync
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Errore nel setup delle dipendenze Python!" -ForegroundColor Red
    exit 1
}

# 5. Database Setup (se configurato)
Write-Host "🗃️  Setup database..." -ForegroundColor Yellow

# Check Django configuration
uv run python src/manage.py check --settings=home.settings.prod
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Configurazione Django non valida!" -ForegroundColor Red
    Write-Host "Verifica web.config e .env.prod con le credenziali corrette" -ForegroundColor Yellow
    exit 1
}

# Run migrations
uv run python src/manage.py migrate --settings=home.settings.prod
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Errore nelle migrazioni database!" -ForegroundColor Red
    exit 1
}

# 6. Static Files
Write-Host "🎨 Raccolta file statici..." -ForegroundColor Yellow
uv run python src/manage.py collectstatic --noinput --settings=home.settings.prod

# 7. IIS Configuration
Write-Host "🌐 Configurazione IIS..." -ForegroundColor Yellow

Import-Module WebAdministration

# Create Application Pool
if (Get-IISAppPool -Name $AppPoolName -ErrorAction SilentlyContinue) {
    Write-Host "♻️  Rimozione Application Pool esistente..." -ForegroundColor Yellow
    Remove-WebAppPool -Name $AppPoolName -Confirm:$false
}

Write-Host "🏗️  Creazione Application Pool..." -ForegroundColor Yellow
New-WebAppPool -Name $AppPoolName
Set-ItemProperty -Path "IIS:\AppPools\$AppPoolName" -Name "processModel.identityType" -Value "ApplicationPoolIdentity"
Set-ItemProperty -Path "IIS:\AppPools\$AppPoolName" -Name "enable32BitAppOnWin64" -Value $false

# Create Website or Application
if (Get-Website -Name $SiteName -ErrorAction SilentlyContinue) {
    Write-Host "🔄 Aggiornamento sito esistente..." -ForegroundColor Yellow
    Set-Website -Name $SiteName -PhysicalPath $DeployPath -ApplicationPool $AppPoolName
} else {
    Write-Host "🌐 Creazione nuovo sito..." -ForegroundColor Yellow
    New-Website -Name $SiteName -PhysicalPath $DeployPath -ApplicationPool $AppPoolName -Port 80
}

# Configurazione permessi
Write-Host "🔐 Configurazione permessi..." -ForegroundColor Yellow
$acl = Get-Acl $DeployPath
$appPoolIdentity = "IIS AppPool\$AppPoolName"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($appPoolIdentity, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($accessRule)
Set-Acl -Path $DeployPath -AclObject $acl

# Create logs directory
$logsPath = Join-Path $DeployPath "logs"
if (!(Test-Path $logsPath)) {
    New-Item -ItemType Directory -Path $logsPath -Force
}

# 8. Start Services
Write-Host "🚀 Avvio servizi..." -ForegroundColor Yellow
Start-WebAppPool -Name $AppPoolName
Start-Website -Name $SiteName

# 9. Final Tests
Write-Host "🧪 Test finale..." -ForegroundColor Yellow

Start-Sleep -Seconds 5

try {
    $testUrl = "http://localhost/pratiche-pareri/"
    $response = Invoke-WebRequest -Uri $testUrl -TimeoutSec 10 -UseBasicParsing
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Applicazione raggiungibile!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Status Code: $($response.StatusCode)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠️  Test di connessione fallito: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host "Controlla i log in: $logsPath\django.log" -ForegroundColor Cyan
}

# 10. Summary
Write-Host ""
Write-Host "🎉 DEPLOYMENT COMPLETATO!" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green
Write-Host "🌐 URL Principale: http://$ServerIP/pratiche-pareri/" -ForegroundColor Cyan
Write-Host "📊 Admin Interface: http://$ServerIP/pratiche-pareri/admin/" -ForegroundColor Cyan
Write-Host "📁 Path Deployment: $DeployPath" -ForegroundColor Cyan
Write-Host "📝 Log Files: $logsPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Prossimi passi:" -ForegroundColor Yellow
Write-Host "1. Configura DNS/IP per raggiungere il server" -ForegroundColor White
Write-Host "2. Crea superuser: cd $DeployPath && uv run python src/manage.py createsuperuser --settings=home.settings.prod" -ForegroundColor White
Write-Host "3. Configura backup automatico database" -ForegroundColor White
Write-Host "4. Setup monitoraggio e logging" -ForegroundColor White
Write-Host ""
Write-Host "🔄 Per aggiornamenti futuri usa: .\production-deploy.ps1 -UpdateOnly" -ForegroundColor Cyan

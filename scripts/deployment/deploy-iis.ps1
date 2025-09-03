# Script di deployment per IIS
# deploy-iis.ps1

param(
    [string]$ServerIP = "192.168.1.100",  # Modifica con il tuo IP
    [string]$SiteName = "GestionePareri",
    [string]$AppPoolName = "GestionePareriPool",
    [string]$DeployPath = "C:\inetpub\wwwroot\pratiche-pareri",
    [string]$PythonPath = "D:\Python\python.exe"
)

Write-Host "🚀 Deployment IIS per Gestione Pareri" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green

# 1. Crea directory di deployment
Write-Host "📁 Creazione directory di deployment..." -ForegroundColor Yellow
if (Test-Path $DeployPath) {
    Write-Host "⚠️  Directory già esistente, backup..." -ForegroundColor Yellow
    $backupPath = "${DeployPath}_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Move-Item $DeployPath $backupPath
}
New-Item -ItemType Directory -Force -Path $DeployPath | Out-Null
New-Item -ItemType Directory -Force -Path "$DeployPath\logs" | Out-Null

# 2. Copia file progetto
Write-Host "📦 Copia file progetto..." -ForegroundColor Yellow
Copy-Item -Path "src\*" -Destination $DeployPath -Recurse -Force

# Crea web.config da template (se non esiste)
if (!(Test-Path "$DeployPath\web.config")) {
    if (Test-Path "web.config.template") {
        Copy-Item -Path "web.config.template" -Destination "$DeployPath\web.config" -Force
        Write-Host "⚠️  File web.config creato da template - CONFIGURA LE VARIABILI REALI!" -ForegroundColor Yellow
    } else {
        Write-Host "❌ Template web.config.template non trovato!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✅ File web.config già presente" -ForegroundColor Green
}

Copy-Item -Path "requirements.txt" -Destination $DeployPath -Force -ErrorAction SilentlyContinue
Copy-Item -Path "pyproject.toml" -Destination $DeployPath -Force
Copy-Item -Path "uv.lock" -Destination $DeployPath -Force

# 3. Installa dipendenze Python
Write-Host "🐍 Installazione dipendenze Python..." -ForegroundColor Yellow
Set-Location $DeployPath
if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv pip install -r pyproject.toml --system
} else {
    & $PythonPath -m pip install -e .
}

# 4. Colletta file statici
Write-Host "🎨 Raccolta file statici..." -ForegroundColor Yellow
$env:DJANGO_SETTINGS_MODULE = "home.settings.prod"
$env:DJANGO_DATABASE_URL = "postgresql://gestione_pareri_user:SecurePass123@localhost:5432/gestione_pareri_prod"
$env:DJANGO_SECRET_KEY = "your-secret-key-here"
$env:DJANGO_DEBUG = "False"
$env:DJANGO_ALLOWED_HOSTS = $ServerIP
$env:DJANGO_CSRF_TRUSTED_ORIGINS = "http://$ServerIP"
$env:DJANGO_FORCE_SCRIPT_NAME = "/pratiche-pareri"

uv run manage.py collectstatic --noinput --settings=home.settings.prod

# 5. Migra database
Write-Host "🗃️  Migrazione database..." -ForegroundColor Yellow
uv run manage.py migrate --settings=home.settings.prod

# 6. Crea Application Pool
Write-Host "⚙️  Configurazione IIS..." -ForegroundColor Yellow
Import-Module WebAdministration

if (Get-IISAppPool -Name $AppPoolName -ErrorAction SilentlyContinue) {
    Write-Host "♻️  Rimozione Application Pool esistente..." -ForegroundColor Yellow
    Remove-WebAppPool -Name $AppPoolName
}

Write-Host "🏗️  Creazione nuovo Application Pool..." -ForegroundColor Yellow
New-WebAppPool -Name $AppPoolName
Set-ItemProperty -Path "IIS:\AppPools\$AppPoolName" -Name "processModel.identityType" -Value "ApplicationPoolIdentity"
Set-ItemProperty -Path "IIS:\AppPools\$AppPoolName" -Name "enable32BitAppOnWin64" -Value $false

# 7. Crea/Aggiorna sito web
if (Get-Website -Name $SiteName -ErrorAction SilentlyContinue) {
    Write-Host "🔄 Aggiornamento sito esistente..." -ForegroundColor Yellow
    Set-Website -Name $SiteName -PhysicalPath $DeployPath
} else {
    Write-Host "🌐 Creazione nuovo sito..." -ForegroundColor Yellow
    New-Website -Name $SiteName -PhysicalPath $DeployPath -ApplicationPool $AppPoolName -Port 80
}

# 8. Configura Application per subpath
if (Get-WebApplication -Site $SiteName -Name "pratiche-pareri" -ErrorAction SilentlyContinue) {
    Write-Host "🔄 Rimozione applicazione esistente..." -ForegroundColor Yellow
    Remove-WebApplication -Site $SiteName -Name "pratiche-pareri"
}

Write-Host "📱 Creazione applicazione per subpath..." -ForegroundColor Yellow
New-WebApplication -Site $SiteName -Name "pratiche-pareri" -PhysicalPath $DeployPath -ApplicationPool $AppPoolName

# 9. Configura permessi
Write-Host "🔐 Configurazione permessi..." -ForegroundColor Yellow
$acl = Get-Acl $DeployPath
$appPoolSid = (New-Object System.Security.Principal.SecurityIdentifier("S-1-5-82")).Translate([System.Security.Principal.NTAccount])
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($appPoolSid, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($accessRule)
Set-Acl -Path $DeployPath -AclObject $acl

# 10. Avvia Application Pool e sito
Write-Host "🚀 Avvio servizi..." -ForegroundColor Yellow
Start-WebAppPool -Name $AppPoolName
Start-Website -Name $SiteName

Write-Host "✅ Deployment completato!" -ForegroundColor Green
Write-Host "🌐 URL: http://$ServerIP/pratiche-pareri/" -ForegroundColor Cyan
Write-Host "📊 Admin: http://$ServerIP/pratiche-pareri/admin/" -ForegroundColor Cyan

# Test di connessione
Write-Host "🔍 Test di connessione..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$ServerIP/pratiche-pareri/" -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Sito raggiungibile!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Status Code: $($response.StatusCode)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Errore di connessione: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "📝 Controlla i log in: $DeployPath\logs\django.log" -ForegroundColor Cyan
}

Write-Host "`n📋 Prossimi passi:" -ForegroundColor Cyan
Write-Host "1. Aggiorna le variabili d'ambiente in web.config con i tuoi valori reali" -ForegroundColor White
Write-Host "2. Configura il database PostgreSQL" -ForegroundColor White
Write-Host "3. Crea un superuser: python manage.py createsuperuser --settings=home.settings.prod" -ForegroundColor White
Write-Host "4. Testa l'accesso all'admin Django" -ForegroundColor White

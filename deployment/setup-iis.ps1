# Script configurazione IIS per Gestione Pareri
# Eseguire come Amministratore

param(
    [string]$SiteName = "GestionePareri",
    [string]$DomainName = "gestione-pareri.local",
    [string]$Port = "80",
    [string]$ProjectPath = "E:\progetti\gestione-pareri"
)

Write-Host "🏢 Configurazione IIS per Gestione Pareri..." -ForegroundColor Cyan

# Verifica se IIS è installato
$iisFeature = Get-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
if ($iisFeature.State -ne "Enabled") {
    Write-Host "❌ IIS non è installato. Installalo prima di eseguire questo script." -ForegroundColor Red
    exit 1
}

# Importa modulo WebAdministration
Import-Module WebAdministration

try {
    # Crea Application Pool dedicato
    Write-Host "📦 Creazione Application Pool '$SiteName'..." -ForegroundColor Yellow
    New-WebAppPool -Name $SiteName -Force
    Set-ItemProperty -Path "IIS:\AppPools\$SiteName" -Name processModel.identityType -Value ApplicationPoolIdentity
    Set-ItemProperty -Path "IIS:\AppPools\$SiteName" -Name recycling.periodicRestart.time -Value "00:00:00"

    # Crea il sito web
    Write-Host "🌐 Creazione sito web '$SiteName'..." -ForegroundColor Yellow
    $sitePath = "$ProjectPath\staticfiles"
    New-Website -Name $SiteName -Port $Port -PhysicalPath $sitePath -ApplicationPool $SiteName -Force

    # Configura binding per dominio personalizzato
    Write-Host "🔗 Configurazione binding per '$DomainName'..." -ForegroundColor Yellow
    New-WebBinding -Name $SiteName -Protocol http -Port $Port -HostHeader $DomainName

    # Copia web.config
    Write-Host "⚙️ Copia configurazione web.config..." -ForegroundColor Yellow
    Copy-Item "$ProjectPath\deployment\web.config" -Destination "$sitePath\web.config" -Force

    # Configura permissions
    Write-Host "🔐 Configurazione permessi..." -ForegroundColor Yellow
    $acl = Get-Acl $sitePath
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
    $acl.SetAccessRule($accessRule)
    Set-Acl $sitePath $acl

    # Installa URL Rewrite se non presente
    Write-Host "🔄 Verifica URL Rewrite Module..." -ForegroundColor Yellow
    $urlRewrite = Get-WebGlobalModule | Where-Object { $_.Name -eq "RewriteModule" }
    if (-not $urlRewrite) {
        Write-Host "⚠️  URL Rewrite Module non trovato. Scaricalo da:" -ForegroundColor Yellow
        Write-Host "   https://www.iis.net/downloads/microsoft/url-rewrite" -ForegroundColor White
    }

    Write-Host "✅ Configurazione IIS completata!" -ForegroundColor Green
    Write-Host "🌐 Sito accessibile su: http://$DomainName" -ForegroundColor Green
    Write-Host "" -ForegroundColor White
    Write-Host "📋 PROSSIMI PASSI:" -ForegroundColor Cyan
    Write-Host "1. Aggiungi '$DomainName' al file hosts (C:\Windows\System32\drivers\etc\hosts):" -ForegroundColor White
    Write-Host "   127.0.0.1    $DomainName" -ForegroundColor Gray
    Write-Host "2. Avvia Django: just run-uvicorn" -ForegroundColor White
    Write-Host "3. Visita: http://$DomainName" -ForegroundColor White

} catch {
    Write-Host "❌ Errore durante la configurazione: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

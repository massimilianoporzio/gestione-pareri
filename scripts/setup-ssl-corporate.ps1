# Script completo per configurare SSL in ambiente aziendale
# Supporta uv, pre-commit, Python, Node.js e npm
Write-Host "🏢 Configurazione SSL per ambiente aziendale completa..." -ForegroundColor Cyan

$proxy = "proxy.reteunitaria.piemonte.it:3128"

Write-Host "1/10 - Configurazione uv per SSL..." -ForegroundColor Yellow
# Configurazione uv per SSL insicuro
$env:UV_INSECURE_HOST = "pypi.org,files.pythonhosted.org,github.com,raw.githubusercontent.com"
$env:UV_NATIVE_TLS = "true"
$env:UV_NO_VERIFY_SSL = "true"

Write-Host "2/10 - Configurazione Python SSL..." -ForegroundColor Yellow
# Configurazione Python per SSL
$env:PYTHONHTTPSVERIFY = "0"
$env:REQUESTS_CA_BUNDLE = ""
$env:CURL_CA_BUNDLE = ""

Write-Host "3/10 - Configurazione proxy globale..." -ForegroundColor Yellow
# Proxy per HTTP/HTTPS
$env:HTTP_PROXY = "http://$proxy"
$env:HTTPS_PROXY = "http://$proxy"
$env:http_proxy = "http://$proxy"
$env:https_proxy = "http://$proxy"

Write-Host "4/10 - Configurazione pip..." -ForegroundColor Yellow
# Configurazione pip
$pipDir = "$env:APPDATA\pip"
if (!(Test-Path $pipDir)) {
    New-Item -ItemType Directory -Path $pipDir -Force
}

$pipConfig = @"
[global]
trusted-host = pypi.org
               pypi.python.org
               files.pythonhosted.org
               github.com
               raw.githubusercontent.com
cert =
proxy = http://$proxy
"@

$pipConfig | Out-File -FilePath "$pipDir\pip.conf" -Encoding UTF8 -Force

Write-Host "5/10 - Configurazione Node.js HTTPS..." -ForegroundColor Yellow
# Configurazione Node.js per SSL
$env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
$env:NODEJS_CHECK_SIGNATURES = "no"

# Disabilita controllo SSL per nodeenv specificamente
$env:NODEENV_SKIP_SSL_CHECK = "1"

Write-Host "6/10 - Configurazione npm..." -ForegroundColor Yellow
# Configurazione npm
npm config set registry https://registry.npmjs.org/ --location=global 2>$null
npm config set strict-ssl false --location=global 2>$null
npm config set proxy http://$proxy --location=global 2>$null
npm config set https-proxy http://$proxy --location=global 2>$null

Write-Host "7/10 - Configurazione Git per certificati..." -ForegroundColor Yellow
# Git per SSL
git config --global http.sslVerify false 2>$null
git config --global https.sslVerify false 2>$null

Write-Host "8/10 - Configurazione nodeenv specifica..." -ForegroundColor Yellow
# Configurazione per nodeenv (usato da pre-commit per installare Node.js)
$env:NODEENV_CURL_OPTIONS = "--insecure --proxy $proxy"

# Crea un wrapper per urllib che ignora SSL
$pythonSslPatch = @"
import ssl
import urllib.request
import os

# Patch urllib per ignorare certificati SSL
original_urlopen = urllib.request.urlopen

def patched_urlopen(url, *args, **kwargs):
    if hasattr(ssl, '_create_unverified_context'):
        kwargs['context'] = ssl._create_unverified_context()
    return original_urlopen(url, *args, **kwargs)

urllib.request.urlopen = patched_urlopen

# Configura requests se disponibile
try:
    import requests
    from requests.packages.urllib3.exceptions import InsecureRequestWarning
    requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
    requests.packages.urllib3.util.ssl_.DEFAULT_CIPHERS += ':HIGH:!DH:!aNULL'
except:
    pass
"@

$sitePackagesPath = & uv run python -c "import site; print(site.getsitepackages()[0])" 2>$null
if ($sitePackagesPath) {
    $pthFile = Join-Path $sitePackagesPath "ssl_patch.pth"
    "import ssl_patch" | Out-File -FilePath $pthFile -Encoding UTF8 -Force

    $patchFile = Join-Path $sitePackagesPath "ssl_patch.py"
    $pythonSslPatch | Out-File -FilePath $patchFile -Encoding UTF8 -Force
}

Write-Host "9/10 - Creazione script di avvio per pre-commit..." -ForegroundColor Yellow
# Script wrapper per pre-commit che configura tutte le variabili
$precommitWrapper = @"
@echo off
REM Wrapper per pre-commit con configurazione SSL aziendale

set UV_INSECURE_HOST=pypi.org,files.pythonhosted.org,github.com,raw.githubusercontent.com
set UV_NATIVE_TLS=true
set UV_NO_VERIFY_SSL=true
set PYTHONHTTPSVERIFY=0
set REQUESTS_CA_BUNDLE=
set CURL_CA_BUNDLE=
set NODE_TLS_REJECT_UNAUTHORIZED=0
set NODEJS_CHECK_SIGNATURES=no
set NODEENV_SKIP_SSL_CHECK=1
set HTTP_PROXY=http://$proxy
set HTTPS_PROXY=http://$proxy
set http_proxy=http://$proxy
set https_proxy=http://$proxy

REM Avvia pre-commit con tutte le configurazioni
pre-commit %*
"@

$precommitWrapper | Out-File -FilePath "scripts\pre-commit-corporate.bat" -Encoding ASCII -Force

Write-Host "10/10 - Test configurazione..." -ForegroundColor Yellow
# Test della configurazione
Write-Host "Testing Python SSL..." -ForegroundColor Gray
try {
    & uv run python -c "import urllib.request; urllib.request.urlopen('https://pypi.org', timeout=5); print('✅ Python SSL OK')"
} catch {
    Write-Host "⚠️  Python SSL test failed - proceeding anyway" -ForegroundColor Yellow
}

Write-Host "Testing Node.js availability..." -ForegroundColor Gray
if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Host "✅ Node.js found: $(node --version)" -ForegroundColor Green
} else {
    Write-Host "⚠️  Node.js non trovato - pre-commit lo installerà automaticamente" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 Configurazione SSL completa completata!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Per usare pre-commit in ambiente aziendale:" -ForegroundColor Cyan
Write-Host "   1. Usa: .\scripts\pre-commit-corporate.bat run --all-files" -ForegroundColor White
Write-Host "   2. Oppure: make quality-corporate (fallback senza Node.js)" -ForegroundColor White
Write-Host ""
Write-Host "🔧 Le seguenti configurazioni sono attive:" -ForegroundColor Yellow
Write-Host "   - SSL verification disabilitata per Python/pip/uv" -ForegroundColor White
Write-Host "   - Proxy aziendale configurato" -ForegroundColor White
Write-Host "   - Node.js/npm SSL disabilitato" -ForegroundColor White
Write-Host "   - nodeenv SSL bypass attivato" -ForegroundColor White
Write-Host ""

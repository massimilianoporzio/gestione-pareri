# Script per configurare pre-commit in ambiente aziendale con proxy/firewall
# Configurazione SSL e proxy per pre-commit

Write-Host "Configurazione ambiente aziendale per pre-commit..." -ForegroundColor Cyan

# 1. Configurazione variabili di ambiente SSL
$env:PYTHONHTTPSVERIFY = "0"
$env:SSL_VERIFY = "false"
$env:CURL_CA_BUNDLE = ""
$env:REQUESTS_CA_BUNDLE = ""

# 2. Configurazione proxy (se disponibile)
$proxyServer = "http://proxy.reteunitaria.piemonte.it:3128"
$env:HTTP_PROXY = $proxyServer
$env:HTTPS_PROXY = $proxyServer
$env:NO_PROXY = "localhost,127.0.0.1"

# 3. Configurazione pip per ignorare SSL
pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"

# 4. Configurazione npm per ignorare SSL
npm config set strict-ssl false
npm config set registry http://registry.npmjs.org/
npm config set proxy $proxyServer
npm config set https-proxy $proxyServer

Write-Host "Configurazione completata!" -ForegroundColor Green
Write-Host "Prova ora pre-commit run --all-files" -ForegroundColor Yellow

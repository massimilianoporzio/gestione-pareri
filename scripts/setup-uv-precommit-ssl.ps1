# Script per configurare pre-commit con uv in ambiente aziendale
# Configurazione SSL e proxy per pre-commit + uv

Write-Host "Configurazione pre-commit con uv per ambiente aziendale..." -ForegroundColor Cyan

# 1. Configurazione variabili di ambiente SSL per Python/urllib
$env:PYTHONHTTPSVERIFY = "0"
$env:SSL_VERIFY = "false" 
$env:CURL_CA_BUNDLE = ""
$env:REQUESTS_CA_BUNDLE = ""

# 2. Configurazione proxy aziendale
$proxyServer = "http://proxy.reteunitaria.piemonte.it:3128"
$env:HTTP_PROXY = $proxyServer
$env:HTTPS_PROXY = $proxyServer
$env:NO_PROXY = "localhost,127.0.0.1"

# 3. Configurazione uv per SSL
$env:UV_INSECURE_HOST = "pypi.org,files.pythonhosted.org,pypi.python.org,registry.npmjs.org,nodejs.org"
$env:UV_NATIVE_TLS = "1"
$env:UV_HTTP_TIMEOUT = "60"

# 4. Configurazione pip globale per SSL
pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"

# 5. Configurazione npm per SSL (per gli hook che usano Node.js)
npm config set strict-ssl false 2>$null
npm config set registry http://registry.npmjs.org/ 2>$null

Write-Host "Configurazione SSL completata per uv + pre-commit!" -ForegroundColor Green
Write-Host "Prova ora: pre-commit run --all-files" -ForegroundColor Yellow

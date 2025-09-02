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
set HTTP_PROXY=http://proxy.reteunitaria.piemonte.it:3128
set HTTPS_PROXY=http://proxy.reteunitaria.piemonte.it:3128
set http_proxy=http://proxy.reteunitaria.piemonte.it:3128
set https_proxy=http://proxy.reteunitaria.piemonte.it:3128

REM Avvia pre-commit con tutte le configurazioni
pre-commit %*

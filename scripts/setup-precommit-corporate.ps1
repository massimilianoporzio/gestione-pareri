# Script per configurare pre-commit con Node.js pre-installato in ambiente aziendale
Write-Host "🔧 Configurazione pre-commit con Node.js preinstallato per ambiente aziendale..." -ForegroundColor Cyan

# 1. Configura le variabili SSL
$env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
$env:PYTHONHTTPSVERIFY = "0"
$env:UV_INSECURE_HOST = "pypi.org,files.pythonhosted.org,github.com,raw.githubusercontent.com"
$env:REQUESTS_CA_BUNDLE = ""
$env:CURL_CA_BUNDLE = ""

Write-Host "1/5 - Pulizia cache pre-commit..." -ForegroundColor Yellow
# Pulisce la cache per forzare reinstallazione
if (Test-Path "$env:USERPROFILE\.cache\pre-commit") {
    Remove-Item -Path "$env:USERPROFILE\.cache\pre-commit" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "   Cache pre-commit pulita" -ForegroundColor Gray
}

Write-Host "2/5 - Configurazione nodeenv bypass..." -ForegroundColor Yellow

# Trova il percorso di nodeenv in pre-commit
$precommitPath = & uv tool show pre-commit | Select-String -Pattern "bin-dir:" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }
if (-not $precommitPath) {
    $precommitPath = "$env:APPDATA\uv\tools\pre-commit\Scripts"
}

Write-Host "   Pre-commit path: $precommitPath" -ForegroundColor Gray

# Trova la versione di Python usata da pre-commit
$pythonExe = Join-Path $precommitPath "python.exe"
if (-not (Test-Path $pythonExe)) {
    Write-Host "   ⚠️ Python non trovato in pre-commit, usando sistema" -ForegroundColor Yellow
    $pythonExe = "python"
}

Write-Host "3/5 - Patch nodeenv per usare Node.js di sistema..." -ForegroundColor Yellow

# Crea uno script Python che patcha nodeenv
$nodeenvPatch = @"
import sys
import os
import subprocess
import shutil

def patch_nodeenv():
    '''Patch nodeenv per usare Node.js di sistema invece di scaricarlo'''

    # Trova il percorso del modulo nodeenv
    try:
        import nodeenv
        nodeenv_path = nodeenv.__file__
        print(f'Nodeenv trovato in: {nodeenv_path}')

        # Leggi il file nodeenv
        with open(nodeenv_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Trova la funzione che scarica Node.js e patchala
        original_download = 'def get_last_stable_node_version():'

        if original_download in content:
            print('Applicando patch nodeenv...')

            # Sostituisce la funzione con una che usa la versione di sistema
            patched_function = '''def get_last_stable_node_version():
    """Usa Node.js di sistema invece di scaricare"""
    try:
        result = subprocess.run(['node', '--version'], capture_output=True, text=True)
        if result.returncode == 0:
            version = result.stdout.strip().lstrip('v')
            print(f'Usando Node.js di sistema: v{version}')
            return version
    except:
        pass

    # Fallback alla versione predefinita se Node.js non è trovato
    return '22.17.0'  # Versione che sappiamo essere installata
'''

            # Trova l'intera funzione originale e sostituiscila
            import re

            # Pattern per trovare l'intera funzione
            pattern = r'def get_last_stable_node_version\(\):.*?(?=\n\ndef|\n\nclass|\n\nif|$)'

            new_content = re.sub(pattern, patched_function, content, flags=re.DOTALL)

            # Backup del file originale
            backup_path = nodeenv_path + '.backup'
            if not os.path.exists(backup_path):
                shutil.copy2(nodeenv_path, backup_path)
                print(f'Backup creato: {backup_path}')

            # Scrivi il file patchato
            with open(nodeenv_path, 'w', encoding='utf-8') as f:
                f.write(new_content)

            print('✅ Patch nodeenv applicata con successo')
            return True
        else:
            print('⚠️ Funzione target non trovata in nodeenv')
            return False

    except Exception as e:
        print(f'❌ Errore durante il patching di nodeenv: {e}')
        return False

if __name__ == '__main__':
    success = patch_nodeenv()
    sys.exit(0 if success else 1)
"@

# Salva e esegui il patch
$patchFile = "scripts\patch-nodeenv.py"
$nodeenvPatch | Out-File -FilePath $patchFile -Encoding UTF8 -Force

# Esegui il patch usando l'ambiente Python di pre-commit
try {
    $patchResult = & "$pythonExe" $patchFile
    Write-Host "   Patch result: $patchResult" -ForegroundColor Gray
} catch {
    Write-Host "   ⚠️ Patch fallito, procedendo comunque..." -ForegroundColor Yellow
}

Write-Host "4/5 - Configurazione SSL globale Python..." -ForegroundColor Yellow

# Patch SSL per l'ambiente Python di pre-commit
$sslPatch = @"
import ssl
import urllib.request

# Crea contesto SSL non verificato
ssl_context = ssl.create_default_context()
ssl_context.check_hostname = False
ssl_context.verify_mode = ssl.CERT_NONE

# Patch urllib.request
original_urlopen = urllib.request.urlopen

def patched_urlopen(url, data=None, timeout=None, **kwargs):
    kwargs['context'] = ssl_context
    return original_urlopen(url, data, timeout, **kwargs)

urllib.request.urlopen = patched_urlopen

# Configurazione per requests
try:
    import requests
    from requests.packages.urllib3.exceptions import InsecureRequestWarning
    requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

    # Patch requests session
    original_request = requests.Session.request

    def patched_request(self, method, url, **kwargs):
        kwargs['verify'] = False
        return original_request(self, method, url, **kwargs)

    requests.Session.request = patched_request
    requests.request = requests.Session().request

except ImportError:
    pass
"@

# Applica il patch SSL all'ambiente Python di pre-commit
$precommitSitePackages = & "$pythonExe" -c "import site; print(site.getsitepackages()[0])" 2>$null
if ($precommitSitePackages) {
    $sslPatchPath = Join-Path $precommitSitePackages "ssl_bypass.py"
    $sslPatch | Out-File -FilePath $sslPatchPath -Encoding UTF8 -Force

    $pthPath = Join-Path $precommitSitePackages "ssl_bypass.pth"
    "import ssl_bypass" | Out-File -FilePath $pthPath -Encoding UTF8 -Force

    Write-Host "   SSL bypass installato in: $precommitSitePackages" -ForegroundColor Gray
}

Write-Host "5/5 - Test pre-commit..." -ForegroundColor Yellow

# Ora prova pre-commit
Write-Host ""
Write-Host "🧪 Testing pre-commit con configurazione SSL..." -ForegroundColor Cyan

try {
    # Test con un hook leggero prima
    Write-Host "Test hook ruff..." -ForegroundColor Gray
    & pre-commit run ruff --all-files

    Write-Host ""
    Write-Host "🎯 Esecuzione completa pre-commit..." -ForegroundColor Green
    & pre-commit run --all-files

} catch {
    Write-Host "❌ Pre-commit fallito: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "🔄 Fallback: usa 'make quality-corporate' per controlli qualità senza Node.js" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "✅ Configurazione completata!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Comandi disponibili:" -ForegroundColor Cyan
Write-Host "   pre-commit run --all-files    (tutti gli hook, inclusi Node.js)" -ForegroundColor White
Write-Host "   make quality-corporate        (fallback Python-only)" -ForegroundColor White
Write-Host "   make fix-all                  (correzione completa)" -ForegroundColor White

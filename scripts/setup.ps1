# Script di setup del progetto per Windows
# Eseguire con PowerShell

# Funzione per verificare se un comando esiste
function Test-Command {
    param (
        [string]$Command
    )
    return [bool](Get-Command -Name $Command -ErrorAction SilentlyContinue)
}

Write-Host "Setup progetto Django in corso..." -ForegroundColor Blue

# Verifica Python
if (-not (Test-Command -Command "python")) {
    Write-Host "Python 3 non è installato. Per favore, installalo prima di continuare." -ForegroundColor Red
    exit 1
}

# Verifica uv
$useUv = $true
if (-not (Test-Command -Command "uv")) {
    Write-Host "uv non è installato. Si consiglia di installarlo per una gestione pacchetti più veloce." -ForegroundColor Red
    Write-Host "Installazione con: Invoke-WebRequest -Uri https://astral.sh/uv/install.ps1 -UseBasicParsing | Invoke-Expression" -ForegroundColor Blue

    $response = Read-Host "Vuoi installare uv adesso? (s/n)"
    if ($response -eq "s") {
        Invoke-WebRequest -Uri https://astral.sh/uv/install.ps1 -UseBasicParsing | Invoke-Expression
    } else {
        Write-Host "Utilizzerò pip invece di uv." -ForegroundColor Blue
        $useUv = $false
    }
}

# Creazione ambiente virtuale
Write-Host "Creazione ambiente virtuale..." -ForegroundColor Blue
if ($useUv) {
    uv venv
} else {
    python -m venv .venv
}

# Attivazione ambiente virtuale
Write-Host "Attivazione ambiente virtuale..." -ForegroundColor Blue
. .\.venv\Scripts\Activate.ps1

# Installazione dipendenze
Write-Host "Installazione dipendenze..." -ForegroundColor Blue
if ($useUv) {
    uv sync
} else {
    pip install -r requirements.txt
}

# Installazione pre-commit
Write-Host "Configurazione pre-commit..." -ForegroundColor Blue
if ($useUv) {
    uv add pre-commit
} else {
    pip install pre-commit
}
pre-commit install

# Configurazione file .env
if (-not (Test-Path -Path ".env")) {
    Write-Host "Creazione file .env..." -ForegroundColor Blue
    Copy-Item -Path ".env.example" -Destination ".env"
    Write-Host "File .env creato. Modifica i valori secondo le tue esigenze." -ForegroundColor Green
}

# Installazione strumenti Markdown
if (Test-Command -Command "npm") {
    Write-Host "Installazione strumenti di formattazione Markdown..." -ForegroundColor Blue
    & .\scripts\install-markdown-tools.ps1
} else {
    Write-Host "npm non è installato. Gli strumenti di formattazione Markdown non saranno installati." -ForegroundColor Red
    Write-Host "Per installarli manualmente in seguito, esegui: .\scripts\install-markdown-tools.ps1" -ForegroundColor Blue
}

Write-Host "Setup completato con successo!" -ForegroundColor Green
Write-Host "Per avviare il server di sviluppo: cd src && python manage.py runserver" -ForegroundColor Blue

#!/usr/bin/env pwsh
# Script per installare Make su Windows

$chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue
$scoopInstalled = Get-Command scoop -ErrorAction SilentlyContinue
$makeInstalled = Get-Command make -ErrorAction SilentlyContinue

# Controlla se Make è già installato
if ($makeInstalled) {
    Write-Host "✅ Make è già installato" -ForegroundColor Green
    exit 0
}

# Determina il metodo di installazione
if ($chocoInstalled) {
    Write-Host "📦 Installazione di Make utilizzando Chocolatey..." -ForegroundColor Cyan
    choco install make -y
} elseif ($scoopInstalled) {
    Write-Host "📦 Installazione di Make utilizzando Scoop..." -ForegroundColor Cyan
    scoop install make
} else {
    Write-Host "❓ Nessun package manager trovato (Chocolatey o Scoop)" -ForegroundColor Yellow

    $installChoco = Read-Host "Vuoi installare Chocolatey? (s/n)"
    if ($installChoco -eq "s") {
        Write-Host "📦 Installazione di Chocolatey..." -ForegroundColor Cyan
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

        Write-Host "📦 Installazione di Make..." -ForegroundColor Cyan
        choco install make -y
    } else {
        Write-Host "❌ Installazione di Make annullata. Puoi installare Make manualmente." -ForegroundColor Red
        Write-Host "   Per istruzioni, visita: https://chocolatey.org/install" -ForegroundColor Red
        exit 1
    }
}

# Verifica che l'installazione sia riuscita
$makeInstalled = Get-Command make -ErrorAction SilentlyContinue
if ($makeInstalled) {
    Write-Host "✅ Make è stato installato con successo!" -ForegroundColor Green
    Write-Host "   Versione installata: $(make --version | Select-Object -First 1)" -ForegroundColor Green
} else {
    Write-Host "❌ L'installazione di Make non è riuscita. Riprova o installa manualmente." -ForegroundColor Red
    exit 1
}

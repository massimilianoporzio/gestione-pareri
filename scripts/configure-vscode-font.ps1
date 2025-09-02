#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Configura il font del terminale di VS Code per supportare Oh My Posh.

.DESCRIPTION
    Questo script configura le impostazioni di VS Code per utilizzare
    un Nerd Font nel terminale integrato, necessario per visualizzare
    correttamente le icone di Oh My Posh.

.NOTES
    Font supportati disponibili:
    - FiraCode Nerd Font Mono  
    - CaskaydiaCove Nerd Font Mono
    - Consolas (fallback senza icone)
#>

param(
    [string]$FontName = "FiraCode Nerd Font Mono",
    [int]$FontSize = 14
)

# Colori per output
$Green = "`e[32m"
$Yellow = "`e[33m" 
$Red = "`e[31m"
$Reset = "`e[0m"

Write-Host "${Green}🔤 Configurazione Font VS Code per Oh My Posh${Reset}" -ForegroundColor Green
Write-Host "Font: $FontName (dimensione: $FontSize)" -ForegroundColor Cyan

# Trova il percorso delle impostazioni utente di VS Code
$vscodePaths = @(
    "$env:APPDATA\Code\User\settings.json",
    "$env:APPDATA\Code - Insiders\User\settings.json"
)

$settingsPath = $null
foreach ($path in $vscodePaths) {
    if (Test-Path (Split-Path $path -Parent)) {
        $settingsPath = $path
        Write-Host "📁 Percorso settings VS Code: $settingsPath" -ForegroundColor Cyan
        break
    }
}

if (-not $settingsPath) {
    Write-Host "${Red}❌ Non riesco a trovare la cartella delle impostazioni di VS Code${Reset}" -ForegroundColor Red
    Write-Host "Percorsi cercati:" -ForegroundColor Yellow
    foreach ($path in $vscodePaths) {
        Write-Host "  - $path" -ForegroundColor Yellow
    }
    exit 1
}

# Crea backup se il file esiste
if (Test-Path $settingsPath) {
    $backupPath = "${settingsPath}.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Copy-Item $settingsPath $backupPath -Force
    Write-Host "💾 Backup creato: $backupPath" -ForegroundColor Yellow
}

# Leggi impostazioni esistenti o crea oggetto vuoto
$settings = @{}
if (Test-Path $settingsPath) {
    try {
        $content = Get-Content $settingsPath -Raw -Encoding UTF8
        if ($content.Trim()) {
            $settings = $content | ConvertFrom-Json -AsHashtable
        }
    }
    catch {
        Write-Host "${Yellow}⚠️ Errore nel leggere il file settings esistente, creo nuovo file${Reset}" -ForegroundColor Yellow
        $settings = @{}
    }
}
else {
    Write-Host "📝 Creo nuovo file settings.json" -ForegroundColor Green
    # Crea la directory se non esiste
    $settingsDir = Split-Path $settingsPath -Parent
    if (-not (Test-Path $settingsDir)) {
        New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null
    }
}

# Aggiungi/aggiorna le impostazioni del terminale
Write-Host "⚙️ Configurazione impostazioni terminale..." -ForegroundColor Green

# Impostazioni del terminale per Oh My Posh
$settings["terminal.integrated.fontFamily"] = $FontName
$settings["terminal.integrated.fontSize"] = $FontSize
$settings["terminal.integrated.fontLigatures"] = $true

# Impostazioni aggiuntive per migliorare la compatibilità
$settings["terminal.integrated.defaultProfile.windows"] = "PowerShell"
$settings["terminal.integrated.profiles.windows"] = @{
    "PowerShell" = @{
        "source" = "PowerShell"
        "icon" = "terminal-powershell"
    }
}

# Converti in JSON e salva
try {
    $jsonSettings = $settings | ConvertTo-Json -Depth 10
    $jsonSettings | Out-File $settingsPath -Encoding UTF8 -Force
    Write-Host "${Green}✅ Impostazioni VS Code aggiornate con successo!${Reset}" -ForegroundColor Green
}
catch {
    Write-Host "${Red}❌ Errore nel salvare le impostazioni: $_${Reset}" -ForegroundColor Red
    exit 1
}

# Mostra le impostazioni applicate
Write-Host "`n📋 Impostazioni applicate:" -ForegroundColor Green
Write-Host "  terminal.integrated.fontFamily: `"$FontName`"" -ForegroundColor Cyan
Write-Host "  terminal.integrated.fontSize: $FontSize" -ForegroundColor Cyan
Write-Host "  terminal.integrated.fontLigatures: true" -ForegroundColor Cyan

Write-Host "`n${Yellow}🔄 Riavvia VS Code per applicare le modifiche${Reset}" -ForegroundColor Yellow

# Verifica font installati
Write-Host "`n🔍 Verifica font installati:" -ForegroundColor Green
$installedFonts = @(
    "FiraCode Nerd Font Mono",
    "CaskaydiaCove Nerd Font Mono", 
    "Cascadia Code",
    "Consolas"
)

foreach ($font in $installedFonts) {
    try {
        $fontRegistry = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" | 
                       Get-Member -MemberType NoteProperty | 
                       Where-Object { $_.Name -like "*$font*" }
        
        if ($fontRegistry) {
            Write-Host "  ✅ $font - Disponibile" -ForegroundColor Green
        }
        else {
            Write-Host "  ❌ $font - Non trovato" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "  ❓ $font - Verifica fallita" -ForegroundColor Yellow
    }
}

Write-Host "`n${Green}🎯 Configurazione completata!${Reset}" -ForegroundColor Green
Write-Host "Per testare Oh My Posh:" -ForegroundColor Yellow
Write-Host "1. Riavvia VS Code" -ForegroundColor Yellow
Write-Host "2. Apri un nuovo terminale integrato (Ctrl+`)" -ForegroundColor Yellow 
Write-Host "3. Verifica che le icone Oh My Posh siano visualizzate correttamente" -ForegroundColor Yellow

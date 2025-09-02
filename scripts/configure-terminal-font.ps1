# Script per configurare automaticamente il font di Windows Terminal per Oh My Posh
Write-Host "🎨 Configurazione font Windows Terminal per Oh My Posh..." -ForegroundColor Cyan

# Percorso del file di configurazione di Windows Terminal
$settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$settingsPathPreview = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"

# Trova quale versione è installata
$configPath = $null
if (Test-Path $settingsPath) {
    $configPath = $settingsPath
    Write-Host "Trovato Windows Terminal (Release)" -ForegroundColor Green
} elseif (Test-Path $settingsPathPreview) {
    $configPath = $settingsPathPreview
    Write-Host "Trovato Windows Terminal (Preview)" -ForegroundColor Green
} else {
    Write-Host "❌ Windows Terminal non trovato!" -ForegroundColor Red
    Write-Host "Installa Windows Terminal da Microsoft Store" -ForegroundColor Yellow
    exit 1
}

Write-Host "📂 Configurazione: $configPath" -ForegroundColor Gray

# Backup della configurazione esistente
$backupPath = "$configPath.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Copy-Item -Path $configPath -Destination $backupPath
Write-Host "💾 Backup creato: $backupPath" -ForegroundColor Yellow

# Leggi la configurazione attuale
try {
    $settings = Get-Content -Path $configPath -Raw | ConvertFrom-Json -Depth 10
    Write-Host "✅ Configurazione caricata" -ForegroundColor Green
} catch {
    Write-Host "❌ Errore lettura configurazione: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Font consigliati per Oh My Posh (in ordine di preferenza)
$preferredFonts = @(
    "FiraCode Nerd Font",
    "FiraCode Nerd Font Mono", 
    "CaskaydiaCove Nerd Font",
    "MesloLGM Nerd Font",
    "Consolas"
)

# Trova il primo font disponibile
$selectedFont = $null
foreach ($font in $preferredFonts) {
    # Testa se il font è disponibile
    try {
        Add-Type -AssemblyName System.Drawing
        $fontFamily = New-Object System.Drawing.FontFamily($font)
        $selectedFont = $font
        Write-Host "✅ Font trovato: $font" -ForegroundColor Green
        break
    } catch {
        Write-Host "⚠️  Font non disponibile: $font" -ForegroundColor Yellow
    }
}

if (-not $selectedFont) {
    Write-Host "❌ Nessun font compatibile trovato!" -ForegroundColor Red
    Write-Host "Installa un Nerd Font da: https://www.nerdfonts.com/" -ForegroundColor Yellow
    exit 1
}

# Configura il font per tutti i profili
$updated = $false

# Aggiorna il profilo di default se esiste
if ($settings.profiles -and $settings.profiles.defaults) {
    if (-not $settings.profiles.defaults.font) {
        $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "font" -Value @{}
    }
    $settings.profiles.defaults.font.face = $selectedFont
    $settings.profiles.defaults.font.size = 11
    Write-Host "✅ Font configurato per profilo default" -ForegroundColor Green
    $updated = $true
}

# Aggiorna tutti i profili individuali
if ($settings.profiles -and $settings.profiles.list) {
    foreach ($profile in $settings.profiles.list) {
        if ($profile.name -match "PowerShell|Command Prompt|pwsh") {
            if (-not $profile.font) {
                $profile | Add-Member -MemberType NoteProperty -Name "font" -Value @{}
            }
            $profile.font.face = $selectedFont
            $profile.font.size = 11
            Write-Host "✅ Font configurato per profilo: $($profile.name)" -ForegroundColor Green
            $updated = $true
        }
    }
}

if ($updated) {
    # Salva la configurazione aggiornata
    $settings | ConvertTo-Json -Depth 10 | Set-Content -Path $configPath -Encoding UTF8
    Write-Host "💾 Configurazione salvata!" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "🎉 Configurazione completata!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Prossimi passi:" -ForegroundColor Cyan
    Write-Host "1. Riavvia Windows Terminal" -ForegroundColor White
    Write-Host "2. Le icone Oh My Posh dovrebbero ora essere visualizzate correttamente" -ForegroundColor White
    Write-Host "3. Se vedi ancora problemi, prova: oh-my-posh font install CascadiaCode" -ForegroundColor White
    
    Write-Host ""
    Write-Host "🔤 Font configurato: $selectedFont" -ForegroundColor Yellow
    Write-Host "📂 Backup disponibile: $backupPath" -ForegroundColor Gray
} else {
    Write-Host "⚠️  Nessun profilo PowerShell trovato da aggiornare" -ForegroundColor Yellow
    Write-Host "Configura manualmente il font nelle impostazioni di Windows Terminal" -ForegroundColor White
}

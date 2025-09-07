# IIS Reverse Proxy per Django

## 🎯 Overview

[![IIS](https://img.shields.io/badge/IIS-Windows%20Server-blue)](https://www.iis.net/)
[![Django](https://img.shields.io/badge/Django-5.2.0-green.svg)](https://www.djangoproject.com/) Questa guida spiega
come configurare **IIS (Internet Information Services)** come reverse proxy per Django in ambienti Windows Server o
intranet aziendali.

## 🎯 Overview

**IIS Reverse Proxy** permette di:

- ✅ **Domini personalizzati**: `<http://gestione-pareri.local`> invece di `IP:8000`
- ✅ **SSL/HTTPS nativo**: Certificati Windows integrati
- ✅ **Load balancing**: Distribuzione carico su più worker Django
- ✅ **File statici**: Serving diretto da IIS (performance migliori)
- ✅ **Integrazione AD**: Autenticazione Windows/Active Directory
- ✅ **Enterprise ready**: Logging, monitoring, sicurezza aziendale

## 🚀 Quick Start

### Setup Automatico (Raccomandato)

```bash
# Just task runner
just setup-iis
# Make
make setup-iis
```

### Deploy Completo

`````bash
# Deploy con IIS reverse proxy
just deploy-intranet
# Make equivalente
- **Windows Server 2016+** o **Windows 10/11 Pro**
- **IIS** installato e configurato
- **URL Rewrite Module** per IIS
- **Privilegi amministratore**
### Installazione IIS
```powershell
# Abilita IIS su Windows
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
# Abilita funzionalità avanzate
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic
```

### URL Rewrite Module

Scarica e installa da: <https://www.iis.net/downloads/microsoft/url-rewrite> Scarica e installa da:
<https://www.iis.net/downloads/microsoft/url-rewrite>

## ⚙️ Configurazione Manuale

**File: `.env`**

```env
# Dominio intranet
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1,0.0.0.0,gestione-pareri.local,*.intranet.local
# CSRF Origins per reverse proxy
DJANGO_CSRF_TRUSTED_ORIGINS=<http://gestione-pareri.local,<https://gestione-pareri.local,<http://*.intranet.local,<https://*.intranet.lo>c>a>l>
```

### 2. Application Pool IIS

````powershell
```powershell
# Crea Application Pool dedicato
New-WebAppPool -Name "GestionePareri" -Force
Set-ItemProperty -Path "IIS:\AppPools\GestionePareri" -Name processModel.identityType -Value ApplicationPoolIdentity
Set-ItemProperty -Path "IIS:\AppPools\GestionePareri" -Name recycling.periodicRestart.time -Value "00:00:00"
````

### 3. Sito Web IIS

````powershell
```powershell
# Crea sito web
New-Website -Name "GestionePareri" -Port 80 -PhysicalPath "C:\inetpub\wwwroot\gestione-pareri" -ApplicationPool "GestionePareri"
# Configura binding dominio personalizzato
New-WebBinding -Name "GestionePareri" -Protocol http -Port 80 -HostHeader "gestione-pareri.local"
````

### 4. Web.config

**File: `staticfiles/web.config`** **File: `staticfiles/web.config`**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.webServer>
        <!-- Reverse proxy per Django -->
        <rewrite>
            <rules>
                <rule name="Django Reverse Proxy" stopProcessing="true">
                    <match url=".*" />
                    <conditions>
                        <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
                        <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
                    </conditions>
                    <action type="Rewrite" url="<http://127.0.0.1:8000/{R:0}"> />
                </rule>
            </rules>
        </rewrite>
        <!-- Headers per Django -->
        <httpProtocol>
            <customHeaders>
                <add name="X-Forwarded-Proto" value="http" />
                <add name="X-Forwarded-Host" value="{HTTP_HOST}" />
            </customHeaders>
        </httpProtocol>
        <!-- File statici serviti da IIS -->
        <staticContent>
            <mimeMap fileExtension=".css" mimeType="text/css" />
            <mimeMap fileExtension=".js" mimeType="application/javascript" />
            <mimeMap fileExtension=".json" mimeType="application/json" />
        </staticContent>
    </system.webServer>
</configuration>
```

### 5. DNS/Hosts Configuration

**File: `C:\Windows\System32\drivers\etc\hosts`** **File: `C:\Windows\System32\drivers\etc\hosts`**

```
127.0.0.1    gestione-pareri.local
```

## 🔒 SSL/HTTPS Configuration

### Self-Signed Certificate

### Self-Signed Certificate

```powershell
# Genera certificato self-signed
New-SelfSignedCertificate -DnsName "gestione-pareri.local" -CertStoreLocation "cert:\LocalMachine\My"
# Configura binding HTTPS
New-WebBinding -Name "GestionePareri" -Protocol https -Port 443 -HostHeader "gestione-pareri.local"
```

### Enterprise Certificate

Per certificati aziendali, consulta il tuo team IT per: Per certificati aziendali, consulta il tuo team IT per:

- **Certificati CA interni**
- **Wildcard certificates**
- **Integrazione AD CS** (Active Directory Certificate Services)

## 🚀 Deployment Workflow

```bash
# Installa dipendenze
uv sync --frozen
# Migrazioni database
just migrate-prod
# Raccolta file statici
just collectstatic-prod
```

### 2. Avvio Django Backend

````bash
```bash
# Avvia server Django per reverse proxy
just run-uvicorn
# Server disponibile su <http://127.0.0.1:8000>
````

### 3. Test Configuration

````bash
```bash
# Test connettività Django diretto
curl <http://127.0.0.1:8000>
# Test reverse proxy IIS
curl <http://gestione-pareri.local>
````

## 📊 Monitoring & Logs

### Log Locations

- **IIS Error Logs**: `%SystemRoot%\System32\LogFiles\HTTPERR`
- **Event Viewer**: Windows Logs > Application

### Performance Monitoring

````powershell
```powershell
# Monitora performance IIS
Get-Counter -Counter "\Web Service(_Total)\Current Connections"
Get-Counter -Counter "\Web Service(_Total)\Bytes Total/Sec"
````

## 🔧 Troubleshooting

**Cause comuni:**

- Django server non avviato
- Porta 8000 occupata
- Firewall blocking **Soluzioni:**

```bash
# Verifica Django
just kill-port
just run-uvicorn
# Verifica porte
netstat -an | findstr 8000
```

### Problema: "File statici non caricano"

**Soluzioni:** **Soluzioni:**

```bash
# Rigenera file statici
just collectstatic-prod
# Verifica permessi
icacls "staticfiles" /grant "IIS_IUSRS:(OI)(CI)F"
```

### Problema: "CSRF token missing or incorrect"

**Verifica configurazione:** **Verifica configurazione:**

```env
## 🎯 Best Practices
### Security
- ✅ **HTTPS only**: Redirect HTTP → HTTPS
- ✅ **Headers security**: X-Frame-Options, CSP
- ✅ **Updates**: Mantieni IIS e moduli aggiornati
- ✅ **Static files**: Serve da IIS, non Django
- ✅ **Compression**: Abilita compressione IIS
- ✅ **Caching**: Headers caching per risorse statiche
- ✅ **Load balancing**: Multiple Django workers
- ✅ **Backup**: Database e configurazioni
- ✅ **Monitoring**: Script automated health check
- ✅ **Logging**: Rotazione log automatica
## 🔗 File Correlati
- [IIS URL Rewrite Documentation](https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/)
- [Django Deployment Checklist](https://docs.djangoproject.com/en/stable/howto/deployment/checklist/)
- [Windows Server IIS Best Practices](https://docs.microsoft.com/en-us/iis/)
## 🔗 File Correlati
- [`deployment/web.config`](../deployment/web.config) - Configurazione IIS
- [`deployment/setup-iis.ps1`](../deployment/setup-iis.ps1) - Script automatizzazione
- [`deployment/README.md`](../deployment/README.md) - Guide deployment
- [`justfile`](../justfile) - Task runner commands
```

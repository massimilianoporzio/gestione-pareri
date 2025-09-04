# 🚀 DEPLOYMENT PRODUZIONE - Guida Completa

## 📋 Panoramica Deployment Strategy

### Architettura Target

```
GitHub Repository → Clone Server Produzione → IIS Configuration → Database Setup
```

### Directory Structure Produzione

```
C:\inetpub\wwwroot\pratiche-pareri\     # IIS Root Directory
├── src\                               # Django Application
├── staticfiles\                       # Static files raccolti
├── media\                            # Media files uploaded
├── logs\                             # Application logs
├── web.config                        # IIS Configuration (NON in repo)
├── .env.prod                         # Environment vars (NON in repo)
└── uv.lock                          # Dipendenze locked
```

## 🔧 PASSO 1: Setup Server Produzione

### Prerequisiti Server

- [x] Windows Server con IIS installato
- [x] PostgreSQL installato e configurato
- [x] Python 3.11+ installato
- [x] Git installato
- [x] uv package manager installato

### Setup Directory Produzione

```powershell
# Crea directory base
New-Item -ItemType Directory -Force -Path "C:\inetpub\wwwroot\pratiche-pareri"
Set-Location "C:\inetpub\wwwroot\pratiche-pareri"
# Clone repository
git clone <https://github.com/massimilianoporzio/gestione-pareri.git> .
# Setup branch per produzione (opzionale)
git checkout -b production-deploy
```

## 🔧 PASSO 2: Configurazione Credenziali

### Setup Files di Configurazione

```powershell
# Crea file configurazione da template
Copy-Item web.config.template web.config
Copy-Item .env.prod.template .env.prod
# IMPORTANTE: Modifica manualmente i file con valori reali!
```

### File da configurare

#### A) `web.config` - Configurazione IIS

- **processPath**: Percorso corretto a Python/uv
- **DJANGO_DATABASE_URL**: Credenziali database produzione
- **DJANGO_SECRET_KEY**: Chiave sicura generata per produzione
- **DJANGO_ALLOWED_HOSTS**: IP/domini del server reale

#### B) `.env.prod` - Variabili ambiente

- **Database credentials**: Username/password PostgreSQL reali
- **Security settings**: SECRET_KEY, SSL settings
- **Host configuration**: IP server, domini autorizzati

## 🔧 PASSO 3: Database Setup

### Configurazione PostgreSQL Produzione

```sql
-- Crea utente e database per produzione
CREATE USER gestione_pareri_prod WITH PASSWORD 'YOUR_STRONG_PRODUCTION_PASSWORD';
CREATE DATABASE gestione_pareri_prod OWNER gestione_pareri_prod;
GRANT ALL PRIVILEGES ON DATABASE gestione_pareri_prod TO gestione_pareri_prod;
```

### Migrazioni e Setup

```powershell
# Installa dipendenze
uv sync
# Esegui migrazioni
uv run python src/manage.py migrate --settings=home.settings.prod
# Raccogli file statici
uv run python src/manage.py collectstatic --noinput --settings=home.settings.prod
# Crea superuser
uv run python src/manage.py createsuperuser --settings=home.settings.prod
```

## 🔧 PASSO 4: Configurazione IIS

### Setup Application Pool

```powershell
# Crea Application Pool dedicato
New-WebAppPool -Name "GestionePareriPool"
Set-ItemProperty -Path "IIS:\AppPools\GestionePareriPool" -Name "processModel.identityType" -Value "ApplicationPoolIdentity"
```

### Setup Website

```powershell
# Crea sito IIS
New-Website -Name "GestionePareri" -PhysicalPath "C:\inetpub\wwwroot\pratiche-pareri" -ApplicationPool "GestionePareriPool" -Port 80
# Oppure come Application sotto existing site:
New-WebApplication -Site "Default Web Site" -Name "pratiche-pareri" -PhysicalPath "C:\inetpub\wwwroot\pratiche-pareri" -ApplicationPool "GestionePareriPool"
```

### Configurazione Permessi

```powershell
# Imposta permessi directory per IIS
$acl = Get-Acl "C:\inetpub\wwwroot\pratiche-pareri"
$appPoolSid = (New-Object System.Security.Principal.SecurityIdentifier("S-1-5-82")).Translate([System.Security.Principal.NTAccount])
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($appPoolSid, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($accessRule)
Set-Acl -Path "C:\inetpub\wwwroot\pratiche-pareri" -AclObject $acl
```

## 🔧 PASSO 5: Test e Verifica

### Test Locali

```powershell
# Test configurazione Django
uv run python src/manage.py check --settings=home.settings.prod
# Test server locale
uv run uvicorn home.asgi:application --host localhost --port 8000
```

### Test IIS

- **URL principale**: `<http://your-server-ip/pratiche-pareri/`>
- **Admin interface**: `<http://your-server-ip/pratiche-pareri/admin/`>

## 🔄 PASSO 6: Aggiornamenti Futuri

### Script Update Produzione

```powershell
# Pull latest changes
git pull origin main
# Update dependencies
uv sync
# Run migrations
uv run python src/manage.py migrate --settings=home.settings.prod
# Collect static files
uv run python src/manage.py collectstatic --noinput --settings=home.settings.prod
# Restart IIS Application Pool
Restart-WebAppPool -Name "GestionePareriPool"
```

## 🔐 SICUREZZA

### File da NON committare mai

- `web.config` (contiene credenziali)
- `.env.prod` (contiene password)
- `logs/` directory
- `media/` files utenti

### Backup Strategy

- Database backup automatico
- Backup file configurazione in location sicura
- Backup media files

## 🆘 Troubleshooting

### Log Files da controllare

- **Django logs**: `logs/django.log`
- **IIS logs**: `C:\inetpub\logs\LogFiles\`
- **Event Viewer**: Windows Application logs

### Comandi diagnosi

```powershell
# Check IIS status
Get-Website -Name "GestionePareri"
Get-WebAppPool -Name "GestionePareriPool"
# Check processes
Get-Process | Where-Object {$_.Name -like "*python*"}
# Test database connection
uv run python src/manage.py dbshell --settings=home.settings.prod
```

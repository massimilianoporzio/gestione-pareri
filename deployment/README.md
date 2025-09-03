# 🏢 Deployment Intranet Aziendale

Questa guida spiega come configurare Gestione Pareri per l'accesso tramite intranet aziendale con nome dominio personalizzato.

## 📋 Prerequisiti

- Windows Server con IIS installato
- Privilegi di amministratore
- PostgreSQL configurato (opzionale)
- URL Rewrite Module per IIS

## 🚀 Setup Completo

### 1️⃣ Configurazione automatica IIS
```bash
# Eseguire come amministratore
just setup-iis
```

### 2️⃣ Configurazione hosts file (OPZIONALE)
Se non hai DNS interno, aggiungi al file hosts:
```
# File: C:\Windows\System32\drivers\etc\hosts
127.0.0.1    gestione-pareri.local
```

### 3️⃣ Deploy applicazione
```bash
just deploy-intranet
```

### 4️⃣ Accesso tramite browser
- **Sviluppo**: http://gestione-pareri.local
- **Produzione**: https://gestione-pareri.local (se configurato SSL)

## ⚙️ Configurazione Avanzata

### SSL/HTTPS
Per abilitare HTTPS:

1. **Genera certificato**:
   ```powershell
   New-SelfSignedCertificate -DnsName "gestione-pareri.local" -CertStoreLocation "cert:\LocalMachine\My"
   ```

2. **Configura binding HTTPS**:
   ```powershell
   New-WebBinding -Name GestionePareri -Protocol https -Port 443 -HostHeader "gestione-pareri.local"
   ```

### Database PostgreSQL
Se usi PostgreSQL invece di SQLite:

1. Configura `.env`:
   ```env
   DB_ENGINE=django.db.backends.postgresql
   DB_NAME=gestione_pareri_prod
   DB_USER=postgres
   DB_PASSWORD=your_password
   DB_HOST=localhost
   DB_PORT=5432
   ```

## 🔧 Troubleshooting

### Problema: "Sito non raggiungibile"
- Verifica che IIS sia avviato
- Controlla che il server Django sia in esecuzione (`just deploy-intranet`)
- Verifica file hosts o DNS interno

### Problema: "502 Bad Gateway"
- Il server Django non è avviato o non risponde sulla porta 8000
- Verifica log Django e IIS

### Problema: File statici non caricano
- Esegui `just collectstatic` 
- Verifica permessi cartella staticfiles
- Controlla configurazione web.config

## 📊 Monitoraggio

- **Log Django**: `logs/`
- **Log IIS**: Windows Event Viewer
- **Performance**: Task Manager + Resource Monitor

## 🔒 Sicurezza

Per produzione, considera:
- Certificati SSL validi
- Firewall configurato
- Backup automatici database
- Monitoraggio log di sicurezza

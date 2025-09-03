# 🚀 Piano Deployment Produzione

## 📋 Pre-requisiti

- [ ] Server Windows con IIS installato
- [ ] PostgreSQL installato e configurato
- [ ] uv package manager installato
- [ ] Credenziali database pronte (.env.prod)
- [ ] Directory E:\prod creata

## 🎯 Fase 1: Installazione Iniziale (UNA VOLTA SOLA)

```powershell
# Esegui come Administrator
.\scripts\deployment\production-deploy.ps1 `
  -DeployPath "E:\prod\gestione-pareri" `
  -ServerIP "192.168.1.100" `
  -SiteName "GestionePareri" `
  -AppPoolName "GestionePareriPool"
```

### ✅ Cosa fa automaticamente:

- Clone del repository in E:\prod\gestione-pareri
- Setup ambiente Python con uv
- Configurazione web.config per IIS
- Creazione Application Pool dedicato
- Configurazione sito web IIS
- Migrazione database
- Raccolta file statici
- Test di funzionamento

## 🔄 Fase 2: Aggiornamenti Futuri

```powershell
# Per nuove versioni/bugfix
.\scripts\deployment\production-deploy.ps1 -UpdateOnly -DeployPath "E:\prod\gestione-pareri"
```

### ✅ Cosa fa automaticamente:

- Pull delle modifiche da GitHub
- Aggiornamento dipendenze Python
- Migrazione database (se necessario)
- Aggiornamento file statici
- Restart dell'Application Pool

## 🌐 Risultato Finale

**URL Produzione**: http://192.168.1.100/pratiche-pareri/
**Admin Interface**: http://192.168.1.100/pratiche-pareri/admin/

## 📊 Post-Installazione

1. **Crea superuser**:

   ```powershell
   cd E:\prod\gestione-pareri
   uv run python src/manage.py createsuperuser --settings=home.settings.prod
   ```

2. **Verifica logs**:

   - IIS Logs: C:\inetpub\logs\LogFiles\
   - Django Logs: E:\prod\gestione-pareri\logs\

3. **Monitoraggio**:
   - IIS Manager per stato Application Pool
   - Event Viewer per errori sistema
   - Log files per errori applicazione

## 🚨 Importante

- Il sito resta **SEMPRE ATTIVO** dopo l'installazione
- **NON serve lanciare comandi** ogni volta
- Per spegnere: IIS Manager → Stop Application Pool
- Per riavviare: IIS Manager → Start Application Pool

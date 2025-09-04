# 🔒 Security Guidelines - File Sensibili

## ⚠️ FILE DA NON COMMITTARE MAI

### File di configurazione con credenziali

- `web.config` - Contiene password database, secret keys, percorsi server
- `.env.prod` - Variabili d'ambiente di produzione
- `.env.staging` - Variabili d'ambiente di staging
- `deployment.config` - Configurazioni specifiche del deployment

### File generati durante il deployment

- `logs/` - Directory con log dell'applicazione
- `staticfiles/` - File statici raccolti da Django
- File `*.config.local` - Configurazioni locali del server

## ✅ FILE TEMPLATE SICURI (Commitabili)

### Template di configurazione

- `web.config.template` - Template per web.config senza credenziali
- `.env.prod.template` - Template per variabili d'ambiente
- `.env.staging.template` - Template per staging

## 🚀 Processo di Deployment Sicuro

### Passo 1: Preparazione

```bash
just iis-setup  # Crea file da template
```

### Passo 2: Configurazione (MANUALE)

1. Modifica `web.config` con valori reali:
   - Database credentials
   - SECRET_KEY sicura (genera con `python -c "import secrets; print(secrets.token_urlsafe(50))")`
   - Server IP/domini reali
   - Percorsi Python corretti
2. Modifica `.env.prod` con valori reali:
   - Credenziali database PostgreSQL
   - Hosts e domains autorizzati
   - Configurazione email (se necessaria)

### Passo 3: Test locale

```bash
just iis-test-local  # Testa con configurazione IIS
```

### Passo 4: Deploy (SOLO dopo test locale ok)

```bash
just iis-deploy  # Deploy su IIS server
```

## 🔐 Best Practices Sicurezza

### SECRET_KEY

- Genera sempre una nuova chiave per produzione
- Usa almeno 50 caratteri casuali
- Non riutilizzare mai la chiave tra ambienti

### Database

- Usa password forti (min 12 caratteri, mix maiusc/minusc/numeri/simboli)
- Crea utenti dedicati per ogni ambiente
- Non condividere credenziali tra DEV/TEST/STAGING/PROD

### Backup sicuro

- Backupa i file `.config` in location sicura (NON repository)
- Documenta le configurazioni senza includere password
- Usa sistemi di gestione segreti per production (Azure Key Vault, etc.)

## 📋 Checklist Pre-Deploy

- [ ] File `web.config` configurato con credenziali reali
- [ ] File `.env.prod` configurato
- [ ] Database PostgreSQL configurato e testato
- [ ] Test locale con `just iis-test-local` passa
- [ ] Backup delle configurazioni effettuato
- [ ] Verificato che `web.config` sia in `.gitignore`
- [ ] SECRET_KEY generata per produzione (NON quella di test!)

## 🆘 Recovery

Se per errore committate file sensibili:

1. **FERMATE TUTTO** - Non pushate!
2. Rimuovete il file: `git rm web.config`
3. Committate la rimozione: `git commit -m "Remove sensitive config"`
4. Se già pushato: cambiate TUTTE le password/secret immediatamente
5. Aggiungete il file a `.gitignore` per il futuro

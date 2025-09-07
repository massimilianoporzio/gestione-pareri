# 📚 Documentazione Progetto - Gestione Pareri

Documentazione completa per il sistema di gestione pratiche e pareri in ambiente aziendale ASL.

## 🚀 Guide Principali

### **Setup & Configurazione**

- 🌍 [**Ambienti di Sviluppo**](environments-guide.md) - Configurazione DEV/TEST/STAGING/PROD
- 🗄️ [**Database Setup**](database-setup.md) - PostgreSQL multi-ambiente
- 🔐 [**Database Security**](database-security.md) - Gestione password sicure
- 🛠️ [**Just Commands**](just.md) - Task runner multi-piattaforma

### **Testing & Quality**

- 🧪 [**Testing Guide**](testing-guide.md) - **⭐ GUIDA COMPLETA AI TEST**
- 📊 [**Code Analysis**](code_analysis.md) - Analisi qualità codice
- 📝 [**Docstring Generation**](docstring_generation.md) - Documentazione automatica

### **Deploy & Production**

- 🖥️ [**IIS Deployment**](iis-deployment.md) - Deploy Windows Server
- 🐧 [**Nginx Deployment**](nginx-deployment.md) - Deploy Linux/Unix
- ⚡ [**Uvicorn Integration**](uvicorn-integration.md) - ASGI server setup

### **Frontend & Integration**

- 🎨 [**Frontend Integration**](frontend-integration.md) - TailwindCSS + Node.js
- 🔗 [**Node.js Integration**](nodejs-integration.md) - Setup completo frontend

### **Development Tools**

- � [**UV Package Manager**](uv-guide.md) - Package manager moderno Python
- �💻 [**VSCode Configuration**](vscode-configuration.md) - IDE setup ottimale
- 📋 [**Environment Variables**](environment-variables.md) - Configurazione variabili
- 📝 [**Logging Configuration**](logs_configuration.md) - Sistema di logging

#### Estensioni VS Code Consigliate

Per lavorare al meglio su questo progetto, installa queste estensioni:

- **Live Preview** (Microsoft): per visualizzare file HTML renderizzati direttamente nell’editor.
- **Django** (Benoit Pierre): supporto avanzato per lo sviluppo Django (template, completamento, linting, ecc.).
- **Prettier - Code formatter**: formattazione automatica del codice.
- **markdownlint**: linting e correzione automatica dei file Markdown.
- **Python** (Microsoft): ambiente Python completo.
- **Run On Save** (emeraldwalk): esegue automaticamente comandi e test ogni volta che salvi un file. Per visualizzare il
  report coverage HTML generato dalla ricetta `just coverage`:
- apri `htmlcov/index.html`
- clicca sull’icona globo (Live Preview) oppure usa il comando "Live Preview: Open Preview" dalla palette comandi.

## 🧪 **Testing - Start Here!** ⭐

**Se stai per fare deploy su IIS, inizia dalla guida ai test:**

### **Quick Test Commands**

```bash
# Test completi (SEMPRE prima del deploy)
cd src && uv run manage.py test accounts --settings=home.settings.test_local
# Test specifici sicurezza (CRITICO per IIS)
cd src && uv run manage.py test accounts.tests.SecurityTest --settings=home.settings.test_local
# Test performance (IMPORTANTE per Windows Server)
cd src && uv run manage.py test accounts.tests.PerformanceTest --settings=home.settings.test_local
```

### **Pre-Deploy Checklist** ✅

- [ ] **42/42 test passano**
- [ ] **SecurityTest** (6/6) - validazione domini @aslcn1.it
- [ ] **PerformanceTest** (2/2) - ottimizzazione per IIS
- [ ] **AdminIntegrationTest** (3/3) - interfaccia funzionante
- [ ] **Database configurato** per ambiente target 📋 **Guida completa**: [Testing Guide](testing-guide.md)

## 🎯 Flusso di Lavoro Consigliato

### **1. Setup Iniziale**

1. Leggi [Ambienti di Sviluppo](environments-guide.md)
2. Configura [Database Setup](database-setup.md)
3. Verifica [Testing Guide](testing-guide.md)

### **2. Sviluppo**

1. Usa comandi [Just](just.md) per task comuni
2. Esegui test frequenti: `just test`
3. Controlla qualità: [Code Analysis](code_analysis.md)

### **3. Deploy**

1. **Test completi OBBLIGATORI**: [Testing Guide](testing-guide.md)
2. Windows: [IIS Deployment](iis-deployment.md)
3. Linux: [Nginx Deployment](nginx-deployment.md)

## 🏥 Conformità ASL

### **Sicurezza Aziendale**

- 🔒 **Solo domini @aslcn1.it** (validato nei test)
- 📊 **Audit trail completo** con django-crum
- ⚡ **Performance ottimizzata** per Windows Server IIS
- 🛡️ **Password sicure** con gestione automatica

### **Test di Conformità**

```bash
# Validazione domini aziendali
test_email_domain_validation: ✅
# Protezione CSRF per sicurezza web
test_csrf_protection: ✅
# Hashing password sicuro
test_password_hashing: ✅
# Performance bulk operations
test_bulk_user_creation: ✅
```

## 📞 Quick Reference

### **Comandi Essenziali**

```bash
# Setup ambiente
just check-env-dev
# Test rapidi
just test
# Test completi pre-deploy
cd src && uv run manage.py test accounts --settings=home.settings.test_local
# Deploy staging
just setup-all-environments
# Server sviluppo
just run-dev
```

### **File di Configurazione Chiave**

- `src/home/settings/` - Settings per tutti gli ambienti
- `justfile` - Task runner commands
- `fixtures/initial_data.json` - Dati iniziali (superuser + gruppi)
- `src/accounts/` - Sistema autenticazione CustomUser

## 📖 Documentazione per Ruolo

### **👨‍💻 Developer**

Sviluppa nuove funzionalità, scrive test, mantiene la qualità del codice.

1. [UV Package Manager](uv-guide.md) - Setup ambiente moderno
2. [Ambienti di Sviluppo](environments-guide.md)
3. [Testing Guide](testing-guide.md)
4. [VSCode Configuration](vscode-configuration.md)
5. [Just Commands](just.md)

### **🏗️ DevOps**

Gestisce deployment, sicurezza, configurazione server e ambienti.

1. [IIS Deployment](iis-deployment.md)
2. [Database Security](database-security.md)
3. [Environment Variables](environment-variables.md)
4. [Uvicorn Integration](uvicorn-integration.md)

### **🧪 QA Tester**

Verifica la qualità, esegue test, segnala bug e anomalie.

1. [Testing Guide](testing-guide.md) ⭐
2. [Environments Guide](environments-guide.md)
3. [Code Analysis](code_analysis.md)

### **👨‍💼 Project Manager**

Coordina il team, pianifica rilasci, verifica la conformità e la documentazione.

## 📚 Glossario

## ✅ Best Practice Django

Ecco una checklist di best practice per mantenere il progetto robusto e sicuro:

- [x] Test automatici con copertura >90%
- [x] Linting e formattazione automatica (ruff, djlint, markdownlint, Prettier)
- [x] Gestione sicura delle variabili d’ambiente (.env, python-dotenv)
- [x] Aggiornamento regolare delle dipendenze (uv, pip-tools, safety)
- [x] Logging avanzato e monitoraggio (Sentry, django-crum)
- [x] Protezione CSRF e password sicure
- [x] Documentazione aggiornata e onboarding per nuovi sviluppatori
- [x] Flusso CI/CD automatizzato (GitHub Actions)
- [x] Deploy scriptato e riproducibile (Justfile, Docker)
- [x] Audit trail e tracciamento accessi

## 📊 Guida Coverage (Test Coverage)

**Coverage** misura quante righe di codice sono coperte dai test automatici. Usarlo è fondamentale per garantire qualità
e sicurezza.

### Come si usa

1. Installa coverage:

```bash
   uv add --dev coverage
```

1. Esegui i test con coverage:

```bash
   just coverage
```

1. Visualizza il report:
   - Testo: `coverage report`
   - HTML: `coverage html` (generato in `htmlcov/index.html`)
1. **Visualizza il report HTML renderizzato in VS Code**:
   - Installa l’estensione "Live Preview" di Microsoft.
   - Apri `htmlcov/index.html` e clicca su "Apri con Live Preview" (icona globo in alto a destra) oppure usa il comando
     "Live Preview: Open Preview" dalla palette comandi.
   - La ricetta `just coverage` ti ricorda automaticamente come visualizzare il report renderizzato.

### Consigli

- Integra coverage in CI/CD per bloccare merge se la copertura scende sotto una soglia.
- Punta ad almeno 90% di copertura, ma verifica che le parti critiche siano sempre testate.
- Usa il report HTML per individuare facilmente le righe non coperte.
  > **⚠️ IMPORTANTE**: Prima di ogni deploy in produzione, tutti i test devono passare. La documentazione testing è
  > **OBBLIGATORIA** per deployment su IIS in ambiente ospedaliero.

## 📦 Guida Installazione TailwindCSS e Strumenti Frontend

Per configurare TailwindCSS e gli strumenti frontend necessari, segui questi passaggi:

### 1. Installa le Dipendenze Necessarie

Esegui questi comandi nella radice del tuo progetto:

```bash
npm install --save-dev @tailwindcss/cli autoprefixer
npm install --save-dev webpack webpack-cli
npm install --save-dev @babel/core @babel/preset-env
```

### 2. Configura i Comandi Nella tua `package.json`

Aggiungi questi script alla sezione `"scripts"` del tuo file `package.json`:

```json
{
  "scripts": {
    "build": "webpack --mode production",
    "dev": "webpack --mode development --watch",
    "css": "tailwindcss -i src/static/css/input.css -o src/static/css/style.css"
  }
}
```

### 3. Esegui la Build e Avvia il Dev Server

Usa questi comandi per costruire il progetto e avviare il server di sviluppo:

```bash
# Costruisci il progetto per la produzione
npm run build

# Avvia il server di sviluppo con watch
npm run dev
```

### 4. Compila i Fogli di Stile con TailwindCSS

Esegui questo comando per generare il foglio di stile finale con TailwindCSS:

```bash
npm run css
```

### 5. Verifica la Configurazione

Controlla che non ci siano errori nella console e che il tuo progetto si compili correttamente.

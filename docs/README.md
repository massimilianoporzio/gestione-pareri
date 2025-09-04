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
- [ ] **Database configurato** per ambiente target
      📋 **Guida completa**: [Testing Guide](testing-guide.md)

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

1. [UV Package Manager](uv-guide.md) - Setup ambiente moderno
2. [Ambienti di Sviluppo](environments-guide.md)
3. [Testing Guide](testing-guide.md)
4. [VSCode Configuration](vscode-configuration.md)
5. [Just Commands](just.md)

### **🏗️ DevOps**

1. [IIS Deployment](iis-deployment.md)
2. [Database Security](database-security.md)
3. [Environment Variables](environment-variables.md)
4. [Uvicorn Integration](uvicorn-integration.md)

### **🧪 QA Tester**

1. [Testing Guide](testing-guide.md) ⭐
2. [Environments Guide](environments-guide.md)
3. [Code Analysis](code_analysis.md)

### **👨‍💼 Project Manager**

1. [Testing Guide](testing-guide.md) - Overview dei test
2. [IIS Deployment](iis-deployment.md) - Deploy produzione
3. Quick Reference (sopra)

---

> **⚠️ IMPORTANTE**: Prima di ogni deploy in produzione, tutti i test devono passare. La documentazione testing è **OBBLIGATORIA** per deployment su IIS in ambiente ospedaliero.

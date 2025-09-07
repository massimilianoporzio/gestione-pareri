# 🚀 DEPLOYMENT PRODUZIONE - Guida Completa

## 📋 Panoramica Deployment Strategy

### Architettura Target

```text
GitHub Repository → Clone Server Produzione → IIS Configuration → Database Setup
```

### Directory Structure Produzione

```markdown
C:\inetpub\wwwroot\pratiche-pareri\ # IIS Root Directory
├── src\ # Django Application
├── staticfiles\ # Static files raccolti
├── media\ # Media files uploaded
├── logs\ # Application logs
├── web.config # IIS Configuration (NON in repo)
├── .env.prod # Environment vars (NON in repo)
└── uv.lock # Dipendenze locked
```

## 🔧 PASSO 1: Setup Server Produzione

### Prerequisiti Server

- [x] uv package manager installato

### Setup Directory Produzione

````powershell

```powershell
# Crea directory base
New-Item -ItemType Directory -Force -Path "C:\inetpub\wwwroot\pratiche-pareri"
Set-Location "C:\inetpub\wwwroot\pratiche-pareri"
# Clone repository
git clone <https://github.com/massimilianoporzio/gestione-pareri.git> .
# Setup branch per produzione (opzionale)
git checkout -b production-deploy
```

## ⚙️ PASSO 2: Configurazione IIS

### Aggiunta Sito Web in IIS

1. Apri **IIS Manager**.
2. Clicca su **Add Website**.
3. Configura come segue:
   - **Site name**: pratiche-pareri
   - **Physical path**: `C:\inetpub\wwwroot\pratiche-pareri\src`
   - **Binding**: configura il dominio e la porta

### Configurazione Application Pool

- .NET CLR version: **No Managed Code**
- Managed pipeline mode: **Integrated**

### Configurazione Directory Browsing

Abilitare il Directory Browsing per la root del sito.

## 📦 PASSO 3: Configurazione Database

### Creazione Database

Esegui lo script SQL per creare il database.

### Configurazione Connessione

Modifica il file `.env.prod` con le credenziali del database.

## 📂 PASSO 4: Configurazione Static Files

### Raccolta Static Files

Esegui il comando:

```bash
python manage.py collectstatic --noinput
```

### Configurazione IIS per Static Files

Assicurati che la directory `C:\inetpub\wwwroot\pratiche-pareri\staticfiles` sia configurata in IIS per servire i file statici.

## 🔄 PASSO 5: Configurazione Deploy Automatico

### Configurazione Webhook GitHub

1. Vai su GitHub nel tuo repository.
2. Imposta un webhook per inviare eventi a `https://<tuo_dominio>/github-webhook/`.

### Configurazione Script di Deploy

Aggiungi uno script di deploy nel tuo repository che esegue:

```bash
git pull origin production-deploy
```

## 🎨 PASSO 6: Configurazione Tailwind CSS

### Installazione Dipendenze

```bash
npm install
```

### Configurazione File `tailwind.config.js`

Assicurati che il file `tailwind.config.js` punti ai percorsi corretti dei tuoi template.

### Compilazione CSS

Esegui il comando:

```bash
npm run build:css
```

## 🚀 PASSO 7: Avvio Applicazione

### Avvio Manuale

Esegui il comando:

```bash
python manage.py runserver
```

### Configurazione Avvio Automatico

Configura un servizio di sistema per avviare l'applicazione automaticamente.

## 🧪 PASSO 8: Verifica Funzionamento

### Controllo Log

Verifica i log in `C:\inetpub\wwwroot\pratiche-pareri\logs`.

### Test Applicazione

Accedi all'URL della tua applicazione e verifica che tutto funzioni correttamente.

## 📄 Esempio File `web.config`

```xml
<configuration>
  <system.webServer>
    <handlers>
      <add name="Python FastCGI" path="app.fcgi" verb="*"
      modules="FastCgiModule" scriptProcessor="C:\path\to\python.exe|C:\path\to\yourapp.wsgi" resourceType="Unspecified"
      requireAccess="Script" />
    </handlers>
  </system.webServer>
</configuration>
```

## 🔑 Esempio File `.env.prod`

```
DEBUG=False
SECRET_KEY='la_tua_chiave_segreta'
DATABASE_URL='postgres://user:password@localhost:5432/dbname'
ALLOWED_HOSTS='tuo_dominio.com'
```

## 📦 Esempio Script Deploy

```bash
#!/bin/bash
cd /path/to/your/app
git pull origin production-deploy
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
systemctl restart yourapp
```

## 📜 Note Finali

- Assicurati di avere un backup completo prima di ogni deploy.
- Testa sempre in un ambiente di staging prima di andare in produzione.
- Monitora l'applicazione dopo il deploy per eventuali problemi.

## 📞 Contatti

Per supporto, contattare il team di sviluppo:

- Email: supporto@tuodominio.com
- Telefono: +39 012 345 6789

## 🔗 Risorse Utili

- [Documentazione Django](https://docs.djangoproject.com/)
- [Documentazione Tailwind CSS](https://tailwindcss.com/docs)
- [Guida IIS per Django](https://docs.microsoft.com/en-us/iis/application-frameworks/install-and-configure-python-django-on-iis)

## 🛠️ Manutenzione

### Aggiornamento Applicazione

Per aggiornare l'applicazione, eseguire:

```bash
git pull origin master
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
```

### Monitoraggio

Utilizzare strumenti di monitoraggio per tenere traccia delle performance e degli errori dell'applicazione.

### Backup

Eseguire backup regolari del database e dei file statici/media.

## 🔒 Sicurezza

### Aggiornamenti di Sicurezza

Applicare tempestivamente gli aggiornamenti di sicurezza per il sistema operativo, Python, Django e tutte le dipendenze.

### Firewall

Configurare un firewall per limitare l'accesso alle porte necessarie (es. 80, 443, 8000).

### Certificati SSL

Utilizzare certificati SSL per criptare il traffico tra il client e il server.

## 📅 Pianificazione Manutenzione

Pianificare finestre di manutenzione regolari per aggiornamenti, backup e controlli di sicurezza.

## 📊 Reportistica

Generare report periodici sull'uso delle risorse, performance dell'applicazione e attività degli utenti.

## 🎉 Conclusioni

Seguendo questa guida, dovresti essere in grado di effettuare il deploy della tua applicazione Django con Tailwind CSS
su un server Windows con IIS in modo sicuro ed efficiente. Buona fortuna!

## Esempio File `package.json`

```json
{
  "name": "deploy-django-tailwind",
  "version": "1.0.0",
  "description": "Django with Tailwind CSS v4",
  "scripts": {
    "build:css": "npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify",
    "watch:css": "npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify --watch",
    "dev": "npm run watch:css"
  },
  "dependencies": {
    "@tailwindcss/cli": "^4.1.4",
    "tailwindcss": "^4.1.4"
  }
}
```
````

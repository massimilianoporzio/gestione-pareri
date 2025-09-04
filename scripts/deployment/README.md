# Deployment Scripts

Questa directory contiene script per il deployment in produzione usando diversi server WSGI.

## � Gestione File Statici

### Directory Structure

```
├── src/static/          # File statici sorgente (committare in Git)
├── staticfiles/         # File processati per produzione (NON committare)
└── media/              # File caricati dagli utenti (NON committare contenuto)
```

### Best Practices

### Directory Structure (Completa)

`````
### Processo di Deployment

1. **Development**: Django serve i file da `src/static/` direttamente
2. **Production**: `collectstatic` raccoglie tutti i file statici in `staticfiles/`
3. **WhiteNoise**: Serve i file da `staticfiles/` con compressione e cache headers


### Comandi Utili

````bash
# Raccolta file statici
make collectstatic

# Raccolta con pulizia precedente (consigliato per production)
python src/manage.py collectstatic --no-input --clear
``` WhiteNoise elimina la necessità di configurare un web server separato per i file statici.

### Caratteristiche WhiteNoise:

- ✅ **Zero configurazione** - Funziona out-of-the-box
- ✅ **Compressione automatica** - Gzip per tutti i file statici
- ✅ **Caching intelligente** - Headers di cache ottimali
- ✅ **Sicurezza** - Gestione sicura dei file statici
- ✅ **Performance** - Ottimizzato per CDN e browser caching

### Ambienti Configurati:

- **DEV**: Django serve i file direttamente (DEBUG=True)
- **TEST**: WhiteNoise con auto-refresh per testing
- **PROD**: WhiteNoise ottimizzato con compressione e cache

### Comandi per File Statici:

```bash
# Raccolta file statici per produzione
make collectstatic

# Per ambiente specifico
make collectstatic-dev
make collectstatic-test
make collectstatic-prod
`````

### Directory Structure

```

project/
├── src/static/          # File statici dell'app
├── staticfiles/         # File raccolti per produzione (auto-generati)
├── media/              # File caricati dagli utenti
└── mediafiles/         # Media files per produzione

```

## 🎯 Deployment Step-by-Step

### 1. Preparazione Ambiente

```bash
# Installa dipendenze di produzione
make install-prod

# O manualmente:
uv sync --group prod
```

### 2. Configurazione Database

**Opzione A - SQLite (semplice):**

```bash
# Usa il default SQLite
export DJANGO_ENV=prod
make migrate-prod
```

**Opzione B - PostgreSQL (produzione):**

```bash
# Configura variabili d'ambiente nel .env
echo "DB_ENGINE=django.db.backends.postgresql" >> .env
echo "DB_NAME=your_db_name" >> .env
echo "DB_USER=your_db_user" >> .env
echo "DB_PASSWORD=your_db_password" >> .env
echo "DB_HOST=localhost" >> .env
echo "DB_PORT=5432" >> .env

# Applica migrazioni
make migrate-prod
```

### 3. File Statici

```bash
# Raccoglie tutti i file statici
make collectstatic-prod
```

### 4. Deployment Automatico

```bash
# Deployment intelligente (rileva OS automaticamente)
make deploy

# O specifico per OS:
make deploy-prod    # Intelligente
make gunicorn      # Unix/Linux/macOS
make waitress      # Windows/Cross-platform
```

### 5. Verifica Deployment

```bash
# Verifica che il server risponda
curl <http://localhost:8000/>
curl <http://localhost:8000/healthz/>

# Verifica file statici (esempio con file admin Django)
curl <http://localhost:8000/static/admin/css/base.css>
```

## 🔧 Configurazione Avanzata

### Variabili d'Ambiente (.env)

```bash
# Django
DJANGO_SECRET_KEY=your-secret-key-here
DJANGO_ENV=prod
DJANGO_ALLOWED_HOSTS=yourdomain.com,.yourdomain.com,localhost
DJANGO_CSRF_TRUSTED_ORIGINS=<https://yourdomain.com,<https://www.yourdomain.co>m>

# Database (PostgreSQL)
DB_ENGINE=django.db.backends.postgresql
DB_NAME=deploy_django_prod
DB_USER=postgres
DB_PASSWORD=your-password
DB_HOST=localhost
DB_PORT=5432

# Email (per notifiche di errore)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password
DEFAULT_FROM_EMAIL=noreply@yourdomain.com

# Redis (cache, opzionale)
REDIS_URL=redis://localhost:6379/1

# SSL (produzione)
DJANGO_SECURE_SSL_REDIRECT=True
```

## 🚀 Gunicorn (Linux/macOS/WSL)

### Utilizzo Base

```bash
chmod +x scripts/deployment/start-gunicorn.sh
./scripts/deployment/start-gunicorn.sh
```

### Configurazione Avanzata

```bash
# Personalizza l'ambiente e i parametri
DJANGO_ENV=prod \
HOST=0.0.0.0 \
PORT=8000 \
WORKERS=4 \
./scripts/deployment/start-gunicorn.sh
```

### Variabili Disponibili

- `DJANGO_ENV`: dev/test/prod (default: prod)
- `HOST`: Bind address (default: 0.0.0.0)
- `PORT`: Bind port (default: 8000)
- `WORKERS`: Numero di worker processes (default: 4)
- `WORKER_CLASS`: Tipo di worker (default: sync)
- `TIMEOUT`: Worker timeout in secondi (default: 30)
- `KEEP_ALIVE`: Keep-alive timeout (default: 2)
- `MAX_REQUESTS`: Requests per worker prima del restart (default: 1000)

## 🪟 Waitress (Windows/Cross-platform)

### Utilizzo Waitress

```powershell
powershell -ExecutionPolicy Bypass -File scripts/deployment/start-waitress.ps1
```

### Configurazione Waitress

```powershell
scripts/deployment/start-waitress.ps1 -DjangoEnv prod -Host 0.0.0.0 -Port 8000 -Threads 4
```

### Parametri Disponibili

- `-DjangoEnv`: dev/test/prod (default: prod)
- `-Host`: Bind address (default: 0.0.0.0)
- `-Port`: Bind port (default: 8000)
- `-Threads`: Numero di thread (default: 4)
- `-ConnectionLimit`: Limite connessioni (default: 1000)
- `-ChannelTimeout`: Timeout canale in secondi (default: 120)

## 🔧 Come Funziona il Multi-Environment

Entrambi gli script:

1. **Impostano DJANGO_ENV** che determina quale settings usare:
   - `DJANGO_ENV=dev` → `home.settings.dev`
   - `DJANGO_ENV=test` → `home.settings.test`
   - `DJANGO_ENV=prod` → `home.settings.prod`

2. **Il file wsgi.py** legge automaticamente `DJANGO_ENV` e carica il settings appropriato

3. **Non servono file WSGI multipli** - un solo file gestisce tutti gli ambienti

## 📋 Pre-requisiti

### Per Gunicorn

```bash
uv add gunicorn
# O se usi pip:
pip install gunicorn
```

### Per Waitress

```bash
uv add waitress
# O se usi pip:
pip install waitress
```

## 🐳 Docker Example

```dockerfile
# Esempio Dockerfile usando Gunicorn
FROM python:3.13-slim

WORKDIR /app
COPY . .

RUN uv sync --frozen
RUN chmod +x scripts/deployment/start-gunicorn.sh

ENV DJANGO_ENV=prod
EXPOSE 8000

CMD ["./scripts/deployment/start-gunicorn.sh"]
```

## ⚙️ Systemd Service (Linux)

```ini
# /etc/systemd/system/django-app.service
[Unit]
Description=Django App with Gunicorn
After=network.target

[Service]
Type=exec
User=www-data
Group=www-data
WorkingDirectory=/path/to/your/project
Environment=DJANGO_ENV=prod
ExecStart=/path/to/your/project/scripts/deployment/start-gunicorn.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

## 🎯 Best Practices

### Produzione

- Usa **reverse proxy** (nginx/Apache) davanti a Gunicorn/Waitress
- Configura **SSL termination** nel proxy
- Imposta **DJANGO_ENV=prod**
- Usa **static file serving** dal proxy (non Django)
- Configura **logging** appropriato
- Monitora con **supervisord** o **systemd**

### Staging

- Usa **DJANGO_ENV=test** con dati di test
- Stessi parametri di produzione ma risorse ridotte

### Sviluppo

- Continua a usare `python manage.py runserver`
- Usa **DJANGO_ENV=dev** per debug attivo

## 🔍 Troubleshooting

### Errori Comuni

#### ModuleNotFoundError: No module named 'psycopg2'

```bash
# Installa il driver PostgreSQL
uv add --group prod psycopg2-binary
# O usa SQLite per semplicità (già configurato)
```

#### File statici non trovati (404)

```bash
# Verifica che i file siano stati raccolti
make collectstatic-prod
ls staticfiles/  # Dovrebbe contenere file CSS/JS

# Verifica settings WhiteNoise
python -c "
import os
os.environ.setdefault('DJANGO_ENV', 'prod')
from django.conf import settings
print('STATIC_ROOT:', settings.STATIC_ROOT)
print('WhiteNoise in MIDDLEWARE:', 'whitenoise' in str(settings.MIDDLEWARE))
"
```

#### Database connection error

```bash
# Verifica configurazione database
make check-env-prod

# Per PostgreSQL, verifica che il server sia running
sudo systemctl status postgresql  # Linux
brew services list | grep postgres  # macOS
```

#### Permission denied su script

```bash
# Su Unix/Linux, rendi executable gli script
chmod +x scripts/deployment/start-gunicorn.sh
```

### Best Practices Produzione

**🔒 Sicurezza:**

- Usa sempre HTTPS in produzione (`DJANGO_SECURE_SSL_REDIRECT=True`)
- Configura `ALLOWED_HOSTS` con domini specifici
- Non usare mai `DEBUG=True` in produzione
- Usa password complesse per database

**⚡ Performance:**

- Usa Redis per cache sessioni
- Configura CDN per file media pesanti
- Monitora memoria e CPU dei worker
- Usa connection pooling per database

**📊 Monitoring:**

- Configura logging centralizzato
- Monitora metriche applicazione (tempo risposta, errori)
- Setup health checks automatici
- Backup regolari database

**🚀 Deployment:**

- Usa deployment blue/green per zero downtime
- Testa sempre in staging prima della produzione
- Versiona le release per rollback facili
- Documenta ogni cambio di configurazione

## 📚 Risorse Utili

- [Django Deployment Checklist](https://docs.djangoproject.com/en/stable/howto/deployment/checklist/)
- [WhiteNoise Documentation](https://whitenoise.readthedocs.io/)
- [Gunicorn Documentation](https://docs.gunicorn.org/)
- [Waitress Documentation](https://docs.pylonsproject.org/projects/waitress/)
- [PostgreSQL + Django Guide](https://docs.djangoproject.com/en/stable/ref/databases/#postgresql-notes)

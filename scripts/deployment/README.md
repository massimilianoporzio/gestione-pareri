# Deployment Scripts

Questa directory contiene script per il deployment in produzione usando diversi server WSGI.

## 🚀 Gunicorn (Linux/macOS/WSL)

### Utilizzo Base:

```bash
chmod +x scripts/deployment/start-gunicorn.sh
./scripts/deployment/start-gunicorn.sh
```

### Configurazione Avanzata:

```bash
# Personalizza l'ambiente e i parametri
DJANGO_ENV=prod \
HOST=0.0.0.0 \
PORT=8000 \
WORKERS=4 \
./scripts/deployment/start-gunicorn.sh
```

### Variabili Disponibili:

- `DJANGO_ENV`: dev/test/prod (default: prod)
- `HOST`: Bind address (default: 0.0.0.0)
- `PORT`: Bind port (default: 8000)
- `WORKERS`: Numero di worker processes (default: 4)
- `WORKER_CLASS`: Tipo di worker (default: sync)
- `TIMEOUT`: Worker timeout in secondi (default: 30)
- `KEEP_ALIVE`: Keep-alive timeout (default: 2)
- `MAX_REQUESTS`: Requests per worker prima del restart (default: 1000)

## 🪟 Waitress (Windows/Cross-platform)

### Utilizzo Waitress:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/deployment/start-waitress.ps1
```

### Configurazione Waitress:

```powershell
scripts/deployment/start-waitress.ps1 -DjangoEnv prod -Host 0.0.0.0 -Port 8000 -Threads 4
```

### Parametri Disponibili:

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

### Per Gunicorn:

```bash
uv add gunicorn
# O se usi pip:
pip install gunicorn
```

### Per Waitress:

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

### Produzione:

- Usa **reverse proxy** (nginx/Apache) davanti a Gunicorn/Waitress
- Configura **SSL termination** nel proxy
- Imposta **DJANGO_ENV=prod**
- Usa **static file serving** dal proxy (non Django)
- Configura **logging** appropriato
- Monitora con **supervisord** o **systemd**

### Staging:

- Usa **DJANGO_ENV=test** con dati di test
- Stessi parametri di produzione ma risorse ridotte

### Sviluppo:

- Continua a usare `python manage.py runserver`
- Usa **DJANGO_ENV=dev** per debug attivo

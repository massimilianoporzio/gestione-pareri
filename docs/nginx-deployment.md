# Nginx Reverse Proxy per Django

[![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-green)](https://nginx.org/)
[![Django](https://img.shields.io/badge/Django-5.2.0-green.svg)](https://www.djangoproject.com/)

Questa guida spiega come configurare **Nginx** come reverse proxy per Django su Linux e macOS.

## 🎯 Overview

**Nginx Reverse Proxy** offre:

- ✅ **Performance eccellenti**: Gestione migliaia di connessioni simultanee
- ✅ **Load balancing**: Distribuzione carico su worker Django multipli
- ✅ **SSL/TLS**: Terminazione SSL con Let's Encrypt o certificati custom
- ✅ **Static files**: Serving diretto ad alta performance
- ✅ **Gzip compression**: Riduzione bandwidth automatica
- ✅ **Security**: Rate limiting, DDoS protection, headers security

## 🚀 Quick Start

### Installazione Nginx

**Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

**CentOS/RHEL/Rocky:**

```bash
sudo dnf install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

**macOS:**

```bash
# Homebrew
brew install nginx
brew services start nginx
```

### Test Installazione

```bash
# Verifica stato
sudo systemctl status nginx

# Test connessione
curl http://localhost
```

## ⚙️ Configurazione Django + Nginx

### 1. Configurazione Django

**File: `.env`**

```env
# Production settings
DJANGO_ENV=prod
DJANGO_DEBUG=0

# Allowed hosts per reverse proxy
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1,0.0.0.0,tuodominio.com,www.tuodominio.com

# CSRF trusted origins
DJANGO_CSRF_TRUSTED_ORIGINS=https://tuodominio.com,https://www.tuodominio.com,http://localhost

# Static files per Nginx
DJANGO_STATIC_URL=/static/
DJANGO_MEDIA_URL=/media/
```

### 2. Configurazione Nginx

**File: `/etc/nginx/sites-available/gestione-pareri`**

```nginx
# Upstream per Django
upstream django_backend {
    # Single server
    server 127.0.0.1:8000;

    # Multiple workers (load balancing)
    # server 127.0.0.1:8000 weight=3;
    # server 127.0.0.1:8001 weight=2;
    # server 127.0.0.1:8002 backup;
}

# HTTP Server (redirect to HTTPS)
server {
    listen 80;
    server_name tuodominio.com www.tuodominio.com;

    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

# HTTPS Server (main)
server {
    listen 443 ssl http2;
    server_name tuodominio.com www.tuodominio.com;

    # SSL Configuration
    ssl_certificate /path/to/your/certificate.crt;
    ssl_certificate_key /path/to/your/private.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512;
    ssl_prefer_server_ciphers off;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;

    # Security Headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';" always;

    # Max file upload size
    client_max_body_size 100M;

    # Root directory
    root /path/to/your/project;

    # Static files (served by Nginx)
    location /static/ {
        alias /path/to/your/project/staticfiles/;
        expires 1y;
        add_header Cache-Control "public, immutable";

        # Gzip compression
        gzip on;
        gzip_vary on;
        gzip_types text/css application/javascript image/svg+xml;
    }

    # Media files (user uploads)
    location /media/ {
        alias /path/to/your/project/media/;
        expires 1M;
        add_header Cache-Control "public";
    }

    # Django application (reverse proxy)
    location / {
        proxy_pass http://django_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;

        # Timeout settings
        proxy_connect_timeout 30s;
        proxy_send_timeout 30s;
        proxy_read_timeout 30s;

        # Buffer settings
        proxy_buffer_size 4k;
        proxy_buffers 8 4k;
        proxy_busy_buffers_size 8k;

        # WebSocket support (se necessario)
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    # Health check endpoint
    location /health/ {
        proxy_pass http://django_backend/health/;
        access_log off;
    }

    # Block access to sensitive files
    location ~ /\.(ht|env|git) {
        deny all;
        return 404;
    }

    # Favicon
    location = /favicon.ico {
        alias /path/to/your/project/staticfiles/favicon.ico;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Robots.txt
    location = /robots.txt {
        alias /path/to/your/project/staticfiles/robots.txt;
        expires 1y;
        add_header Cache-Control "public";
    }
}
```

### 3. Attivazione Site

```bash
# Abilita configurazione
sudo ln -s /etc/nginx/sites-available/gestione-pareri /etc/nginx/sites-enabled/

# Test configurazione
sudo nginx -t

# Ricarica Nginx
sudo systemctl reload nginx
```

## 🔒 SSL/TLS con Let's Encrypt

### Installazione Certbot

**Ubuntu/Debian:**

```bash
sudo apt install certbot python3-certbot-nginx
```

**CentOS/RHEL:**

```bash
sudo dnf install certbot python3-certbot-nginx
```

### Genera Certificato

```bash
# Certificato automatico per dominio
sudo certbot --nginx -d tuodominio.com -d www.tuodominio.com

# Solo certificato (configurazione manuale)
sudo certbot certonly --nginx -d tuodominio.com
```

### Auto-renewal

```bash
# Test renewal
sudo certbot renew --dry-run

# Configura cron per auto-renewal
echo "0 12 * * * /usr/bin/certbot renew --quiet" | sudo crontab -
```

## 🚀 Deployment con Systemd

### 1. Service File Django

**File: `/etc/systemd/system/gestione-pareri.service`**

```ini
[Unit]
Description=Gestione Pareri Django App
After=network.target

[Service]
Type=notify
User=django
Group=django
WorkingDirectory=/path/to/your/project
Environment=PATH=/path/to/your/project/.venv/bin
Environment=DJANGO_ENV=prod
ExecStart=/path/to/your/project/.venv/bin/uvicorn home.asgi:application --host 127.0.0.1 --port 8000 --workers 4
ExecReload=/bin/kill -s HUP $MAINPID
KillMode=mixed
TimeoutStopSec=5
PrivateTmp=true
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

### 2. Attivazione Service

```bash
# Ricarica systemd
sudo systemctl daemon-reload

# Abilita e avvia service
sudo systemctl enable gestione-pareri
sudo systemctl start gestione-pareri

# Verifica status
sudo systemctl status gestione-pareri
```

## 🎯 Task Runner Integration

### Comandi Just/Make

Aggiungi al `justfile`:

```bash
# === NGINX DEPLOYMENT ===

# 🌐 Setup Nginx per Linux/macOS
setup-nginx:
    @Write-Host "🌐 Configurazione Nginx..." -ForegroundColor Cyan
    @# Copia configurazione
    sudo cp deployment/nginx.conf /etc/nginx/sites-available/gestione-pareri
    @# Abilita site
    sudo ln -sf /etc/nginx/sites-available/gestione-pareri /etc/nginx/sites-enabled/
    @# Test configurazione
    sudo nginx -t
    @# Reload Nginx
    sudo systemctl reload nginx
    @Write-Host "✅ Nginx configurato!" -ForegroundColor Green

# 🚀 Deploy con Nginx
deploy-nginx: install-prod
    @Write-Host "🚀 Deploy con Nginx..." -ForegroundColor Magenta
    @# Migrazioni
    {{django_manage}} migrate --no-input
    @# File statici
    {{django_manage}} collectstatic --no-input --clear
    @# Riavvia Django service
    sudo systemctl restart gestione-pareri
    @# Reload Nginx
    sudo systemctl reload nginx
    @Write-Host "✅ Deploy completato!" -ForegroundColor Green

# 📊 Status servizi
status-nginx:
    @Write-Host "📊 Status servizi..." -ForegroundColor Cyan
    sudo systemctl status nginx --no-pager
    sudo systemctl status gestione-pareri --no-pager
```

## 📊 Monitoring & Performance

### Log Analysis

```bash
# Log Nginx access
sudo tail -f /var/log/nginx/access.log

# Log Nginx error
sudo tail -f /var/log/nginx/error.log

# Log Django service
sudo journalctl -u gestione-pareri -f
```

### Performance Tuning

**Nginx optimizations:**

```nginx
# nginx.conf
worker_processes auto;
worker_connections 1024;

# Gzip compression
gzip on;
gzip_vary on;
gzip_min_length 1024;
gzip_types text/css application/javascript application/json image/svg+xml;

# File caching
open_file_cache max=1000 inactive=60s;
open_file_cache_valid 60s;
```

### SSL Performance

```nginx
# SSL session caching
ssl_session_cache shared:SSL:50m;
ssl_session_timeout 1h;

# OCSP stapling
ssl_stapling on;
ssl_stapling_verify on;
```

## 🔧 Troubleshooting

### Problema: "502 Bad Gateway"

```bash
# Verifica Django service
sudo systemctl status gestione-pareri

# Verifica connettività
curl http://127.0.0.1:8000

# Restart services
sudo systemctl restart gestione-pareri
sudo systemctl reload nginx
```

### Problema: File statici non caricano

```bash
# Permissions
sudo chown -R www-data:www-data /path/to/staticfiles
sudo chmod -R 644 /path/to/staticfiles

# Regenera static files
python manage.py collectstatic --clear --no-input
```

### Debug Configuration

```bash
# Test configurazione Nginx
sudo nginx -t

# Debug mode
sudo nginx -T

# Check ports
sudo netstat -tlnp | grep nginx
```

## 🏗️ Load Balancing

### Multiple Django Workers

```nginx
upstream django_backend {
    least_conn;  # Load balancing method

    server 127.0.0.1:8000 weight=3 max_fails=3 fail_timeout=30s;
    server 127.0.0.1:8001 weight=2 max_fails=3 fail_timeout=30s;
    server 127.0.0.1:8002 backup;
}
```

### Health Checks

```nginx
location /health/ {
    proxy_pass http://django_backend/health/;
    proxy_next_upstream error timeout invalid_header http_502 http_503;
    access_log off;
}
```

## 📚 Risorse Aggiuntive

- [Nginx Official Documentation](https://nginx.org/en/docs/)
- [Django Deployment with Nginx](https://docs.djangoproject.com/en/stable/howto/deployment/wsgi/uwsgi/)
- [Let's Encrypt Certbot](https://certbot.eff.org/)
- [Nginx SSL Best Practices](https://ssl-config.mozilla.org/)

## 🔗 File Correlati

- [`deployment/nginx.conf`](../deployment/nginx.conf) - Configurazione Nginx
- [`deployment/django.service`](../deployment/django.service) - Systemd service
- [`justfile`](../justfile) - Task runner commands
- [`docs/uvicorn-integration.md`](uvicorn-integration.md) - Server ASGI

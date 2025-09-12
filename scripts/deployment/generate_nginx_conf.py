import os
import sys
from decouple import Config, RepositoryEnv

# Carica variabili da .env
REPO_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
env_file = os.path.join(REPO_DIR, ".env")
config = Config(RepositoryEnv(env_file))

DJANGO_SUBPATH = config("DJANGO_SUBPATH")
SERVER_IP = config("SERVER_IP")

# Importa settings Django
sys.path.append(os.path.join(REPO_DIR, "src"))
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "home.settings.base")
from django.conf import settings

nginx_conf = f"""
server {{
    listen 80;
    server_name {SERVER_IP};

    location /{DJANGO_SUBPATH}/ {{
        proxy_pass http://127.0.0.1:8000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_buffering off;
    }}

    location /{DJANGO_SUBPATH}/static/ {{
        alias {settings.STATIC_ROOT}/;
        autoindex off;
    }}

    location /{DJANGO_SUBPATH}/media/ {{
        alias {settings.MEDIA_ROOT}/;
        autoindex off;
    }}
}}
"""

with open(os.path.join(REPO_DIR, f"nginx_{DJANGO_SUBPATH}.conf"), "w", encoding="utf-8") as f:
    f.write(nginx_conf)

print(f"Configurazione Nginx generata in nginx_{DJANGO_SUBPATH}.conf")

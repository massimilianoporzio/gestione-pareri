# Uvicorn ASGI Server Integration

Questa guida spiega come usare **Uvicorn** come server ASGI unificato per Django su tutti i sistemi operativi.

## 🎯 Overview

**Uvicorn è ora il server raccomandato** per questo template Django perché:

- ✅ **Cross-platform**: Funziona perfettamente su Windows, macOS, e Linux
- ✅ **ASGI nativo**: Supporta sia views sincrone che asincrone
- ✅ **Performance eccellenti**: Spesso più veloce di Gunicorn/Waitress
- ✅ **Futuro-compatibile**: Pronto per WebSockets, HTTP/2, async views
- ✅ **Configurazione unificata**: Un solo server per tutti gli OS

## 🚀 Quick Start

### Comando Base (Raccomandato)

```bash
make uvicorn
```

### Altri comandi disponibili

```bash
make deploy        # 🎯 Deploy automatico (ora usa Uvicorn)
make deploy-prod   # 🚀 Deploy produzione (Uvicorn)
make deploy-staging # 🧪 Deploy test/staging (Uvicorn)
```

### Verifica Installazione

```bash
# Controlla che Uvicorn sia installato
uv run uvicorn --version

# Test rapido
make uvicorn
```

## ⚙️ Configurazione

### Variabili d'Ambiente

**Comuni a tutti gli OS:**

- `DJANGO_ENV`: `dev`, `test`, `prod` (default: `prod`)
- `HOST`: Indirizzo bind (default: `0.0.0.0`)
- `PORT`: Porta (default: `8000`)
- `LOG_LEVEL`: `debug`, `info`, `warning`, `error` (default: `info`)

**Unix/Linux/macOS specifiche:**

- `WORKERS`: Numero di worker (default: `4`)
- `TIMEOUT`: Timeout in secondi (default: `30`)
- `KEEP_ALIVE`: Keep-alive timeout (default: `2`)
- `MAX_REQUESTS`: Richieste per worker (default: `1000`)

### Esempi di Configurazione

**Sviluppo (hot-reload):**

```bash
DJANGO_ENV=dev HOST=127.0.0.1 PORT=8000 make uvicorn
```

**Produzione (default):**

```bash
make uvicorn  # Usa automaticamente DJANGO_ENV=prod
```

**Produzione con configurazione custom:**

```bash
WORKERS=8 LOG_LEVEL=warning make uvicorn
```

**Test/Staging:**

```bash
DJANGO_ENV=test PORT=8080 make uvicorn
```

## 🖥️ Specifiche per OS

### Unix/Linux/macOS

- **Script**: `scripts/deployment/start-uvicorn.sh`
- **Multi-worker**: Usa Gunicorn + UvicornWorker per `WORKERS > 1`
- **Single worker**: Usa Uvicorn diretto per `WORKERS = 1`
- **Performance**: Ottimali con uvloop

### Windows

- **Script**: `scripts/deployment/start-uvicorn.ps1`
- **Multi-worker**: Single worker ottimizzato (Windows non supporta fork)
- **Performance**: Eccellenti anche senza uvloop
- **Compatibilità**: 100% nativa

## 📊 Modalità di Esecuzione

### 1. Sviluppo (`DJANGO_ENV=dev`)

```bash
uvicorn home.asgi:application --reload --host 127.0.0.1 --port 8000
```

- ✅ Hot-reload automatico
- ✅ Logging dettagliato
- ✅ Single process per debug

### 2. Test/Staging (`DJANGO_ENV=test`)

```bash
uvicorn home.asgi:application --host 0.0.0.0 --port 8000
```

- ✅ Configurazione simile a produzione
- ✅ WhiteNoise per file statici
- ✅ Single worker per testing

### 3. Produzione (`DJANGO_ENV=prod`)

**Single Worker:**

```bash
uvicorn home.asgi:application --host 0.0.0.0 --port 8000
```

**Multi-Worker (Unix/Linux/macOS):**

```bash
gunicorn home.asgi:application --workers 4 --worker-class uvicorn.workers.UvicornWorker
```

## 🔄 Retrocompatibilità

### Server Alternativi (ancora supportati)

**Gunicorn (Unix/Linux/macOS):**

```bash
make gunicorn
```

**Waitress (Windows/Cross-platform):**

```bash
make waitress
```

### Migrazione da WSGI a ASGI

**Il tuo codice Django non cambia!**

- Views sincrone continuano a funzionare identicamente
- Django automaticamente gestisce la compatibilità WSGI/ASGI
- Nessuna modifica necessaria alle views esistenti

## 🎛️ Controlli del Server

### Avvio

```bash
make uvicorn       # Avvia Uvicorn
make deploy        # Avvia con deploy automatico
```

### Stop

```bash
make stop-servers  # Ferma tutti i server (incluso Uvicorn)
make kill-port     # Termina processi sulla porta 8000
```

## 🔧 Troubleshooting

### Problemi Comuni

**1. Server non si avvia:**

```bash
# Controlla che non ci siano altri processi sulla porta
make kill-port

# Verifica la configurazione Django
DJANGO_ENV=dev uv run python src/manage.py check
```

**2. Errori di importazione:**

```bash
# Verifica che PYTHONPATH sia corretto
export PYTHONPATH="src:$PYTHONPATH"
uv run python -c "import home.asgi"
```

**3. Performance su Windows:**

```bash
# Usa single worker ottimizzato
WORKERS=1 powershell scripts/deployment/start-uvicorn.ps1
```

### Log e Debug

**Aumenta il livello di logging:**

```bash
LOG_LEVEL=debug make uvicorn
```

**Controlla i log Django:**

```bash
tail -f logs/django.log
```

## 🚀 Vantaggi di Uvicorn

### vs Gunicorn (Unix/Linux/macOS)

- ✅ **Performance**: Spesso 20-30% più veloce
- ✅ **Memory**: Uso memoria più efficiente
- ✅ **Features**: Supporto nativo HTTP/1.1 e WebSockets
- ✅ **Hot-reload**: Migliore per sviluppo

### vs Waitress (Windows)

- ✅ **Performance**: Significativamente più veloce
- ✅ **Standards**: Supporto ASGI completo
- ✅ **Future-ready**: Pronto per HTTP/2, WebSockets

### vs Django runserver

- ✅ **Production**: Adatto alla produzione
- ✅ **Concurrent**: Gestisce connessioni multiple
- ✅ **Static**: Integrazione WhiteNoise

## 📈 Performance Tips

### Per Produzione

1. Usa `LOG_LEVEL=warning` per ridurre I/O
2. Configura `WORKERS` basato sui CPU cores
3. Usa un reverse proxy (nginx) davanti a Uvicorn
4. Considera HTTP/2 con reverse proxy

### Per Sviluppo

1. Usa `DJANGO_ENV=dev` per hot-reload
2. `HOST=127.0.0.1` per sviluppo locale
3. `LOG_LEVEL=debug` per debugging

## 🔮 Futuro: Features ASGI Avanzate

**Questo template è già pronto per:**

- Views asincrone Django (`async def`)
- WebSockets con Django Channels
- HTTP/2 server push
- Background tasks asincrone
- Server-Sent Events (SSE)

**Esempio view asincrona:**

```python
# In views.py - già supportata!
async def async_view(request):
    # Codice asincrono
    data = await async_operation()
    return JsonResponse(data)
```

---

💡 **Raccomandazione**: Usa `make uvicorn` come server primario. Mantieni `make gunicorn` e `make waitress` solo per compatibilità legacy o requisiti specifici.

## 🛠️ Correzione automatica script bash (shfmt)

Per correggere automaticamente la formattazione e alcune best practice degli script bash (es. variabili non quotate, word splitting), usa **shfmt**.

### Installazione shfmt

**macOS (Homebrew):**

```bash
brew install shfmt
```

**Linux (Debian/Ubuntu):**

```bash
sudo apt-get install shfmt
```

**Windows:**

- Scarica il binario da [shfmt releases](https://github.com/mvdan/sh/releases)
- Aggiungi la cartella del binario a PATH
- Oppure usa [Scoop](https://scoop.sh/):

```powershell
scoop install shfmt
```

**Manuale (tutti gli OS):**

- Scarica da [shfmt releases](https://github.com/mvdan/sh/releases)
- Oppure, se hai Go installato:

```bash
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

### Utilizzo

Correggi tutti gli script bash di deployment:

```bash
shfmt -w scripts/deployment/*.sh
```

Puoi anche usare:

```bash
make fix-codacy
```

Questo comando applica le correzioni automatiche a tutti gli script bash di deploy.

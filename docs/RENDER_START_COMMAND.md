# Render Start Command per Django + Uvicorn (multi-worker)

Usa questo comando come **Start Command** su Render:

```sh
bash scripts/deployment/start-uvicorn-render.sh
```

Puoi personalizzare il numero di worker impostando la variabile UVICORN_WORKERS nelle Environment
Variables di Render (es: UVICORN_WORKERS=2). Il comando avvia:

```sh
uvicorn home.asgi:application --host 0.0.0.0 --port $PORT --log-level info --workers $UVICORN_WORKERS
```

nella cartella `src/`. Se vuoi testare in locale:

```sh
make uvicorn
```

oppure

```sh
bash scripts/deployment/start-uvicorn-render.sh
```

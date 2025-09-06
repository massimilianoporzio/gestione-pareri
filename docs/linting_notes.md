# Note sulla Configurazione del Linting

## Esclusione del Modulo `settings`

I file nel modulo `home/settings/` sono stati esclusi dai controlli di linting automatici (`black`, `flake8`, `isort`,
`pylint`, `ruff`) per i seguenti motivi:

1. **Importazioni con Asterisco**: I file di impostazioni di Django tipicamente usano `from .base import *` per
   ereditare le impostazioni base, causando errori di lint come F403 (importazione con asterisco) e F405 (variabili
   importate ma non definite).
2. **Struttura Specifica di Django**: I moduli di impostazioni di Django seguono convenzioni specifiche che spesso
   entrano in conflitto con le regole generali di linting Python.
3. **Modifiche Frequenti**: I file di impostazioni richiedono frequenti modifiche per adattarsi a diversi ambienti di
   sviluppo e deployment, rendendo più pratico evitare vincoli di formattazione rigidi.
4. **Compatibilità tra Ambienti**: L'uso di importazioni dinamiche e strutture condizionali per supportare diversi
   ambienti può generare falsi positivi nei controlli di lint.

## Hook di Pylint Disabilitato

I hook di pylint sono stati temporaneamente disabilitati in pre-commit a causa di problemi di configurazione. Questo non
significa che pylint non debba essere usato, ma che non viene eseguito automaticamente durante i commit. È possibile
eseguire pylint manualmente con:

```bash
# Windows
set PYTHONPATH=src && uv run pylint src --ignore=src/home/settings,src/home/settings.py
# macOS/Linux
PYTHONPATH=src uv run pylint src --ignore=src/home/settings,src/home/settings.py
```

## Best Practices per il Modulo `settings`

Anche se esclusi dai controlli automatici, è comunque consigliabile seguire queste linee guida:

1. Mantenere i file di impostazioni il più puliti e organizzati possibile
2. Raggruppare le impostazioni correlate (database, sicurezza, logging, ecc.)
3. Aggiungere commenti descrittivi per le impostazioni meno ovvie
4. Documentare le variabili d'ambiente necessarie in `.env.example`

## Configurazione Pre-commit

L'esclusione è implementata nel file `.pre-commit-config.yaml` con il pattern `exclude: ^src/home/settings/` per ciascun
hook di linting.

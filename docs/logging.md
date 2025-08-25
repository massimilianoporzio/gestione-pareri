# Configurazione del Logging

Questo progetto utilizza un sistema di logging avanzato con supporto per log colorati in console durante lo sviluppo e log su file in produzione.

## Caratteristiche principali

- **Log colorati in modalità debug**: In ambiente di sviluppo (DEBUG=True), i log vengono visualizzati in console con colori che indicano il livello di severità
- **Log su file in produzione**: In ambiente di produzione (DEBUG=False), i log vengono salvati in file con rotazione automatica
- **Email agli amministratori per errori critici**: Gli errori vengono automaticamente segnalati via email agli amministratori del sito
- **Configurazione basata su ambiente**: Il livello di log viene impostato automaticamente in base all'ambiente (DEBUG o produzione)

## Struttura dei log

I log sono configurati con diversi formattatori:

- **Formattatore colorato** (console): Utilizza `colorlog` per visualizzare log con colori diversi per ogni livello
- **Formattatore verboso** (file): Include informazioni dettagliate come timestamp, modulo, processo e thread
- **Formattatore semplice**: Versione minimal per log non critici

## Livelli di log per componente

| Componente         | Livello di log                  | Handlers                   |
| ------------------ | ------------------------------- | -------------------------- |
| django (generale)  | INFO                            | console, file              |
| django.request     | ERROR                           | mail_admins, console, file |
| django.security    | ERROR                           | mail_admins, console, file |
| django.db.backends | INFO                            | console, file              |
| root               | DEBUG (in dev) / INFO (in prod) | console, file              |

## Utilizzo nel codice

Per utilizzare il sistema di logging nelle tue applicazioni:

```python
import logging

# Ottieni un logger per il tuo modulo
logger = logging.getLogger(__name__)

# Usa i vari livelli di log
logger.debug("Informazione di debug dettagliata")
logger.info("Informazione generale")
logger.warning("Avviso per situazioni potenzialmente problematiche")
logger.error("Errore che impedisce il corretto funzionamento")
logger.critical("Errore critico che richiede attenzione immediata")
```

Per un esempio completo di utilizzo, consulta il file `examples/logging_example.py`.

## Configurazione personalizzata

La configurazione del logging è definita in `settings.py`. Puoi personalizzarla modificando:

- I formattatori per cambiare il formato dei messaggi
- I gestori (handlers) per aggiungere destinazioni di output
- I livelli di log per i vari componenti
- I colori utilizzati per i diversi livelli di log

## Directory dei log

I file di log vengono salvati nella directory `logs/` nella root del progetto. Questa directory viene creata automaticamente se non esiste.

I file di log principali sono:

- `django.log`: Log principale dell'applicazione
- `django.log.1`, `django.log.2`, ecc.: File di backup per la rotazione dei log

## Nota sulle performance

L'attivazione di livelli di log molto dettagliati (es. DEBUG) in produzione può avere un impatto sulle performance. Si consiglia di mantenere il livello INFO in ambienti di produzione.

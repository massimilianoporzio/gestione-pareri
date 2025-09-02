# Logging Utilities

Questo modulo (`logging_utils.py`) contiene implementazioni alternative dei formattatori di log, in particolare una versione basata su `colorama` per la compatibilità cross-platform.

## Contenuti

Il modulo fornisce:

1. **ColoramaFormatter**: Un formattatore basato su colorama per log colorati con supporto nativo per Windows
2. **Funzioni di utility**: Helper per creare handler della console con colorama

## Vantaggi di colorama rispetto a colorlog

Colorama offre diversi vantaggi:

- **Compatibilità nativa con Windows**: Funziona in modo nativo su Command Prompt e PowerShell di Windows
- **Zero dipendenze**: Colorama è una libreria leggera con zero dipendenze
- **Cross-platform**: Stesso comportamento su Windows, macOS e Linux
- **Ampio supporto per stili**: Colori, background, stili di testo (bright, dim, etc.)

## Esempio di utilizzo

```python
import logging
from home.logging_utils import ColoramaFormatter

# Configura un logger con colori
handler = logging.StreamHandler()
formatter = ColoramaFormatter(
    fmt="%(levelname)-8s %(asctime)s %(name)s %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)
handler.setFormatter(formatter)

logger = logging.getLogger("myapp")
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)

# Usa il logger
logger.debug("Messaggio di debug")
logger.info("Messaggio informativo")
logger.warning("Attenzione!")
logger.error("Si è verificato un errore")
logger.critical("Errore critico!")
```

## Schema dei colori

I colori utilizzati per i diversi livelli di log sono:

| Livello  | Colore          |
| -------- | --------------- |
| DEBUG    | Ciano           |
| INFO     | Verde           |
| WARNING  | Giallo          |
| ERROR    | Rosso           |
| CRITICAL | Rosso brillante |

## Note implementative

Il modulo gestisce automaticamente l'inizializzazione di colorama con `init(autoreset=False)` per garantire che i colori vengano resettati dopo ogni messaggio di log.

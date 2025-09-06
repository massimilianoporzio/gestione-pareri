# Esempi di Utilizzo

Questa directory contiene esempi pratici per aiutarti a comprendere come utilizzare le funzionalità integrate in questo
template Django.

## File di esempio disponibili

| File                 | Descrizione                                            |
| -------------------- | ------------------------------------------------------ |
| `logging_example.py` | Dimostra l'utilizzo del sistema di logging configurato |

## Come eseguire gli esempi

Gli esempi sono progettati per essere eseguiti dal livello root del progetto. Hai due opzioni:

### Utilizzando uv (consigliato)

```bash
# Esecuzione diretta senza attivare l'ambiente virtuale
uv run python examples/logging_example.py
```

### Utilizzando l'ambiente virtuale tradizionale

```bash
# Attiva l'ambiente virtuale
# Windows:
.\.venv\Scripts\Activate.ps1
# macOS/Linux:
source .venv/bin/activate
# Esegui l'esempio
python examples/logging_example.py
```

## Logging Example

L'esempio di logging mostra come utilizzare il sistema di logging configurato in questo template:

- Log colorati in console (quando DEBUG=True)
- Log su file (quando DEBUG=False)
- Diversi livelli di logging (DEBUG, INFO, WARNING, ERROR, CRITICAL)
- Logging di eccezioni con traceback
- Logging strutturato con informazioni aggiuntive Per modificare la modalità DEBUG:

1. Modifica il file `.env` nella radice del progetto
2. Imposta `DJANGO_DEBUG=1` per la modalità sviluppo (log colorati in console)
3. Imposta `DJANGO_DEBUG=0` per la modalità produzione (log salvati nel file)

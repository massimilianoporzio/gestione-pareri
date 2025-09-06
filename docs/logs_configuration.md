# Configurazione della Directory dei Log

## Panoramica

Il sistema di logging di questo progetto supporta la configurazione della directory dei log tramite variabili
d'ambiente. Questo permette una maggiore flessibilità durante il deployment in diversi ambienti.

## Configurazione Base

Di default, la directory dei log è impostata su `./logs/` relativa alla directory principale del repository. Questa
directory viene creata automaticamente se non esiste.

## Personalizzazione della Directory dei Log

### Tramite Variabile d'Ambiente

Puoi specificare una directory dei log personalizzata impostando la variabile d'ambiente `DJANGO_LOGS_DIR`:

```bash
# Windows PowerShell
$env:DJANGO_LOGS_DIR = "E:\percorso\personalizzato\logs"
# macOS/Linux
export DJANGO_LOGS_DIR="/percorso/personalizzato/logs"
```

### Tramite File .env

Puoi anche specificare la directory dei log nel file `.env`:

```env
DJANGO_LOGS_DIR=/percorso/personalizzato/logs
```

## Verifica della Configurazione

Puoi verificare che la directory dei log sia configurata correttamente utilizzando il comando make:

```bash
# Windows, macOS, Linux
make check-custom-logs LOGS_DIR="/percorso/personalizzato/logs" ENV=dev|test|prod
```

## Comportamento nei Diversi Ambienti

- **Ambiente di Sviluppo (dev)**: I log vengono scritti principalmente sulla console
- **Ambiente di Test (test)**: I log vengono scritti principalmente sulla console
- **Ambiente di Produzione (prod)**: I log vengono scritti principalmente su file nella directory configurata

## Note Importanti

1. Assicurati che il processo Django abbia i permessi di scrittura nella directory dei log specificata
2. In ambiente di produzione, è consigliabile configurare una rotazione dei log per evitare file di log troppo grandi
3. Se la directory specificata non esiste, il sistema tenterà di crearla automaticamente

## Risoluzione dei Problemi

Se riscontri problemi con la configurazione dei log:

1. Verifica che la variabile d'ambiente `DJANGO_LOGS_DIR` sia impostata correttamente
2. Controlla i permessi della directory specificata
3. Usa il comando `make check-custom-logs` per verificare la configurazione
4. Controlla i messaggi di output nella console all'avvio dell'applicazione

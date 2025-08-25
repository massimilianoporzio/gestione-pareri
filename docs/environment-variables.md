# Gestione delle Variabili d'Ambiente

Questo documento spiega come gestire le variabili d'ambiente nel progetto Django.

## Panoramica

Il progetto utilizza [python-decouple](https://github.com/henriquebastos/python-decouple) per gestire le variabili d'ambiente in modo sicuro. Questo approccio permette di:

- Separare la configurazione dal codice
- Avere impostazioni diverse per ambienti diversi (sviluppo, staging, produzione)
- Gestire dati sensibili senza esporli nel repository

## File `.env`

Il file `.env` contiene tutte le variabili d'ambiente utilizzate dall'applicazione. Questo file **non deve essere committato** nel repository per ragioni di sicurezza.

Un file `.env.example` è fornito come template con i valori predefiniti e commentati.

## Variabili d'Ambiente Principali

### Configurazioni di Base

- `DJANGO_SECRET_KEY`: La chiave segreta di Django usata per la crittografia
- `DJANGO_DEBUG`: Controlla la modalità debug (0=False, 1=True)

### Host e Origini Affidabili

- `DJANGO_ALLOWED_HOSTS`: Lista di host consentiti separati da virgola (usati quando DEBUG=False)
- `DJANGO_CSRF_TRUSTED_ORIGINS`: Domini affidabili per la protezione CSRF (usati quando DEBUG=False)

Esempio:

```bash
DJANGO_ALLOWED_HOSTS=example.com,api.example.com,127.0.0.1
DJANGO_CSRF_TRUSTED_ORIGINS=example.com,api.example.com
```

> **Nota**: In modalità debug (DJANGO_DEBUG=1), ALLOWED_HOSTS è automaticamente impostato a `localhost` e `127.0.0.1`, e CSRF_TRUSTED_ORIGINS è vuoto.

### Database (Opzionale)

- `DATABASE_URL`: URL di connessione al database (se diverso da SQLite)

### Email (Opzionale)

- `EMAIL_HOST`: Server SMTP per l'invio delle email
- `EMAIL_PORT`: Porta del server SMTP
- `EMAIL_HOST_USER`: Username per l'autenticazione SMTP
- `EMAIL_HOST_PASSWORD`: Password per l'autenticazione SMTP
- `EMAIL_USE_TLS`: Usa TLS per la connessione SMTP (0=False, 1=True)

## Come Utilizzare nel Codice

Le variabili d'ambiente possono essere utilizzate nel codice con la funzione `config()`:

```python
from decouple import config

# Stringa
SECRET_KEY = config("DJANGO_SECRET_KEY")

# Boolean
DEBUG = config("DJANGO_DEBUG", default=False, cast=bool)

# Integer
PORT = config("PORT", default=8000, cast=int)

# Con valore predefinito
API_KEY = config("API_KEY", default="default-key")
```

## Deployment

In ambienti di produzione, è possibile:

1. Utilizzare un vero file `.env` sul server
2. Impostare le variabili d'ambiente direttamente nel sistema
3. Utilizzare il sistema di configurazione del provider (es. Render, Heroku, ecc.)

Tutte queste opzioni funzioneranno con python-decouple senza modificare il codice.

# Configurazione Ambienti Django

Questo progetto utilizza una configurazione multi-ambiente per Django. È possibile selezionare l'ambiente utilizzando la
variabile d'ambiente `DJANGO_ENV`.

## Ambienti Disponibili

- **dev**: Ambiente di sviluppo (predefinito)
- **test**: Ambiente di test
- **prod**: Ambiente di produzione

## Variabili d'ambiente importanti

- `DJANGO_ENV`: Specifica l'ambiente (dev, test, prod)
- `DJANGO_SECRET_KEY`: Chiave segreta per Django
- `DJANGO_DEBUG`: Attiva/disattiva la modalità debug (1=attivo, 0=disattivo)
- `DJANGO_LOGS_DIR`: Directory dove vengono salvati i file di log (percorso assoluto o relativo)

## Esempi di utilizzo

### Utilizzando la riga di comando

#### Istruzioni per PowerShell

```powershell
$env:DJANGO_ENV="dev"; python manage.py runserver
$env:DJANGO_ENV="test"; python manage.py test
$env:DJANGO_ENV="prod"; python manage.py runserver
# Specificare la directory dei log
$env:DJANGO_LOGS_DIR="C:\path\to\logs"; python manage.py runserver
```

#### Istruzioni per Windows Command Line

```cmd
set DJANGO_ENV=dev && python manage.py runserver
set DJANGO_ENV=test && python manage.py test
set DJANGO_ENV=prod && python manage.py runserver
:: Specificare la directory dei log
set DJANGO_LOGS_DIR=C:\path\to\logs && python manage.py runserver
```

#### Istruzioni per Linux/macOS

```bash
DJANGO_ENV=dev python manage.py runserver
DJANGO_ENV=test python manage.py test
DJANGO_ENV=prod python manage.py runserver
# Specificare la directory dei log
DJANGO_LOGS_DIR=/path/to/logs python manage.py runserver
```

### Utilizzando il Makefile

Il progetto include target specifici nel Makefile per i diversi ambienti:

```bash
# Avviare il server in ambienti specifici
make run-dev       # Ambiente di sviluppo
make run-test      # Ambiente di test
make run-prod      # Ambiente di produzione
# Eseguire test in ambienti specifici
make test-dev      # Test in ambiente di sviluppo
make test-test     # Test in ambiente di test
make test-prod     # Test in ambiente di produzione
# Verificare la configurazione corrente
make check-env-dev   # Verifica ambiente di sviluppo
make check-env-test  # Verifica ambiente di test
make check-env-prod  # Verifica ambiente di produzione
```

## Configurazione dei file .env

È possibile configurare gli ambienti tramite file `.env`. Crea uno dei seguenti file nella root del progetto:

- `.env`: Configurazione principale
- `.env.local`: Configurazione locale (ignorata dal version control) Esempio di file `.env`:

```
DJANGO_ENV=dev
DJANGO_SECRET_KEY=your-secret-key
DJANGO_DEBUG=1
DJANGO_LOGS_DIR=/absolute/path/to/logs
```

...existing code from /Users/massi/progetti/deploy-django/src/README_SETTINGS.md...

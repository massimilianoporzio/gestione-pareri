# Guida Rapida - Template Django

Questa guida rapida ti aiuterà a iniziare velocemente con questo template Django.

## 🚀 Primi passi

### Clonare e configurare il repository

```bash
# Clona il repository
git clone <url-del-tuo-repository>
cd <nome-del-tuo-repository>
# Crea un ambiente virtuale con uv
# Attiva l'ambiente virtuale
# In Windows PowerShell:
.\.venv\Scripts\Activate.ps1
# In Linux/macOS:
source .venv/bin/activate
# Installa le dipendenze
uv sync
# Installa pre-commit
uv add pre-commit
pre-commit install
```

### Personalizzazione del modello User (opzionale, ma consigliato farlo prima)

Se desideri utilizzare un modello User personalizzato, questo è il momento di configurarlo **prima** di eseguire
qualsiasi migrazione:

```bash
# Modifica src/home/settings.py per aggiungere:
# AUTH_USER_MODEL = 'myapp.User'
# Crea la tua app
cd src
python manage.py startapp myapp
# Crea il tuo modello User personalizzato in src/myapp/models.py
# poi aggiungi l'app a INSTALLED_APPS in settings.py
```

### Eseguire le migrazioni

Una volta configurato tutto (e dopo aver creato eventuali modelli User personalizzati):

```bash
cd src
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
```

### Avviare il server di sviluppo

```bash
python manage.py runserver
```

Vai a [http://127.0.0.1:8000/](http://127.0.0.1:8000/) nel tuo browser.

## 📁 Struttura del progetto

- `src/`: Directory principale del codice sorgente
  - `manage.py`: Script di gestione Django
  - `home/`: Progetto Django principale
    - `settings.py`: Configurazioni del progetto
    - `urls.py`: Configurazione URL
    - `wsgi.py` e `asgi.py`: Entry points per server web
- `.vscode/`: Configurazioni VS Code
- `.github/workflows/`: Pipeline CI/CD
- `pyproject.toml`: Configurazioni strumenti Python
- `.pre-commit-config.yaml`: Configurazione pre-commit

## 🔄 Workflow di sviluppo consigliato

1. **Crea una nuova app Django**:

```bash
   cd src
   python manage.py startapp myapp
   ```

1. **Aggiungi l'app a `INSTALLED_APPS`** in `src/home/settings.py`:

```python
   INSTALLED_APPS = [
       # ...
       'myapp',
   ]
   ```

1. **Definisci modelli** in `src/myapp/models.py`
2. **Crea e applica migrazioni**:

```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

1. **Crea viste** in `src/myapp/views.py`
2. **Configura URL** in `src/myapp/urls.py` e `src/home/urls.py`
3. **Crea template** in `src/myapp/templates/`
4. **Scrivi test** in `src/myapp/tests.py`
5. **Esegui test**:

```bash
   python manage.py test
   ```

1. **Commit delle modifiche**:

```bash
    git add .
    git commit -m "Descrizione delle modifiche"
    ```

(pre-commit eseguirà automaticamente i check di qualità)

## 🛠️ Comandi utili

```bash
# Avvia shell Django
python manage.py shell
# Crea superuser
python manage.py createsuperuser
# Controlla problemi di sicurezza
python manage.py check --deploy
# Raccogli file statici
python manage.py collectstatic
# Esegui test
python manage.py test
# Esegui manualmente pre-commit
pre-commit run --all-files
```

## 📚 Risorse utili

- [Documentazione Django](https://docs.djangoproject.com/)
- [Tutorial Django](https://docs.djangoproject.com/en/5.2/intro/tutorial01/)
- [Django REST framework](https://www.django-rest-framework.org/) (se necessario per API)

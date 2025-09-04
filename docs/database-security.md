# 🔐 Database Setup - Sicurezza Password

Questo progetto utilizza un sistema sicuro per gestire le password PostgreSQL senza esporle nel
repository.

## 📋 File e Sicurezza

### ✅ File SICURI (committati nel repo)

- `update_postgresql_staging.template.sql` - Template senza password
- `docs/postgresql-setup-commands.md` - Guida con placeholder
- `tools/generate_db_passwords.py` - Generatore password sicure

### ❌ File SENSIBILI (ignorati da git)

- `update_postgresql_staging.sql` - Script con password reali
- `.env` - Configurazioni ambiente con password

## 🚀 Workflow Sicuro

### 1. Genera Password

```bash
just generate-db-passwords
```

### 2. Crea Script SQL con Password Reali

```bash
just create-db-script
```

Questo comando:

- Copia il template
- Genera nuove password sicure
- Sostituisce i placeholder con password reali
- Crea `update_postgresql_staging.sql` (ignorato da git)

### 3. Esegui Setup PostgreSQL

```bash
# Opzione A: Script automatico
psql -U postgres -h localhost -f update_postgresql_staging.sql
# Opzione B: Comandi manuali
# Usa i comandi da docs/postgresql-setup-commands.md
```

### 4. Pulisci dopo l'uso

```bash
# Elimina il file con password dopo l'uso
Remove-Item update_postgresql_staging.sql
```

## 🔒 Sicurezza

- Le password vengono generate con 32-40 caratteri casuali
- Usano caratteri alfanumerici + simboli sicuri per SQL
- I file con password non vengono mai committati
- Template e guide sono sicure per il repository pubblico

## 🌍 Setup Ambienti

Dopo il setup PostgreSQL hai 4 ambienti:

| Ambiente | Comando            | Database   | Note            |
| -------- | ------------------ | ---------- | --------------- |
| DEV      | `just run-dev`     | SQLite     | Sviluppo rapido |
| TEST     | `just run-test`    | SQLite     | Test veloci     |
| STAGING  | `just run-staging` | PostgreSQL | Pre-produzione  |
| PROD     | `just run-prod`    | PostgreSQL | Produzione      |

## ⚠️ Importante

- Il file `.env` contiene le password e NON deve essere committato
- Usa sempre `just generate-db-passwords` per nuove password
- Elimina `update_postgresql_staging.sql` dopo l'uso
- Il template è sicuro per il repository

## 🔑 Django SECRET_KEY Security

### Perché SECRET_KEY diverse per ambiente?

- **Sicurezza**: Compromissione di un ambiente non espone gli altri
- **Isolamento**: Sessioni/cookie non condivisi tra ambienti
- **Best Practice**: Standard di sicurezza Django

### 1. Genera SECRET_KEY per tutti gli ambienti

```bash
# Una sola SECRET_KEY generica
just generate-secret-key
# SECRET_KEY per tutti e 4 gli ambienti (RACCOMANDATO)
just generate-secret-keys-all
```

### 2. Configurazione .env

Aggiungi al file `.env`:

```bash
# SECRET_KEY per ogni ambiente
DJANGO_SECRET_KEY_DEV=your_dev_secret_key_here
DJANGO_SECRET_KEY_TEST=your_test_secret_key_here
DJANGO_SECRET_KEY_STAGING=your_staging_secret_key_here
DJANGO_SECRET_KEY_PROD=your_production_secret_key_here
```

### 3. Configurazione Django Settings

I file settings devono essere aggiornati per usare SECRET_KEY specifiche:

```python
# In src/home/settings/dev.py
SECRET_KEY = config("DJANGO_SECRET_KEY_DEV",
                   default=config("DJANGO_SECRET_KEY",
                                 default=get_random_secret_key()))
# In src/home/settings/test.py
SECRET_KEY = config("DJANGO_SECRET_KEY_TEST",
                   default=config("DJANGO_SECRET_KEY",
                                 default=get_random_secret_key()))
# In src/home/settings/staging.py
SECRET_KEY = config("DJANGO_SECRET_KEY_STAGING",
                   default=config("DJANGO_SECRET_KEY",
                                 default=get_random_secret_key()))
# In src/home/settings/prod.py
SECRET_KEY = config("DJANGO_SECRET_KEY_PROD",
                   default=config("DJANGO_SECRET_KEY",
                                 default=get_random_secret_key()))
```

### 🔒 Sicurezza SECRET_KEY

- **Mai committare** SECRET_KEY nel repository
- **Diversa per ogni ambiente** per isolamento
- **Rotazione periodica** in produzione
- **Backup sicuro** delle chiavi di produzione

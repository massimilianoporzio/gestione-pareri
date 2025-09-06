# Guida Completa ai Test - Gestione Pareri

Una guida comprensiva su come, quando e perché utilizzare i test nel progetto.

## Indice

- [Overview](#overview)
- [Setup Test Environment](#setup-test-environment)
- [Esecuzione Test](#esecuzione-test)
- [Tipologie di Test](#tipologie-di-test)
- [Test Coverage](#test-coverage)
- [Best Practices](#best-practices)
- [Debugging Test](#debugging-test)
- [CI/CD Integration](#cicd-integration)

## Overview

Il sistema di test garantisce la qualità e affidabilità del codice prima del deploy su IIS in ambiente aziendale ASL.

## Perché i Test Sono Critici

- ✅ **Sicurezza Aziendale**: Validazione domini @aslcn1.it
- ✅ **Conformità ASL**: Gestione dati sanitari sicura
- ✅ **Performance IIS**: Ottimizzazione per Windows Server
- ✅ **Reliability**: Zero downtime in ambiente produzione

## Test Coverage

**Statistiche Test**

- 42 test totali
- 100% success rate
- 9 classi di test
- 8 aree funzionali coperte

## Best Practices

(Sezione in costruzione)

## Setup Test Environment

### Configurazione Base

**Impostazioni di test ottimizzate**

```bash
# Settings di test ottimizzate
File: src/home/settings/test_local.py
- SQLite in memoria (veloce)
- Password hasher MD5 (test only)
- Cache dummy
- Email backend in memoria
```

### **Dipendenze Test**

Tutte le dipendenze sono già configurate in `pyproject.toml`:

- `django-concurrency`: Test ottimistic locking
- `django-crum`: Test audit fields
- Django test framework integrato

## Esecuzione Test

### Comandi Rapidi

**Esegui test completi (raccomandato)**

```bash
# Test completi (raccomandato)
cd e:\progetti\gestione-pareri\src
uv run manage.py test accounts --settings=home.settings.test_local
# Test specifici
uv run manage.py test accounts.tests.SecurityTest --settings=home.settings.test_local
uv run manage.py test accounts.tests.PerformanceTest --settings=home.settings.test_local
```

### Comandi Just Multi-Ambiente

**Test ambiente DEV (SQLite locale)**

```bash
just test-dev
# Test ambiente TEST (configurazione test)
just test-test
# Test ambiente STAGING (PostgreSQL)
just test-staging
# Test ambiente PROD (PostgreSQL produzione)
just test-prod
```

### Output Test Tipico

```text
Found 42 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
................................🚀 Inizializzazione gruppi e permessi...
✅ Tutti i permessi assegnati al gruppo 'Full Access Admin'
.......
----------------------------------------------------------------------
Ran 42 tests in 0.665s
OK ✅
```

## Tipologie di Test

### 1. CustomUserModelTest (9 test)

**Quando eseguire**: Sempre prima di modifiche al modello User

```python
# Test validazione email aziendale
def test_create_user_invalid_email_domain(self):
    with self.assertRaises(ValidationError):
        CustomUser.objects.create_user(email="test@gmail.com")
```

**Copre**:

- ✅ Validazione domini @aslcn1.it
- ✅ Creazione superuser
- ✅ Campi di audit (created_by, updated_by)
- ✅ Controllo versioni (django-concurrency)

### 2. CustomUserAuthenticationTest (4 test)

**Quando eseguire**: Prima di modifiche al sistema di login

```python
# Test login con email invece di username
def test_authenticate_with_email(self):
    user = authenticate(username=self.valid_email, password=self.password)
    self.assertEqual(user, self.user)
```

**Copre**:

- ✅ Autenticazione via email
- ✅ Sicurezza password
- ✅ Utenti attivi/inattivi

### 3. CustomUserFormsTest (6 test)

**Quando eseguire**: Prima di modifiche ai form admin

```python
# Test validazione form con dominio errato
def test_custom_authentication_form_invalid_domain(self):
    form = CustomAuthenticationForm(data={
        'username': 'test@gmail.com',  # ❌ Dominio non aziendale
        'password': 'password'
    })
    self.assertFalse(form.is_valid())
```

**Copre**:

- ✅ Form di login
- ✅ Form creazione utenti
- ✅ Validazioni client-side

### 4. GroupsPermissionsTest (4 test)

**Quando eseguire**: Prima di modifiche ai permessi

```python
# Test creazione gruppo Full Access Admin
def test_full_access_group_creation(self):
    call_command('init_groups_permissions')
    full_access_group = Group.objects.get(name="Full Access Admin")
    self.assertEqual(full_access_group.permissions.count(), 24)
```

**Copre**:

- ✅ Creazione gruppi automatica
- ✅ Assegnazione permessi
- ✅ Management command

### 5. SecurityTest (6 test) - CRITICO PER IIS

**Quando eseguire**: Prima di ogni deploy produzione

```python
# Test validazione domini rigorosa
def test_email_domain_validation(self):
    invalid_emails = [
        "test@aslcn2.it",      # ❌ Dominio simile
        "test@sub.aslcn1.it"   # ❌ Sottodominio
    ]
    for email in invalid_emails:
        with self.assertRaises(ValidationError):
            CustomUser.objects.create_user(email=email)
```

**Copre**:

- 🔒 Protezione CSRF
- 🔒 Password hashing sicuro
- 🔒 Validazione domini ultra-rigorosa
- 🔒 Permessi superuser

### 6. PerformanceTest (2 test) - CRITICO PER IIS

**Quando eseguire**: Prima di deploy su IIS Windows Server

```python
# Test performance bulk operations
def test_bulk_user_creation(self):
    # Crea 20 utenti in blocco
    CustomUser.objects.bulk_create(users_data)
    # Deve essere < 1 secondo
    self.assertLess(end_time - start_time, 1.0)
```

**Copre**:

- ⚡ Operazioni bulk (import personale)
- ⚡ Ottimizzazione query (evita N+1)
- ⚡ Performance database

## Quando Eseguire i Test

### Prima di Ogni Commit

**Test rapidi - sicurezza base**

```bash
uv run manage.py test accounts.tests.SecurityTest --settings=home.settings.test_local
```

### Prima di Deploy Staging

**Test completi - tutti gli ambienti**

```bash
just test-staging
```

### Prima di Deploy Produzione IIS - OBBLIGATORIO

**Test completi con tutte le configurazioni**

```bash
uv run manage.py test accounts --settings=home.settings.test_local
just test-prod  # Test su PostgreSQL produzione
```

### Dopo Modifiche al CustomUser

**Test modello + autenticazione + sicurezza**

```bash
uv run manage.py test accounts.tests.CustomUserModelTest accounts.tests.SecurityTest --settings=home.settings.test_local
```

### Dopo Modifiche ai Permessi

**Test gruppi + admin**

```bash
uv run manage.py test accounts.tests.GroupsPermissionsTest accounts.tests.AdminIntegrationTest --settings=home.settings.test_local
```

## Test di Sicurezza Critica

### Validazione Domini - ZERO TOLLERANZA

### Questi email devono fallire

```python
# ❌ QUESTI EMAIL DEVONO FALLIRE
invalid_emails = [
    "admin@gmail.com",           # Email pubblico
    "test@yahoo.com",            # Email pubblico
    "user@aslcn2.it",           # ASL diversa
    "admin@aslcn1.com",         # Estensione diversa
    "user@sub.aslcn1.it",       # Sottodominio
    "hacker@aslcn1.it.evil.com" # Domain spoofing
]
```

### Performance - Soglie IIS

### Requisiti di performance

```python
# ⚡ PERFORMANCE REQUIREMENTS
Bulk creation: < 1 secondo per 20 utenti
Query count: < 10 queries per 5 utenti
Memory usage: SQLite in memoria per test
Response time: Admin deve caricare < 2 secondi
```

## Debugging Test

### Test Falliti - Troubleshooting

### Verbosità alta per debug

```bash
uv run manage.py test accounts.tests.SecurityTest --settings=home.settings.test_local --verbosity=2
# Test specifico singolo
uv run manage.py test accounts.tests.SecurityTest.test_email_domain_validation --settings=home.settings.test_local
```

### Problemi Comuni

### 1. Database Permission Error

```text
Got an error creating the test database: ERRORE: permesso di creare il database negato
```

**Soluzione**: Usa `--settings=home.settings.test_local` (SQLite) **2. Import Errors**

```text
ModuleNotFoundError: No module named 'accounts'
```

**Soluzione**: Esegui dalla directory `src/` **3. CSRF Test Failed**

```text
AssertionError: 200 != 403
```

**Soluzione**: CSRF disabilitato in test - normale comportamento

## CI/CD Integration

### GitHub Actions (Futuro)

### Esempio workflow GitHub Actions

```yaml
# .github/workflows/test.yml
- name: Run Security Tests
    run: |
        cd src
        uv run manage.py test accounts.tests.SecurityTest --settings=home.settings.test_local
- name: Run Performance Tests
    run: |
        cd src
        uv run manage.py test accounts.tests.PerformanceTest --settings=home.settings.test_local
```

### Pre-Deploy Checklist

### Checklist pre-deploy

```bash
# 1. Test sicurezza
✅ SecurityTest (6/6)
# 2. Test performance
✅ PerformanceTest (2/2)
# 3. Test integrazione
✅ AdminIntegrationTest (3/3)
# 4. Test completi
✅ All tests (42/42)
```

## Conformità ASL

### Requisiti Specifici Aziendali

- 🔒 **Solo personale @aslcn1.it** può accedere
- 📊 **Audit trail completo** (chi/quando/cosa)
- ⚡ **Performance ottimale** su IIS Windows Server
- 🛡️ **Sicurezza massima** per dati sanitari

#### Test di Conformità

I nostri test garantiscono:

- ✅ Zero accessi non autorizzati (domini esterni)
- ✅ Tracciabilità completa delle azioni
- ✅ Performance adeguata per carico ASL
- ✅ Sicurezza standard sanitario

## Support & Troubleshooting

### Comandi di emergenza

```bash
# Test rapido pre-deploy
just test
# Test completo pre-produzione
uv run manage.py test accounts --settings=home.settings.test_local
# Verifica configurazione
just check-env-dev
```

#### Contatti

- **Setup Test**: Vedi questa guida
- **Problemi Performance**: Controllare PerformanceTest
- **Problemi Sicurezza**: Verificare SecurityTest
- **Deploy IIS**: Tutti i test devono passare ✅

---

> **⚠️ IMPORTANTE**: Prima di ogni deploy su IIS in produzione, TUTTI i 42 test devono passare. Zero tolleranza per
> errori di sicurezza in ambiente ospedaliero ASL.

## 🔒 Security Scan con Bandit

Questo progetto integra **Bandit** per il controllo automatico delle vulnerabilità di sicurezza nel codice Python.

### Come eseguire la scansione Bandit

- Usa la ricetta Just:

  ```bash
  just security-scan
  ```

- Bandit analizzerà tutti i file Python e segnalerà eventuali problemi di sicurezza.

### Ignorare falsi positivi Bandit

- Puoi aggiungere il commento `# nosec` su una riga per ignorare un warning specifico.

### Documentazione Bandit

- [Guida Bandit](https://bandit.readthedocs.io/en/latest/)
- [Ricetta security-scan](justfile)

## 🔒 Controllo vulnerabilità dipendenze con Safety

Questo progetto integra **Safety** per il controllo automatico delle vulnerabilità nelle dipendenze Python.

### Come eseguire la scansione Safety

- Usa la ricetta Just:

  ```bash
  just safety-scan
  ```

- Safety analizzerà le dipendenze e segnalerà eventuali CVE o problemi di sicurezza.

### Documentazione Safety

- [Guida Safety](https://github.com/pyupio/safety)

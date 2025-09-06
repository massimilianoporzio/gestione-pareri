# Guida ai test

Questa guida fornisce una panoramica minima sui test.

## Esecuzione dei test

Per progetti Python/Django, puoi usare `pytest` o il test runner di Django.

```bash
pytest
```

## Copertura dei test

La copertura dei test indica la percentuale di codice eseguita dai test. Per misurarla, usa `coverage.py`.

```bash
coverage run -m pytest
coverage report
coverage html  # Genera un report HTML
```

## Best practice

- Scrivi test per ogni funzionalità importante.
- Usa nomi chiari per i test.
- Mantieni i test indipendenti tra loro.
- Esegui i test prima di ogni commit.
- Mantieni la copertura sopra l’80%.

---

Per domande o problemi, consulta la documentazione ufficiale dei tool o chiedi ai tuoi colleghi!

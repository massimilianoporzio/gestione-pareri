# Deploy Django

Un progetto Django configurato per il deployment e lo sviluppo con strumenti moderni.

## Requisiti

- Python 3.13+
- [uv](https://github.com/astral-sh/uv) - Gestore di pacchetti Python veloce e moderno

## Setup iniziale

1. Clona il repository
2. Installa le dipendenze:

```bash
uv venv
uv sync
```

3. Installa pre-commit:

```bash
uv add pre-commit
pre-commit install
```

## Strumenti di sviluppo

Questo progetto utilizza diversi strumenti per garantire la qualità del codice:

- **black**: Formattatore di codice Python
- **isort**: Formattatore di import Python
- **flake8**: Linter Python
- **ruff**: Linter Python veloce
- **pylint**: Linter Python avanzato
- **djlint**: Formattatore e linter per template HTML Django

## Formattazione dei template HTML

Per formattare automaticamente i template HTML Django:

- I template vengono formattati automaticamente durante il pre-commit
- In VS Code, i file HTML vengono formattati al salvataggio utilizzando l'estensione "Run on Save"

## CI/CD

Il repository include una configurazione GitHub Actions che esegue automaticamente i check di pre-commit su ogni pull request e push ai branch principali.

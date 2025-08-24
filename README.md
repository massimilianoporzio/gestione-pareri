# Deploy Django

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=flat)](https://pycqa.github.io/isort/)
[![flake8](https://img.shields.io/badge/linting-flake8-yellowgreen)](https://github.com/PyCQA/flake8)
[![ruff](https://img.shields.io/badge/ruff-enabled-blueviolet)](https://github.com/charliermarsh/ruff)
[![pylint](https://img.shields.io/badge/pylint-enabled-orange)](https://github.com/PyCQA/pylint)
[![djlint](https://img.shields.io/badge/djlint-HTML%20linting-blue)](https://github.com/Riverside-Healthcare/djlint)
[![Django](https://img.shields.io/badge/Django-5.2.0-green.svg)](https://www.djangoproject.com/)
[![Python 3.13+](https://img.shields.io/badge/python-3.13+-blue.svg)](https://www.python.org/downloads/release/python-3130/)
[![uv](https://img.shields.io/badge/uv-package%20manager-blueviolet)](https://github.com/astral-sh/uv)
[![Pre-commit](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/pre-commit.yml)
[![Django CI](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml/badge.svg)](https://github.com/massimilianoporzio/deploy-django/actions/workflows/django.yml)
[![pre-commit-hooks](https://img.shields.io/badge/pre--commit--hooks-enabled-brightgreen)](https://github.com/pre-commit/pre-commit-hooks)
[![VS Code](https://img.shields.io/badge/VS%20Code-Ready-007ACC?logo=visual-studio-code)](https://code.visualstudio.com/)
[![Run on Save](https://img.shields.io/badge/Run%20on%20Save-enabled-success)](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%20enabled-2088FF)](https://github.com/features/actions)

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

# VS Code Configurazione Dettagliata

[![VS Code](https://img.shields.io/badge/VS%20Code-Ready-007ACC?logo=visual-studio-code)](https://code.visualstudio.com/)

Questo template include configurazioni VS Code ottimizzate per lo sviluppo Django con Python.

## 🎯 Funzionalità Integrate

1. ✅ **Formattazione automatica** al salvataggio per tutti i file
2. ✅ **Evidenziazione errori** in tempo reale con Error Lens
3. ✅ **Configurazioni specifiche** per ciascun linter/formattatore
4. ✅ **"Run on Save"** per formattare automaticamente i template HTML Django
5. ✅ **Python intellisense** con supporto completo Django

## 📦 Estensioni VS Code Consigliate

Il progetto è configurato per funzionare con le seguenti estensioni:

| Estensione      | ID                               | Descrizione                                       |
| --------------- | -------------------------------- | ------------------------------------------------- |
| Black Formatter | `ms-python.black-formatter`      | Formatta il codice Python utilizzando Black       |
| isort           | `ms-python.isort`                | Organizza automaticamente gli import Python       |
| Pylint          | `ms-python.pylint`               | Analizzatore di codice Python per rilevare errori |
| Ruff            | `charliermarsh.ruff`             | Linter Python ultrarapido                         |
| Error Lens      | `usernamehw.errorlens`           | Evidenzia errori e avvisi direttamente nel codice |
| Git Graph       | `mhutchie.git-graph`             | Visualizza il grafico dei commit di Git           |
| markdownlint    | `davidanson.vscode-markdownlint` | Linting per file Markdown                         |
| Prettier        | `esbenp.prettier-vscode`         | Formattore di codice per vari linguaggi           |
| Run On Save     | `emeraldwalk.RunOnSave`          | Esegue comandi quando si salva un file            |
| Django          | `batisteo.vscode-django`         | Supporto per template e sintassi Django           |

## ⚙️ Configurazione `.vscode/settings.json`

La cartella `.vscode` contiene il file `settings.json` che configura automaticamente l'editor:

```json
{
  // Configurazione per file HTML e Django templates
  "[html]": { "editor.formatOnSave": false },
  "[django-html]": { "editor.formatOnSave": false },

  // Run on Save - esegue formattatori quando si salvano i file
  "emeraldwalk.runonsave": {
    "commands": [
      // Formatta HTML/Django templates con djlint
      {
        "match": "\\.(html|djhtml|django-html)$",
        "cmd": "uv run djlint \"${file}\" --reformat --ignore H030"
      },
      // Organizza import Python con isort
      { "match": "\\.py$", "cmd": "uv run isort \"${file}\"" },
      // Formatta Markdown con Prettier e markdownlint
      {
        "match": "\\.(md|markdown)$",
        "cmd": "prettier --write \"${file}\" && markdownlint-cli2-fix \"${file}\""
      }
    ]
  },

  // Configurazione Python (Black, Pylint, isort)
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.formatOnSave": true
  },
  "black-formatter.args": ["--line-length=120"],
  "python.linting.pylintEnabled": true,
  "python.linting.enabled": true,

  // Configurazione Markdown (Prettier)
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  }
}
```

## 🔄 Formattazione Automatica

### Template HTML Django

I template HTML Django vengono formattati automaticamente in due modi:

1. **Durante il pre-commit**: Ogni commit esegue djlint sui template modificati
2. **In VS Code**: Al salvataggio di un file HTML, viene eseguito djlint tramite "Run on Save"

### File Python

- **Black**: Formattazione automatica al salvataggio
- **isort**: Organizzazione import automatica al salvataggio
- **Pylint**: Analisi errori in tempo reale

### File Markdown

- **Prettier**: Formattazione automatica al salvataggio
- **markdownlint**: Correzione automatica problemi al salvataggio

## 🎨 Personalizzazione

### Personalizzare Formattazione

Per personalizzare la formattazione, modifica `.vscode/settings.json`:

```json
{
  // Esempio: disabilita formattazione automatica Python
  "[python]": {
    "editor.formatOnSave": false
  },

  // Esempio: cambia lunghezza linea Black
  "black-formatter.args": ["--line-length=100"]
}
```

### Aggiungere Nuovi Formattatori

Per aggiungere formattatori per altri linguaggi:

```json
{
  "emeraldwalk.runonsave": {
    "commands": [
      // Esempio: formattatore JavaScript
      {
        "match": "\\.(js|ts)$",
        "cmd": "npx prettier --write \"${file}\""
      }
    ]
  }
}
```

## 🚀 Workflow di Sviluppo

### 1. Setup Iniziale

1. Apri il progetto in VS Code
2. Installa le estensioni consigliate (VS Code ti chiederà automaticamente)
3. Il sistema di formattazione è pronto!

### 2. Sviluppo Quotidiano

- **Salva qualsiasi file** → formattazione automatica
- **Commit codice** → pre-commit hooks attivi
- **Errori evidenziati** → Error Lens mostra problemi inline

### 3. Quality Check

```bash
# Verifica qualità codice completa
just stats

# Correzione automatica problemi
just fix-all
```

## 🔧 Troubleshooting

### Problema: "Run on Save non funziona"

1. Verifica che l'estensione `emeraldwalk.RunOnSave` sia installata
2. Controlla che `uv` sia disponibile nel PATH
3. Riavvia VS Code

### Problema: "Formattazione Python non attiva"

1. Verifica estensioni Python installate:
   - `ms-python.black-formatter`
   - `ms-python.isort`
   - `ms-python.pylint`
2. Controlla configurazione in `.vscode/settings.json`

### Problema: "Errori non evidenziati"

1. Installa `usernamehw.errorlens`
2. Verifica che i linter siano configurati e funzionanti

## 📚 Risorse Aggiuntive

- [VS Code Python Tutorial](https://code.visualstudio.com/docs/python/python-tutorial)
- [Django in VS Code](https://code.visualstudio.com/docs/python/tutorial-django)
- [Run On Save Extension](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave)

## 🔗 File Correlati

- [`.vscode/settings.json`](../.vscode/settings.json) - Configurazione VS Code
- [`docs/just.md`](just.md) - Task runner commands
- [`docs/environment-variables.md`](environment-variables.md) - Configurazione ambiente

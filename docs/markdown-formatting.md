# Formattazione Markdown

Questo progetto utilizza strumenti automatici per garantire la consistenza e la qualità dei file Markdown.

## Strumenti utilizzati

- **Prettier**: Formatta automaticamente i file Markdown per garantire uno stile coerente
- **markdownlint-cli2**: Verifica la conformità dei file Markdown alle best practice e corregge problemi automaticamente

## Configurazione

### Prettier

La configurazione di Prettier si trova nel file `.prettierrc.json` nella root del progetto. Le principali impostazioni per Markdown sono:

```json
{
  "printWidth": 100,
  "proseWrap": "preserve",
  "overrides": [
    {
      "files": "*.md",
      "options": {
        "proseWrap": "preserve"
      }
    }
  ]
}
```

### markdownlint-cli2

La configurazione di markdownlint-cli2 si trova nel file `.markdownlint-cli2.jsonc` nella root del progetto. Le principali regole configurate sono:

```jsonc
{
  "config": {
    "default": true,
    "MD013": false, // Disabilita il controllo della lunghezza della riga
    "MD012": false, // Consenti più righe vuote consecutive
    "MD003": { "style": "consistent" }, // Permetti diversi stili di titoli
    "MD049": { "style": "consistent" }, // Permetti enfasi con underscore e asterisco
    "MD050": { "style": "consistent" }, // Permetti enfasi con underscore e asterisco
  },
}
```

## Formattazione automatica

### In VS Code

I file Markdown vengono formattati automaticamente al salvataggio grazie all'estensione "Run on Save". La configurazione si trova in `.vscode/settings.json`:

```json
{
  "emeraldwalk.runonsave": {
    "commands": [
      {
        "match": "\\.(md|markdown)$",
        "cmd": "prettier --write \"${file}\" && markdownlint-cli2-fix \"${file}\""
      }
    ]
  },
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  }
}
```

### Con pre-commit

I file Markdown vengono formattati automaticamente durante i commit grazie ai hook di pre-commit configurati in `.pre-commit-config.yaml`:

```yaml
# Markdown formatter using Prettier
- repo: https://github.com/pre-commit/mirrors-prettier
  rev: v4.0.0-alpha.8
  hooks:
    - id: prettier
      name: prettier (markdown)
      types: [markdown]
      additional_dependencies:
        - prettier@3.2.5

# Markdown linting
- repo: https://github.com/DavidAnson/markdownlint-cli2
  rev: v0.12.1
  hooks:
    - id: markdownlint-cli2
      name: markdownlint
      types: [markdown]
```

## Installazione degli strumenti

Per utilizzare la formattazione automatica in VS Code, è necessario installare gli strumenti a livello globale:

```bash
# Windows (PowerShell)
.\scripts\install-markdown-tools.ps1

# macOS/Linux (Bash)
chmod +x scripts/install-markdown-tools.sh
./scripts/install-markdown-tools.sh

# Oppure manualmente su qualsiasi piattaforma
npm install -g prettier markdownlint-cli2
```

## Estensioni VS Code consigliate

- **markdownlint** di David Anson
- **Prettier - Code formatter** di Prettier
- **Run On Save** di emeraldwalk

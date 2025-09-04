# Configurazione VS Code per Django

Questo documento descrive la configurazione VS Code inclusa in questo template Django.

## 🔧 Estensioni VS Code consigliate

Questo template è configurato per funzionare al meglio con le seguenti estensioni VS Code:

1. **Black Formatter** - Formattazione automatica del codice Python
   - ID: `ms-python.black-formatter`
   - Formatta il codice Python secondo lo standard Black

2. **isort** - Organizzazione automatica degli import Python
   - ID: `ms-python.isort`
   - Ordina e raggruppa gli import Python in modo coerente

3. **Pylint** - Linting avanzato per Python
   - ID: `ms-python.pylint`
   - Individua errori, bug e problemi di stile nel codice Python

4. **Ruff** - Linter Python ultra-veloce
   - ID: `charliermarsh.ruff`
   - Alternativa moderna a flake8, con migliori performance

5. **Error Lens** - Evidenziazione errori in tempo reale
   - ID: `usernamehw.errorlens`
   - Mostra gli errori direttamente nel codice senza dover passare il mouse sopra

6. **Git Graph** - Visualizzazione grafica della storia Git
   - ID: `mhutchie.git-graph`
   - Visualizza la cronologia dei commit e i branch in modo grafico

7. **markdownlint** - Linting per i file Markdown
   - ID: `davidanson.vscode-markdownlint`
   - Verifica la correttezza e la coerenza dei file Markdown

## ⚙️ Configurazioni

Le configurazioni VS Code si trovano nella cartella `.vscode/settings.json` e includono:

### Formattazione automatica

```json
"editor.formatOnSave": true,
"[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter"
},
```

### Configurazione isort

```json
"isort.args": [
    "--profile", "black"
],
```

### Configurazione Run on Save per i template HTML

```json
"emeraldwalk.runonsave": {
    "commands": [
        {
            "match": "\\.html$",
            "cmd": "djlint ${file} --reformat"
        }
    ]
}
```

### Configurazione Pylint

```json
"pylint.args": [
    "--disable=C0111",
    "--max-line-length=88"
]
```

## 🔄 Workflow di sviluppo

Con questa configurazione, il tuo workflow di sviluppo sarà:

1. Scrivi il codice
2. Salva il file - vengono applicati automaticamente:
   - Formattazione Black per i file Python
   - Ordinamento degli import con isort
   - Formattazione djlint per i template HTML
3. Visualizza errori/avvisi in tempo reale grazie a Error Lens
4. Quando fai commit, pre-commit esegue controlli aggiuntivi

## 🛠️ Risoluzione problemi

Se riscontri problemi con la formattazione automatica:

1. Verifica che le estensioni consigliate siano installate
2. Riavvia VS Code dopo l'installazione delle estensioni
3. Assicurati che la formattazione automatica al salvataggio sia abilitata
4. Controlla il log di output di VS Code per eventuali errori

# Generazione automatica di docstring

Il progetto include un sistema automatico per aggiungere docstring ai file Python che ne sono privi. Questo sistema utilizza l'estensione "Run on Save" di VS Code per eseguire uno script personalizzato ogni volta che un file Python viene salvato.

## Come funziona

1. Quando salvi un file Python, l'estensione "Run on Save" esegue automaticamente:
   - isort per ordinare gli import
   - lo script `add_docstring.py` che aggiunge una docstring a livello di modulo se non è presente

2. Lo script analizza il file e aggiunge una docstring in formato standard che include:
   - Un titolo basato sul nome del file
   - Una descrizione generale delle funzionalità del modulo

## Configurazione

La configurazione è già impostata nel file `.vscode/settings.json`. Se desideri modificare il comportamento dello script, puoi modificare:

- `tools/add_docstring.py`: Lo script Python principale che genera le docstring
- `tools/add_docstring.bat`: Script batch per Windows
- `tools/add_docstring.sh`: Script shell per Linux/macOS

## Personalizzazione

Per personalizzare il formato delle docstring generate, modifica la funzione `add_module_docstring` nel file `tools/add_docstring.py`. Puoi modificare:

- Il formato della docstring
- Le informazioni incluse nella docstring
- La logica di generazione del contenuto

## Generazione in batch per tutti i file

Per aggiungere docstring a tutti i file Python del progetto in un'unica operazione, puoi utilizzare:

```bash
make add-docstrings
```

Questo comando:

- Cerca ricorsivamente tutti i file Python nel progetto
- Aggiunge docstring a tutti i file che ne sono privi
- Esclude i file `__init__.py` e i file in directory come `.venv`, `migrations`, ecc.
- Funziona su tutte le piattaforme (Windows, Linux, macOS)

Puoi anche eseguire lo script direttamente con opzioni aggiuntive:

```bash
# Mostra informazioni dettagliate durante l'elaborazione
python tools/add_docstring_batch.py --verbose

# Simula l'esecuzione senza apportare modifiche
python tools/add_docstring_batch.py --dry-run

# Elabora solo una directory specifica
python tools/add_docstring_batch.py src/app
```

## Note

- Attualmente, lo script aggiunge solo docstring a livello di modulo
- Le docstring esistenti non vengono sovrascritte
- In futuro, lo script potrebbe essere esteso per aggiungere docstring anche a classi e funzioni

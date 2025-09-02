# Utilizzo di Make

[![Make](https://img.shields.io/badge/Make-automation-brightgreen)](https://www.gnu.org/software/make/)

Questo progetto include un `Makefile` che semplifica l'esecuzione di comandi comuni. Make è uno strumento per l'automazione che ti permette di eseguire comandi complessi utilizzando semplici alias.

## Comandi disponibili

| Comando               | Descrizione                                | Utilizzo                         |
| --------------------- | ------------------------------------------ | -------------------------------- |
| `make run-server`     | Avvia il server di sviluppo Django         | Esegui dalla radice del progetto |
| `make test`           | Esegue i test del progetto                 | Esegui dalla radice del progetto |
| `make migrate`        | Applica le migrazioni al database          | Esegui dalla radice del progetto |
| `make makemigrations` | Crea nuove migrazioni                      | Esegui dalla radice del progetto |
| `make shell`          | Avvia una shell Python con contesto Django | Esegui dalla radice del progetto |
| `make lint`           | Esegue i controlli di qualità del codice   | Esegui dalla radice del progetto |
| `make format`         | Formatta il codice Python e i template     | Esegui dalla radice del progetto |
| `make help`           | Mostra l'elenco di tutti i comandi         | Esegui dalla radice del progetto |

## Installazione di Make

### Windows

Su Windows, Make non è installato di default. Puoi installarlo in due modi:

1. **Utilizzando lo script di installazione automatica**:

   ```powershell
   .\scripts\install-make-windows.ps1
   ```

2. **Manualmente tramite Chocolatey**:

   - Installa [Chocolatey](https://chocolatey.org/install)
   - Esegui: `choco install make`

3. **Manualmente tramite Scoop**:
   - Installa [Scoop](https://scoop.sh/)
   - Esegui: `scoop install make`

### macOS

Su macOS, puoi installare Make usando Homebrew:

1. **Utilizzando lo script di installazione automatica**:

   ```bash
   chmod +x scripts/install-make-macos.sh
   ./scripts/install-make-macos.sh
   ```

2. **Manualmente tramite Homebrew**:
   - Installa [Homebrew](https://brew.sh/)
   - Esegui: `brew install make`

### Linux

Su Linux, Make è generalmente preinstallato. Se non lo è, puoi installarlo così:

1. **Utilizzando lo script di installazione automatica**:

   ```bash
   chmod +x scripts/install-make-linux.sh
   ./scripts/install-make-linux.sh
   ```

2. **Manualmente**:
   - Ubuntu/Debian: `sudo apt-get install make`
   - Fedora: `sudo dnf install make`
   - Arch Linux: `sudo pacman -S make`

## Vantaggi dell'uso di Make

- **Semplicità**: Comandi complessi vengono ridotti a comandi semplici e memorizzabili
- **Standardizzazione**: Tutti i membri del team usano gli stessi comandi
- **Documentazione implicita**: Il Makefile stesso documenta i comandi principali del progetto
- **Efficienza**: Riduce gli errori di battitura e la necessità di ricordare flag e opzioni

## Estendere il Makefile

Puoi aggiungere facilmente nuovi comandi al Makefile per automatizzare altre operazioni comuni. Ecco la struttura generale di un comando Make:

```makefile
.PHONY: nome-comando
nome-comando:
    comando da eseguire
```

### Cos'è `.PHONY` e perché è importante

La direttiva `.PHONY` indica a Make che il target non è un file da creare, ma un'azione da eseguire. Questo è importante per due motivi:

1. **Evita conflitti con file reali**: Se esistesse un file chiamato `test` nella tua directory, senza `.PHONY`, Make controllerebbe se quel file è aggiornato e potrebbe decidere di non eseguire il comando.

2. **Migliora le prestazioni**: Make non verifica la presenza o la data di modifica di un file quando un target è dichiarato come `.PHONY`, il che rende l'esecuzione più efficiente.

In pratica, dovresti sempre dichiarare come `.PHONY` tutti i target che non producono file con lo stesso nome del comando.

Ad esempio, per aggiungere un comando che esegue i test:

```makefile
.PHONY: test
test:
    uv run pytest
```

Poi potrai eseguirlo con `make test`.

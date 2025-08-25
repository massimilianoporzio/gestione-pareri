# Script di Utilità

Questa cartella contiene script per varie operazioni di setup e manutenzione del progetto.

## Script disponibili

### Script di setup

Questi script configurano completamente l'ambiente di sviluppo:

| Script      | Piattaforma | Descrizione                                             |
| ----------- | ----------- | ------------------------------------------------------- |
| `setup.ps1` | Windows     | Script completo di setup del progetto per Windows       |
| `setup.sh`  | macOS/Linux | Script completo di setup del progetto per macOS e Linux |

### Script per la formattazione Markdown

Questi script installano gli strumenti necessari per la formattazione Markdown:

| Script                       | Piattaforma | Descrizione                                            |
| ---------------------------- | ----------- | ------------------------------------------------------ |
| `install-markdown-tools.ps1` | Windows     | Installa Prettier e markdownlint-cli2 su Windows       |
| `install-markdown-tools.sh`  | macOS/Linux | Installa Prettier e markdownlint-cli2 su macOS e Linux |

### Script per l'installazione di Make

Questi script installano Make sulla piattaforma specificata:

| Script                     | Piattaforma | Descrizione                                        |
| -------------------------- | ----------- | -------------------------------------------------- |
| `install-make-windows.ps1` | Windows     | Installa Make su Windows usando Chocolatey o Scoop |
| `install-make-macos.sh`    | macOS       | Installa Make su macOS usando Homebrew             |
| `install-make-linux.sh`    | Linux       | Installa Make su diverse distribuzioni Linux       |

## Utilizzo

### Su Windows (PowerShell)

```powershell
# Setup completo del progetto
.\setup.ps1

# Installazione degli strumenti Markdown
.\install-markdown-tools.ps1

# Installazione di Make
.\install-make-windows.ps1
```

### Su macOS (Bash)

```bash
# Rendere gli script eseguibili
chmod +x *.sh

# Setup completo del progetto
./setup.sh

# Installazione degli strumenti Markdown
./install-markdown-tools.sh

# Installazione di Make
chmod +x install-make-macos.sh
./install-make-macos.sh
```

### Su Linux (Bash)

```bash
# Rendere gli script eseguibili
chmod +x *.sh

# Setup completo del progetto
./setup.sh

# Installazione degli strumenti Markdown
./install-markdown-tools.sh

# Installazione di Make
chmod +x install-make-linux.sh
./install-make-linux.sh
```

## Note

- Gli script di setup verificano automaticamente i requisiti e installano le dipendenze necessarie
- Gli script di installazione Markdown richiedono npm (Node Package Manager) installato
- Tutti gli script possono essere eseguiti più volte senza effetti collaterali

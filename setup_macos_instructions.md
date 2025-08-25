# Istruzioni per configurare il progetto deploy-django su macOS

Questa guida ti mostrerà come configurare il tuo ambiente di sviluppo su macOS per continuare a lavorare sul repository `deploy-django`.

## 1. Clonare il repository

```bash
# Crea una directory per i tuoi progetti (se non esiste già)
mkdir -p ~/progetti
cd ~/progetti

# Clona il repository
git clone https://github.com/massimilianoporzio/deploy-django.git
cd deploy-django
```

## 2. Configurare Python 3.13

```bash
# Installa Homebrew se non l'hai già
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installa Python 3.13 usando Homebrew
brew install python@3.13

# Verifica l'installazione
python3.13 --version
```

## 3. Configurare uv e l'ambiente virtuale

```bash
# Installa uv usando curl (metodo consigliato)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Oppure puoi usare Homebrew
# brew install astral/tap/uv

# Verifica l'installazione
uv --version

# Crea un ambiente virtuale con uv
cd ~/progetti/deploy-django
uv venv

# Attiva l'ambiente virtuale
source .venv/bin/activate

# Installa le dipendenze del progetto
uv pip install -e .
```

## 4. Configurare VS Code

1. Scarica e installa VS Code da [code.visualstudio.com](https://code.visualstudio.com/)
2. Installa le seguenti estensioni:

   - Python
   - Django
   - Black Formatter
   - Ruff
   - Material Icon Theme

3. Configura le impostazioni del progetto:

```bash
mkdir -p .vscode
```

Crea il file `.vscode/settings.json` con questo contenuto:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "python.linting.pylintArgs": ["--load-plugins=pylint_django"],
  "python.formatting.provider": "black",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": "explicit"
  },
  "djlint.ignore": ["H031"],
  "djlint.useVenv": true,
  "terminal.integrated.fontFamily": "Hack Nerd Font Mono"
}
```

## 5. Configurare il terminale e Oh My Posh (opzionale)

Se vuoi mantenere l'aspetto del terminale con Oh My Posh:

```bash
# Installa Oh My Posh tramite Homebrew
brew install jandedobbeleer/oh-my-posh/oh-my-posh

# Installa il font Hack Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# Copia il tuo tema Oh My Posh
mkdir -p ~/.poshthemes
cp ~/progetti/deploy-django/powerlevel10k_rainbow.omp.json ~/.poshthemes/

# Configura Oh My Posh nel tuo shell (aggiungi al tuo ~/.zshrc)
echo 'eval "$(oh-my-posh init zsh --config ~/.poshthemes/powerlevel10k_rainbow.omp.json)"' >> ~/.zshrc
source ~/.zshrc
```

## 6. Eseguire il progetto Django

```bash
cd ~/progetti/deploy-django
source .venv/bin/activate
cd src
python manage.py runserver
```

## 7. Configurare Git

```bash
git config --global user.name "Il tuo nome"
git config --global user.email "tua.email@esempio.com"
```

## 8. Aggiornare il file di configurazione pre-commit

Il file `.pre-commit-config.yaml` è già configurato per funzionare su tutte le piattaforme. Include due hook per pylint:

1. `pylint-unified`: Esegue pylint su Windows e passa silenziosamente su macOS/Linux
2. `pylint-unix-ci`: Esegue pylint su macOS/Linux e passa silenziosamente su Windows

Entrambi gli hook sono progettati per passare automaticamente sulla piattaforma appropriata senza mostrare errori, quindi non è necessario fare alcuna modifica al file di configurazione.

Per eseguire i pre-commit hook:

```bash
# Installa i pre-commit hooks (una tantum)
pre-commit install

# Esegui i pre-commit hooks su tutti i file
pre-commit run --all-files
```

## Note importanti

- Su macOS, i percorsi utilizzano `/` invece di `\` come su Windows
- Assicurati che tutte le variabili d'ambiente nel file `.env` siano configurate correttamente per macOS
- Se incontri problemi con i permessi, potrebbe essere necessario utilizzare `sudo` per alcuni comandi

## Comandi utili per uv

```bash
# Installare un nuovo pacchetto
uv pip install nome-pacchetto

# Aggiornare uv.lock
uv pip sync

# Visualizzare i pacchetti installati
uv pip list

# Esportare i requisiti in un file requirements.txt
uv pip freeze > requirements.txt
```

## Risoluzione dei problemi comuni

### Problema: "Command not found: uv"

Soluzione: Assicurati di aver aggiunto uv al tuo PATH. Riavvia il terminale dopo l'installazione.

### Problema: Errori durante l'installazione dei pacchetti

Soluzione: Verifica di avere installato gli strumenti di sviluppo di Xcode:

```bash
xcode-select --install
```

### Problema: Font mancanti in VS Code

Soluzione: Verifica che Hack Nerd Font sia installato correttamente e configurato nelle impostazioni di VS Code.

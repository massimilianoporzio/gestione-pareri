#!/bin/bash
# Script di setup del progetto per ambienti Unix/Linux/macOS
# Per renderlo eseguibile: chmod +x setup.sh

# Colori per output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setup progetto Django in corso...${NC}"

# Verifica Python
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 non è installato. Per favore, installalo prima di continuare.${NC}"
    exit 1
fi

# Verifica uv
if ! command -v uv &> /dev/null; then
    echo -e "${RED}uv non è installato. Si consiglia di installarlo per una gestione pacchetti più veloce.${NC}"
    echo -e "Installazione con: ${BLUE}curl -LsSf https://astral.sh/uv/install.sh | sh${NC}"

    read -p "Vuoi installare uv adesso? (s/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
        # Aggiorna PATH per l'esecuzione corrente
        export PATH="$HOME/.cargo/bin:$PATH"
    else
        echo -e "${BLUE}Utilizzerò pip invece di uv.${NC}"
    fi
fi

# Creazione ambiente virtuale
echo -e "${BLUE}Creazione ambiente virtuale...${NC}"
if command -v uv &> /dev/null; then
    uv venv
else
    python3 -m venv .venv
fi

# Attivazione ambiente virtuale
echo -e "${BLUE}Attivazione ambiente virtuale...${NC}"
source .venv/bin/activate

# Installazione dipendenze
echo -e "${BLUE}Installazione dipendenze...${NC}"
if command -v uv &> /dev/null; then
    uv sync
else
    pip install -r requirements.txt
fi

# Installazione pre-commit
echo -e "${BLUE}Configurazione pre-commit...${NC}"
if command -v uv &> /dev/null; then
    uv add pre-commit
else
    pip install pre-commit
fi
pre-commit install

# Configurazione file .env
if [ ! -f .env ]; then
    echo -e "${BLUE}Creazione file .env...${NC}"
    cp .env.example .env
    echo -e "${GREEN}File .env creato. Modifica i valori secondo le tue esigenze.${NC}"
fi

# Installazione strumenti Markdown
if command -v npm &> /dev/null; then
    echo -e "${BLUE}Installazione strumenti di formattazione Markdown...${NC}"
    bash scripts/install-markdown-tools.sh
else
    echo -e "${RED}npm non è installato. Gli strumenti di formattazione Markdown non saranno installati.${NC}"
    echo -e "Per installarli manualmente in seguito, esegui: ${BLUE}bash scripts/install-markdown-tools.sh${NC}"
fi

echo -e "${GREEN}Setup completato con successo!${NC}"
echo -e "Per avviare il server di sviluppo: ${BLUE}cd src && python manage.py runserver${NC}"

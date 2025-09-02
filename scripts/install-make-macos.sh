#!/bin/bash
# Script per installare Make su macOS

# Colori per output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Controlla se Make è già installato
if command -v make &> /dev/null; then
    echo -e "${GREEN}✅ Make è già installato${NC}"
    exit 0
fi

# Controlla se Homebrew è installato
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}❓ Homebrew non è installato${NC}"
    read -p "Vuoi installare Homebrew? (s/n) " install_brew

    if [[ $install_brew == "s" ]]; then
        echo -e "${CYAN}📦 Installazione di Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Aggiunge Homebrew al PATH per la sessione corrente
        if [[ -f ~/.zshrc ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f ~/.bash_profile ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo -e "${RED}❌ Installazione di Make annullata. Puoi installare Homebrew manualmente.${NC}"
        echo -e "${RED}   Per istruzioni, visita: https://brew.sh${NC}"
        exit 1
    fi
fi

# Installa Make
echo -e "${CYAN}📦 Installazione di Make...${NC}"
brew install make

# Verifica che l'installazione sia riuscita
if command -v make &> /dev/null; then
    echo -e "${GREEN}✅ Make è stato installato con successo!${NC}"
    echo -e "${GREEN}   Versione installata: $(make --version | head -n 1)${NC}"
else
    echo -e "${RED}❌ L'installazione di Make non è riuscita. Riprova o installa manualmente.${NC}"
    exit 1
fi

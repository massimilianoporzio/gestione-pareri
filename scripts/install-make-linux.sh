#!/bin/bash
# Script per installare Make su sistemi Linux

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

# Identifica il gestore di pacchetti
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
    INSTALL_CMD="sudo apt-get update && sudo apt-get install -y make"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y make"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    INSTALL_CMD="sudo yum install -y make"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -Sy make --noconfirm"
elif command -v zypper &> /dev/null; then
    PKG_MANAGER="zypper"
    INSTALL_CMD="sudo zypper install -y make"
else
    echo -e "${RED}❌ Nessun gestore di pacchetti supportato trovato (apt-get, dnf, yum, pacman, zypper)${NC}"
    echo -e "${RED}   Installa Make manualmente per il tuo sistema operativo${NC}"
    exit 1
fi

# Installa Make
echo -e "${CYAN}📦 Installazione di Make utilizzando $PKG_MANAGER...${NC}"
eval $INSTALL_CMD

# Verifica che l'installazione sia riuscita
if command -v make &> /dev/null; then
    echo -e "${GREEN}✅ Make è stato installato con successo!${NC}"
    echo -e "${GREEN}   Versione installata: $(make --version | head -n 1)${NC}"
else
    echo -e "${RED}❌ L'installazione di Make non è riuscita. Riprova o installa manualmente.${NC}"
    exit 1
fi

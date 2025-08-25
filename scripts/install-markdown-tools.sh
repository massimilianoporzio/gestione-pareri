#!/bin/bash
# Script per installare gli strumenti necessari per la formattazione Markdown
# Eseguire con bash in macOS/Linux
# Per renderlo eseguibile: chmod +x install-markdown-tools.sh

# Verifica se npm è installato
if ! command -v npm &> /dev/null; then
    echo "npm non è installato. Per favore, installa Node.js e npm."
    echo "Linux: sudo apt install nodejs npm"
    echo "macOS: brew install node"
    exit 1
fi

echo "Installazione di markdownlint-cli2..."
npm install -g markdownlint-cli2

echo "Installazione di prettier..."
npm install -g prettier

echo "Installazione completata!"
echo "Per verificare l'installazione, esegui:"
echo "markdownlint-cli2 --version"
echo "prettier --version"

# Script per installare gli strumenti necessari per la formattazione Markdown
# Eseguire con PowerShell

# Installa markdownlint-cli2 globalmente con NPM
Write-Output "Installazione di markdownlint-cli2..."
npm install -g markdownlint-cli2

# Installa prettier globalmente con NPM
Write-Output "Installazione di prettier..."
npm install -g prettier

Write-Output "Installazione completata!"
Write-Output "Per verificare l'installazione, esegui:"
Write-Output "markdownlint-cli2 --version"
Write-Output "prettier --version"

#!/bin/bash
# Script per eseguire l'analisi SonarQube locale su Linux/macOS
# Assicurati che SonarQube Scanner sia installato e configurato correttamente

# Colori per i messaggi
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Variabili di configurazione
PROJECT_KEY="massimilianoporzio_deploy-django"
PROJECT_NAME="deploy-django"
PROJECT_VERSION="1.0"
SOURCES_DIR="src"
COVERAGE_REPORT="coverage.xml"

# Assicurarsi che coverage.xml esista
if [ ! -f "$COVERAGE_REPORT" ]; then
    echo -e "${YELLOW}Generazione report di copertura...${NC}"
    python -m pytest --cov=src --cov-report=xml
fi

# Esegui SonarQube Scanner
echo -e "${GREEN}Avvio analisi SonarQube...${NC}"

# Controlla se sonar-scanner è nel PATH
if command -v sonar-scanner &> /dev/null; then
    sonar-scanner \
        -Dsonar.projectKey=$PROJECT_KEY \
        -Dsonar.projectName=$PROJECT_NAME \
        -Dsonar.projectVersion=$PROJECT_VERSION \
        -Dsonar.sources=$SOURCES_DIR \
        -Dsonar.python.coverage.reportPaths=$COVERAGE_REPORT \
        -Dsonar.scm.provider=git \
        -Dsonar.scm.forceReloadAll=false \
        -Dsonar.analysis.mode=incremental
else
    echo "Errore: sonar-scanner non trovato. Assicurati che sia installato e nel PATH."
    echo "Visita https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/ per le istruzioni di installazione."
    exit 1
fi

echo -e "${GREEN}Analisi SonarQube completata!${NC}"

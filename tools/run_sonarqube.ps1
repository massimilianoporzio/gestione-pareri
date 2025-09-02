# Script per eseguire l'analisi SonarQube locale
# Assicurati che SonarQube Scanner sia installato e configurato correttamente

# Variabili di configurazione
$PROJECT_KEY = "massimilianoporzio_deploy-django"
$PROJECT_NAME = "deploy-django"
$PROJECT_VERSION = "1.0"
$SOURCES_DIR = "src"
$COVERAGE_REPORT = "coverage.xml"

# Assicurarsi che coverage.xml esista
if (-not (Test-Path $COVERAGE_REPORT)) {
    Write-Host "Generazione report di copertura..." -ForegroundColor Yellow
    python -m pytest --cov=src --cov-report=xml
}

# Esegui SonarQube Scanner
Write-Host "Avvio analisi SonarQube..." -ForegroundColor Green

sonar-scanner.bat `
    -Dsonar.projectKey=$PROJECT_KEY `
    -Dsonar.projectName=$PROJECT_NAME `
    -Dsonar.projectVersion=$PROJECT_VERSION `
    -Dsonar.sources=$SOURCES_DIR `
    -Dsonar.python.coverage.reportPaths=$COVERAGE_REPORT `
    -Dsonar.scm.provider=git `
    -Dsonar.scm.forceReloadAll=false `
    -Dsonar.analysis.mode=incremental

Write-Host "Analisi SonarQube completata!" -ForegroundColor Green

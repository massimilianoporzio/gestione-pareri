# SonarQube e SonarCloud in VS Code

Questa guida descrive come configurare e utilizzare SonarQube/SonarCloud con il progetto deploy-django.

## Panoramica

SonarQube è uno strumento di analisi statica del codice che offre:

- Rilevamento di bug e vulnerabilità
- Identificazione di code smells
- Misurazione della copertura dei test
- Suggerimenti per migliorare la qualità del codice

## Configurazione

### Installazione dell'estensione SonarLint in VS Code

1. Apri VS Code
2. Vai all'estensione marketplace (Ctrl+Shift+X)
3. Cerca "SonarLint"
4. Installa l'estensione SonarLint

### Connessione a SonarCloud (Analisi remota)

Il progetto è già configurato per l'integrazione con SonarCloud tramite GitHub Actions. Per collegare VS Code a SonarCloud:

1. Apri il comando palette in VS Code (Ctrl+Shift+P)
2. Cerca e seleziona "SonarLint: Connect to SonarQube/SonarCloud"
3. Seleziona "SonarCloud"
4. Segui le istruzioni per autenticarti con SonarCloud
5. Seleziona l'organizzazione "massimilianoporzio-github"
6. Seleziona il progetto "massimilianoporzio_deploy-django"

### Analisi locale con SonarQube Scanner

Per eseguire un'analisi locale:

1. Installa [SonarQube Scanner](https://docs.sonarqube.org/latest/analyzing-source-code/scanners/sonarscanner/)
2. Esegui l'analisi utilizzando il comando più adatto al tuo sistema operativo:

**Utilizzando Make (funziona su tutte le piattaforme):**

```bash
make sonarqube
```

**Windows (PowerShell):**

```powershell
.\tools\run_sonarqube.ps1
```

**Linux/macOS:**

```bash
chmod +x ./tools/run_sonarqube.sh
./tools/run_sonarqube.sh
```

Questi script genereranno automaticamente un report di copertura se non esiste e avvieranno l'analisi SonarQube.

## File di configurazione

Il progetto include già i seguenti file di configurazione SonarQube:

- `sonar-project.properties`: Configurazione principale per l'analisi SonarQube
- `.vscode/settings.json`: Impostazioni per SonarLint in VS Code
- `.github/workflows/sonarcloud.yml`: Configurazione per l'analisi SonarCloud su GitHub Actions

## Regole ignorate

Alcune regole SonarQube sono state disattivate perché non applicabili o troppo restrittive per questo progetto:

- `python:S1128`: Importazioni inutilizzate (disattivato per file specifici)
- `python:S112`: Eccezioni troppo generiche
- `python:S3776`: Complessità cognitiva eccessiva
- `python:S1542`: Importazioni che non sono all'inizio del file

## Note aggiuntive

- I file temporanei SonarQube (`.scannerwork/`, `.sonar/`, ecc.) sono esclusi tramite `.gitignore`
- L'analisi incrementale è abilitata per migliorare le prestazioni delle scansioni
- I problemi SonarQube sono visualizzati nella vista "Problemi" di VS Code quando si utilizza SonarLint

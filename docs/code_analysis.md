# Analisi della Qualità del Codice

Questo progetto utilizza diversi strumenti per l'analisi statica e la valutazione della qualità del codice. Questi strumenti aiutano a mantenere standard elevati e identificare potenziali problemi nel codice.

## Strumenti Configurati

### 1. GitHub CodeQL

[CodeQL](https://codeql.github.com/) è un potente motore di analisi semantica che individua vulnerabilità e errori nel codice. È particolarmente efficace nell'identificare problemi di sicurezza.

- **Come funziona**: Viene eseguito automaticamente su ogni push e pull request verso il branch master.
- **Configurazione**: Vedere il file `.github/workflows/codeql-analysis.yml`.
- **Dashboard**: Disponibile nella sezione "Security" del repository GitHub.

### 2. SonarCloud

[SonarCloud](https://sonarcloud.io/) è una piattaforma cloud per l'analisi continua del codice che trova bug, vulnerabilità e "code smells".

- **Come funziona**: Analizza il codice dopo ogni push e pull request, fornendo feedback dettagliato sulla qualità.
- **Configurazione**:
  - File: `.github/workflows/sonarcloud.yml` e `sonar-project.properties`.
  - Richiede un account SonarCloud e un token segreto configurato in GitHub.
- **Dashboard**: [https://sonarcloud.io/dashboard?id=massimilianoporzio_deploy-django](https://sonarcloud.io/dashboard?id=massimilianoporzio_deploy-django)

### 3. Codacy

[Codacy](https://www.codacy.com/) è uno strumento di revisione automatica del codice che analizza la qualità, la sicurezza e la manutenibilità.

- **Come funziona**: Fornisce feedback su ogni commit, mostrando problemi e suggerimenti di miglioramento.
- **Configurazione**:
  - File: `.github/workflows/codacy-analysis.yml`.
  - Richiede un account Codacy e un token di progetto configurato in GitHub.
- **Dashboard**: Disponibile sul sito di Codacy dopo la configurazione.

## Come utilizzare questi strumenti

1. **Per visualizzare i risultati**:

   - Visita la tab "Actions" nel repository GitHub per vedere l'esecuzione dei workflow.
   - Accedi alle dashboard specifiche di SonarCloud e Codacy per analisi dettagliate.

2. **Per configurare i segreti necessari**:

   - Per SonarCloud: Aggiungi `SONAR_TOKEN` nelle impostazioni del repository GitHub (Settings > Secrets).
   - Per Codacy: Aggiungi `CODACY_PROJECT_TOKEN` nelle impostazioni del repository.

3. **Per personalizzare le regole**:
   - SonarCloud: Modifica il file `sonar-project.properties`.
   - Codacy: Configura le regole tramite l'interfaccia web di Codacy.
   - CodeQL: Modifica il file di configurazione per ignorare specifici avvisi o personalizzare l'analisi.

## Best Practices

- **Verifica regolarmente** i risultati dell'analisi per mantenere alta la qualità del codice.
- **Risolvi i problemi critici** prima di effettuare il merge delle pull request.
- **Utilizza i badge** nel README per mostrare lo stato attuale dell'analisi del codice.
- **Configura notifiche** per essere avvisato quando vengono rilevati nuovi problemi.

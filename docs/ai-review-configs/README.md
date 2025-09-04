# AI Code Review - File di Configurazione

Questa directory contiene i file di configurazione per integrare agenti AI per le review automatiche delle Pull Request.

## 🚀 Quick Setup

1. **Copia i file di configurazione** dalla root del tuo progetto:

   ```bash
   cp docs/ai-review-configs/.coderabbit.yml .
   cp docs/ai-review-configs/.sourcery.yaml .
   cp docs/ai-review-configs/ai-review.yml .github/workflows/
   ```

2. **Installa le GitHub Apps** (nessun token necessario):
   - [CodeRabbit](https://coderabbit.ai) - Review dettagliate AI
   - [Sourcery](https://sourcery.ai) - Refactoring Python automatico
     **Nota**: Sourcery funziona tramite GitHub App, non tramite GitHub Actions. Una volta installata l'app, analizzerà automaticamente le tue PR.
3. **Il workflow GitHub Actions** eseguirà:
   - **CodeQL** per analisi di sicurezza
   - **Ruff + Pylint** per quality check locali
   - **Summary automatico** dei risultati

## 📁 File Inclusi

- `.coderabbit.yml` - Configurazione CodeRabbit per review AI
- `.sourcery.yaml` - Configurazione Sourcery per refactoring Python
- `ai-review.yml` - Workflow GitHub Actions completo
- `README.md` - Questa documentazione

## 🔧 Personalizzazione

Ogni file include commenti dettagliati per personalizzare:

- Livelli di review (basic/standard/comprehensive)
- File e pattern da includere/escludere
- Regole specifiche per Django
- Soglie di qualità

## 💡 Come Funziona

1. **Apri una Pull Request**
2. **Gli AI iniziano automaticamente la review**
3. **Ricevi commenti dettagliati** con suggerimenti
4. **Confronta** le tue decisioni con i suggerimenti AI
5. **Impara** nuovi pattern e best practices
   Questa configurazione ti darà un "secondo parere" automatico su ogni modifica, aiutandoti a migliorare la qualità del codice e imparare nuove tecniche! 🚀

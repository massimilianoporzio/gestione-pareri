# 🔨 Pre-commit Setup con UV

Guida rapida per configurare pre-commit utilizzando UV tool installer.

## 🚀 Installazione Veloce

```powershell
# 1. Installa pre-commit via UV (metodo raccomandato)
uv tool install pre-commit --with pre-commit-uv
# 2. Verifica installazione
pre-commit --version
# 3. Setup hooks nel progetto (una sola volta)
pre-commit install
# 4. Test manuale
pre-commit run --all-files
```

## ✅ Verifica Setup

```powershell
# Controlla che pre-commit sia nel PATH UV
which pre-commit
# Output atteso: ~/.local/share/uv/tools/pre-commit/bin/pre-commit
# Test con giustfile
just precommit-corporate
```

## 🔧 Configurazione .pre-commit-config.yaml

Il progetto include già una configurazione ottimizzata per UV:

```yaml
repos:
  - repo: <https://github.com/astral-sh/ruff-pre-commit>
    hooks:
      - id: ruff
      - id: ruff-format
  - repo: local
    hooks:
      - id: django-check
        entry: uv run python src/manage.py check
        language: system
```

## 🎯 Workflow Quotidiano

```powershell
# Durante sviluppo (automatico su git commit)
git add .
git commit -m "feature: nuovo modulo"  # Pre-commit si attiva automaticamente
# Controlli manuali prima di push
just precommit-corporate              # Controlli completi
# Test rapidi
just test-quick                       # Test essenziali
# Prima del deploy
just test-pre-deploy                  # Test completi
```

## ❌ Troubleshooting

### Problema: "pre-commit: command not found"

```powershell
# Soluzione 1: Reinstalla con UV
uv tool uninstall pre-commit
uv tool install pre-commit --with pre-commit-uv
# Soluzione 2: Verifica PATH
echo $env:PATH | grep uv
```

### Problema: Pre-commit non usa UV

```powershell
# Verifica che hooks usino 'uv run'
cat .pre-commit-config.yaml | grep "uv run"
# Output atteso: entry: uv run python src/manage.py check
```

---

🔗 **Vedi anche**: [UV Guide](uv-guide.md) per documentazione completa UV ⚡ **Pro Tip**:
`uv tool install` è molto più veloce di `pip install` per strumenti globali!

#!/usr/bin/env python
"""Script per eseguire djlint in modo silenzioso per pre-commit."""

import shutil
import subprocess
import sys
from pathlib import Path

# Verifica che djlint sia installato
if shutil.which("djlint") is None:
    print("djlint non trovato. Installalo con 'pip install djlint'.")
    sys.exit(1)

# Directory dei template
template_dir = Path("src/templates")

# Verifica se la directory esiste
if not template_dir.exists():
    print(f"Directory {template_dir} non trovata, nessuna azione richiesta.")
    sys.exit(0)

# Esegui djlint con le opzioni desiderate
cmd = ["djlint", str(template_dir), "--reformat", "--ignore", "H030", "--configuration", ".config/djlintrc"]

try:
    # Cattura l'output per evitare di mostrare i warning
    result = subprocess.run(cmd, capture_output=True, text=True, check=False)

    # Filtra i warning relativi all'ambiente virtuale
    stderr_lines = []
    for line in result.stderr.splitlines():
        if "VIRTUAL_ENV" not in line and "environment path" not in line:
            stderr_lines.append(line)

    # Mostra l'output utile
    if result.stdout.strip():
        print(result.stdout)

    if stderr_lines:
        print("\n".join(stderr_lines))

    # Ritorna il codice di uscita originale
    sys.exit(result.returncode)
except FileNotFoundError:
    print("Errore: djlint non è stato trovato nel PATH. Assicurati che sia installato.")
    sys.exit(1)
except subprocess.SubprocessError as e:
    print(f"Errore di subprocess nell'esecuzione di djlint: {e}")
    sys.exit(1)
except OSError as e:
    print(f"Errore di sistema nell'esecuzione di djlint: {e}")
    sys.exit(1)

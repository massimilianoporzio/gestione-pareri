"""Fix Md012 module.

Questo modulo fornisce funzionalità per fix md012.
"""

import os
import re

# Percorso della cartella da analizzare
TARGET_DIR = "docs"
EXTENSIONS = [".md"]


def process_file(filepath):
    """Process file.

    Args:
        filepath: Descrizione di filepath

    Returns:
        Descrizione del valore restituito
    """
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()
    # Sostituisce 2 o più righe vuote consecutive con una sola
    new_content = re.sub(r"(\n\s*){2,}", "\n\n", content)
    if new_content != content:
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"Corretto: {filepath}")
    else:
        print(f"Nessuna modifica: {filepath}")


def main():
    """Main."""
    for root, _, files in os.walk(TARGET_DIR):
        for file in files:
            if any(file.endswith(ext) for ext in EXTENSIONS):
                process_file(os.path.join(root, file))


if __name__ == "__main__":
    main()

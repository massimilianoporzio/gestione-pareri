"""Fix Md029 module.

Questo modulo fornisce funzionalità per fix md029.
"""

import os
import re

# Percorso della cartella da analizzare
TARGET_DIR = "docs"
EXTENSIONS = [".md"]

# Regex per trovare liste ordinate
ORDERED_LIST_PATTERN = re.compile(r"(^|\n)(\s*)(\d+)\. (.+)(?=\n|$)")


def process_file(filepath):
    """Process file.

    Args:
        filepath: Descrizione di filepath

    Returns:
        Descrizione del valore restituito
    """
    with open(filepath, "r", encoding="utf-8") as f:
        lines = f.readlines()

    new_lines = []
    i = 0
    while i < len(lines):
        line = lines[i]
        match = re.match(r"^(\s*)(\d+)\. (.+)", line)
        if match:
            # Inizia una lista ordinata
            indent = match.group(1)
            count = 1
            # Trova tutte le righe della lista
            while i < len(lines) and re.match(r"^(\s*)\d+\. (.+)", lines[i]):
                item_match = re.match(r"^(\s*)\d+\. (.+)", lines[i])
                new_lines.append(f"{indent}{count}. {item_match.group(2)}\n")
                count += 1
                i += 1
        else:
            new_lines.append(line)
            i += 1

    with open(filepath, "w", encoding="utf-8") as f:
        f.writelines(new_lines)
    print(f"Corretto: {filepath}")


def main():
    """Main."""
    for root, _, files in os.walk(TARGET_DIR):
        for file in files:
            if any(file.endswith(ext) for ext in EXTENSIONS):
                process_file(os.path.join(root, file))


if __name__ == "__main__":
    main()

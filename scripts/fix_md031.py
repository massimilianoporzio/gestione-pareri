"""Fix Md031 module.

Questo modulo fornisce funzionalità per fix md031.
"""

import os
import re

# Percorso della cartella da analizzare
TARGET_DIR = "docs"
EXTENSIONS = [".md"]

# Regex per trovare blocchi di codice markdown
FENCE_PATTERN = re.compile(r"(^|\n)(```[a-zA-Z0-9]*\n[\s\S]*?```)(\n|$)", re.MULTILINE)


def process_file(filepath):
    """Process file.

    Args:
        filepath: Descrizione di filepath

    Returns:
        Descrizione del valore restituito
    """
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    def add_blank_lines(match):
        """Add blank lines.

        Args:
            match: Descrizione di match

        Returns:
            Descrizione del valore restituito
        """
        before = match.group(1)
        block = match.group(2)
        after = match.group(3)
        # Assicura una riga vuota prima e dopo il blocco
        if not before.endswith("\n\n"):
            before = before + "\n"
        if not after.startswith("\n"):
            after = "\n" + after if after != "" else "\n"
        return before + block + after

    new_content = FENCE_PATTERN.sub(add_blank_lines, content)

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

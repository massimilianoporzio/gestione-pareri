"""
Script per aggiungere automaticamente docstring ai file Python.

Questo script analizza un file Python e aggiunge docstring mancanti a livello di modulo,
classi e funzioni usando il modulo docstring_parser.

Uso:
    python add_docstring.py <file_path>
"""

import ast
import sys
from pathlib import Path


def get_module_docstring(source):
    """
    Estrae la docstring esistente dal modulo se presente.

    Args:
        source (str): Il codice sorgente del modulo Python

    Returns:
        str: La docstring del modulo se presente, altrimenti None
    """
    try:
        tree = ast.parse(source)
        return ast.get_docstring(tree)
    except SyntaxError:
        return None


def add_module_docstring(filepath):
    """
    Aggiunge una docstring al livello del modulo se non è già presente.

    Args:
        filepath (str): Percorso del file Python da modificare

    Returns:
        bool: True se il file è stato modificato, altrimenti False
    """
    path = Path(filepath)
    if not path.exists() or not path.is_file() or path.suffix != ".py":
        print(f"Il file {filepath} non è un file Python valido.")
        return False

    # Legge il contenuto del file
    content = path.read_text(encoding="utf-8")

    # Controlla se il modulo ha già una docstring
    if get_module_docstring(content) is not None:
        print(f"Il file {filepath} ha già una docstring.")
        return False

    # Determina il nome del modulo dal nome del file
    module_name = path.stem

    # Crea una docstring predefinita
    module_name_formatted = module_name.replace("_", " ")
    module_docstring = f'"""\n{module_name_formatted.title()} module.\n\n'
    module_docstring += f'Questo modulo fornisce funzionalità per {module_name_formatted}.\n"""\n\n'

    # Inserisce la docstring all'inizio del file, ma dopo eventuali commenti iniziali o shebang
    lines = content.splitlines()

    # Trova la posizione corretta per inserire la docstring
    insert_pos = 0

    # Salta commenti iniziali e shebang
    for i, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            insert_pos = i + 1
        else:
            break

    # Inserisce la docstring
    lines.insert(insert_pos, module_docstring)

    # Scrive il contenuto aggiornato nel file
    path.write_text("\n".join(lines), encoding="utf-8")
    print(f"Aggiunta docstring al modulo {filepath}")
    return True


def main():
    """
    Funzione principale che processa gli argomenti della linea di comando.
    """
    if len(sys.argv) != 2:
        print("Uso: python add_docstring.py <file_path>")
        sys.exit(1)

    filepath = sys.argv[1]
    if add_module_docstring(filepath):
        print(f"Docstring aggiunta con successo a {filepath}")
    else:
        print(f"Nessuna modifica apportata a {filepath}")


if __name__ == "__main__":
    main()

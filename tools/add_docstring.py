"""Script per aggiungere automaticamente docstring ai file Python.

Questo script analizza un file Python e aggiunge docstring mancanti a livello di modulo,
classi e funzioni usando il modulo docstring_parser.

Uso:
    python add_docstring.py <file_path>
"""

import ast
import sys
from pathlib import Path


def get_module_docstring(source):
    """Estrae la docstring esistente dal modulo se presente.

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
    """Aggiunge una docstring al livello del modulo se non è già presente.

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

    # Crea una docstring predefinita conforme a Ruff/Google style
    module_name_formatted = module_name.replace("_", " ")
    module_docstring = f'"""{module_name_formatted.title()} module.\n\n'
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


def get_function_params(node):
    """Estrae i parametri di una funzione.

    Args:
        node (ast.FunctionDef): Il nodo AST della definizione di funzione

    Returns:
        list: Lista di nomi di parametri
    """
    params = []
    for arg in node.args.args:
        params.append(arg.arg)
    return params


def _validate_file_path(filepath):
    """Valida che il percorso sia un file Python valido."""
    path = Path(filepath)
    if not path.exists() or not path.is_file() or path.suffix != ".py":
        print(f"Il file {filepath} non è un file Python valido.")
        return None
    return path


def _collect_functions_to_modify(tree):
    """Raccoglie tutte le funzioni e metodi senza docstring."""
    functions_to_modify = []

    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef) and ast.get_docstring(node) is None:
            functions_to_modify.append(node)
        elif isinstance(node, ast.ClassDef):
            # Metodi di classe senza docstring
            for subnode in node.body:
                if isinstance(subnode, ast.FunctionDef) and ast.get_docstring(subnode) is None:
                    functions_to_modify.append(subnode)

    return functions_to_modify


def _create_docstring_content(node):
    """Crea il contenuto della docstring per una funzione."""
    # Ottiene i nomi dei parametri
    params = get_function_params(node)

    # Inizia la docstring
    if node.name.startswith("__") and node.name.endswith("__"):
        summary = f"Metodo speciale {node.name}."
    else:
        name_formatted = node.name.replace("_", " ")
        summary = f"{name_formatted.capitalize()}."

    # Rimuovi 'self' dai parametri
    if params and "self" in params:
        params.remove("self")

    docstring_parts = [f'"""{summary}']  # Summary nella prima riga

    # Aggiungi sezione Args se ci sono parametri
    if params:
        docstring_parts.append("")  # Riga vuota
        docstring_parts.append("Args:")
        for param in params:
            docstring_parts.append(f"    {param}: Descrizione di {param}")

        docstring_parts.append("")  # Riga vuota prima di Returns
        docstring_parts.append("Returns:")
        docstring_parts.append("    Descrizione del valore restituito")

    docstring_parts.append('"""')

    return docstring_parts


def _insert_docstring(lines, node, leading_spaces):
    """Inserisce la docstring per una funzione specifica."""
    indent = " " * leading_spaces
    docstring_parts = _create_docstring_content(node)

    # Costruisce la docstring formattata
    docstring_lines = []
    for part in docstring_parts:
        if part == "":
            docstring_lines.append(f"{indent}")
        elif part.startswith("    "):
            docstring_lines.append(f"{indent}{part}")
        else:
            docstring_lines.append(f"{indent}{part}")

    # Inserisce tutte le righe della docstring
    for i, docstring_line in enumerate(docstring_lines):
        lines.insert(node.lineno + i, docstring_line)


def _process_functions(lines, functions_to_modify):
    """Processa tutte le funzioni per aggiungere le docstring."""
    # Modifica le funzioni dalla fine del file verso l'inizio
    # per evitare che gli offset delle righe cambino
    for node in sorted(functions_to_modify, key=lambda n: n.lineno, reverse=True):
        # Determina l'indentazione
        leading_spaces = len(lines[node.lineno - 1]) - len(lines[node.lineno - 1].lstrip())
        _insert_docstring(lines, node, leading_spaces)


def _parse_and_collect_functions(content):
    """Parse del codice e raccolta delle funzioni da modificare."""
    try:
        tree = ast.parse(content)
        functions_to_modify = _collect_functions_to_modify(tree)
        return functions_to_modify
    except SyntaxError:
        return None


def _modify_and_save_file(filepath, content, functions_to_modify):
    """Modifica il file aggiungendo le docstring e lo salva."""
    lines = content.splitlines()
    _process_functions(lines, functions_to_modify)

    path = Path(filepath)
    path.write_text("\n".join(lines), encoding="utf-8")
    print(f"Aggiunte docstring alle funzioni in {filepath}")
    return True


def add_function_docstrings(filepath):
    """Aggiunge docstring alle funzioni e metodi senza docstring.

    Args:
        filepath (str): Percorso del file Python da modificare

    Returns:
        bool: True se sono state aggiunte docstring, altrimenti False
    """
    # 1. Validazione del file
    path = _validate_file_path(filepath)
    if path is None:
        return False

    # 2. Legge il contenuto del file
    content = path.read_text(encoding="utf-8")

    # 3. Parse del codice e raccolta funzioni
    functions_to_modify = _parse_and_collect_functions(content)

    if functions_to_modify is None:
        print(f"Errore di sintassi nel file {filepath}")
        return False

    if not functions_to_modify:
        return False

    # 4. Modifica e salva il file
    return _modify_and_save_file(filepath, content, functions_to_modify)


def main():
    """Funzione principale che processa gli argomenti della linea di comando."""
    if len(sys.argv) != 2:
        print("Uso: python add_docstring.py <file_path>")
        sys.exit(1)

    filepath = sys.argv[1]
    module_modified = add_module_docstring(filepath)
    functions_modified = add_function_docstrings(filepath)

    if module_modified or functions_modified:
        print(f"Docstring aggiunte con successo a {filepath}")
    else:
        print(f"Nessuna modifica apportata a {filepath}")


if __name__ == "__main__":
    main()

"""Add Docstring module.

Questo modulo fornisce funzionalità per add docstring.
"""

import ast
import os
import sys
from pathlib import Path

# Disabilita l'uso delle settings Django se non necessario
if "DJANGO_SETTINGS_MODULE" in os.environ:
    try:
        import django

        django.setup()
    except ImportError:
        pass


def _collect_classes_to_modify(tree):
    """Raccoglie tutte le classi senza docstring."""
    classes_to_modify = []
    for node in ast.walk(tree):
        if isinstance(node, ast.ClassDef) and ast.get_docstring(node) is None:
            classes_to_modify.append(node)
    return classes_to_modify


def _create_class_docstring_content(node):
    """Crea una docstring per una classe."""
    name_formatted = node.name.replace("_", " ")
    if "test" in node.name.lower():
        summary = f"Test suite for {name_formatted}."
    else:
        summary = f"Classe {name_formatted.capitalize()}."
    return [f'"""{summary}"""']


def _insert_class_docstring(lines, node):
    """Inserisce la docstring per una classe specifica."""
    # Trova la posizione corretta per inserire la docstring (dopo eventuali decoratori)
    insert_position = node.lineno
    # Se ci sono decoratori, la definizione della classe può essere più in basso
    for i in range(node.lineno - 1, max(0, node.lineno - 5), -1):
        if lines[i].lstrip().startswith("class "):
            insert_position = i + 1
            break
    indent = " " * (
        len(lines[insert_position - 1]) - len(lines[insert_position - 1].lstrip()) + 4
    )
    docstring_parts = _create_class_docstring_content(node)
    docstring_lines = [f"{indent}{part}" for part in docstring_parts]
    for i, docstring_line in enumerate(docstring_lines):
        lines.insert(insert_position + i, docstring_line)


def _process_classes(lines, classes_to_modify):
    """Processa tutte le classi per aggiungere le docstring."""
    for node in sorted(classes_to_modify, key=lambda n: n.lineno, reverse=True):
        _insert_class_docstring(lines, node)


def _parse_and_collect_classes(content):
    """Parse and collect classes.

    Args:
        content: Descrizione di content

    Returns:
        Descrizione del valore restituito
    """
    try:
        tree = ast.parse(content)
        classes_to_modify = _collect_classes_to_modify(tree)
        return classes_to_modify
    except SyntaxError:
        return None


def _modify_and_save_classes(filepath, content, classes_to_modify):
    """Modify and save classes.

    Args:
        filepath: Descrizione di filepath
        content: Descrizione di content
        classes_to_modify: Descrizione di classes_to_modify

    Returns:
        Descrizione del valore restituito
    """
    lines = content.splitlines()
    _process_classes(lines, classes_to_modify)
    path = Path(filepath)
    path.write_text("\n".join(lines), encoding="utf-8")
    print(f"Aggiunte docstring alle classi in {filepath}")
    return True


def add_class_docstrings(filepath):
    """Aggiunge docstring alle classi senza docstring."""
    path = _validate_file_path(filepath)
    if path is None:
        return False
    content = path.read_text(encoding="utf-8")
    classes_to_modify = _parse_and_collect_classes(content)
    if classes_to_modify is None:
        print(f"Errore di sintassi nel file {filepath}")
        return False
    if not classes_to_modify:
        return False
    return _modify_and_save_classes(filepath, content, classes_to_modify)


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
    module_docstring += (
        f'Questo modulo fornisce funzionalità per {module_name_formatted}.\n"""\n\n'
    )

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

    # Raccoglie solo le funzioni dirette del modulo e i metodi di classe
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef) and ast.get_docstring(node) is None:
            # Verifica che non sia già stata aggiunta
            if not any(
                existing.lineno == node.lineno for existing in functions_to_modify
            ):
                functions_to_modify.append(node)

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
    # L'indentazione della docstring deve essere la stessa del contenuto della funzione
    indent = " " * (leading_spaces + 4)
    docstring_parts = _create_docstring_content(node)

    # Costruisce la docstring formattata
    docstring_lines = []
    for part in docstring_parts:
        if part == '"""':  # Prima e ultima riga della docstring
            docstring_lines.append(f"{indent}{part}")
        elif part == "":  # Righe vuote
            docstring_lines.append("")
        elif part.startswith("    "):  # Argomenti indentati
            docstring_lines.append(f"{indent}{part}")
        else:  # Args:, Returns:, etc.
            docstring_lines.append(f"{indent}{part}")

    # Inserisce la docstring subito dopo la definizione della funzione
    # node.lineno è 1-based, quindi per inserire dopo la definizione usiamo node.lineno (non node.lineno-1)
    insert_position = node.lineno
    for i, docstring_line in enumerate(docstring_lines):
        lines.insert(insert_position + i, docstring_line)


def _process_functions(lines, functions_to_modify):
    """Processa tutte le funzioni per aggiungere le docstring."""
    # Modifica le funzioni dalla fine del file verso l'inizio
    # per evitare che gli offset delle righe cambino
    for node in sorted(functions_to_modify, key=lambda n: n.lineno, reverse=True):
        # Determina l'indentazione
        leading_spaces = len(lines[node.lineno - 1]) - len(
            lines[node.lineno - 1].lstrip()
        )
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
    class_modified = add_class_docstrings(filepath)
    functions_modified = add_function_docstrings(filepath)

    if module_modified or class_modified or functions_modified:
        print(f"Docstring aggiunte con successo a {filepath}")
    else:
        print(f"Nessuna modifica apportata a {filepath}")


if __name__ == "__main__":
    main()

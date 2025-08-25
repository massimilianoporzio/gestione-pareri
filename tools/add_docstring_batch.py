#!/usr/bin/env python
"""
Script per aggiungere docstring a tutti i file Python in un progetto.

Questo script attraversa ricorsivamente una directory e aggiunge docstring
a tutti i file Python che ne sono privi, escludendo i file __init__.py.
"""

import argparse
import os
import sys
from pathlib import Path

# Importa le funzioni dal nostro script esistente
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from add_docstring import add_module_docstring


def should_process_file(file_path):
    """
    Determina se un file dovrebbe essere processato.

    Args:
        file_path (Path): Percorso del file da valutare

    Returns:
        bool: True se il file dovrebbe essere processato, altrimenti False
    """
    # Esclude i file __init__.py
    if file_path.name == "__init__.py":
        return False

    # Esclude altri file che non dovrebbero avere docstring
    excluded = ["migrations", ".venv", "venv", "env", "__pycache__", ".git"]

    # Verifica se il percorso contiene una delle directory escluse
    for exclude_dir in excluded:
        if exclude_dir in str(file_path):
            return False

    return file_path.suffix == ".py"


def process_directory(directory, verbose=False, dry_run=False):
    """
    Elabora ricorsivamente tutti i file Python in una directory.

    Args:
        directory (str): Percorso della directory da elaborare
        verbose (bool): Se True, stampa messaggi dettagliati
        dry_run (bool): Se True, non apporta modifiche ai file

    Returns:
        tuple: (files_processed, files_modified) numeri di file elaborati e modificati
    """
    directory_path = Path(directory)
    files_processed = 0
    files_modified = 0

    if verbose:
        print(f"Elaborazione della directory: {directory}")

    # Ottiene tutti i file nella directory e nelle sottodirectory
    for item in directory_path.glob("**/*"):
        if item.is_file() and should_process_file(item):
            files_processed += 1

            if verbose:
                print(f"Elaborazione del file: {item}")

            if not dry_run:
                if add_module_docstring(str(item)):
                    files_modified += 1
            else:
                print(f"[Dry run] Sarebbe stato elaborato: {item}")

    return files_processed, files_modified


def main():
    """Funzione principale che gestisce gli argomenti da linea di comando."""
    parser = argparse.ArgumentParser(description="Aggiunge docstring a tutti i file Python in una directory")
    parser.add_argument(
        "directory", nargs="?", default=".", help="Directory da elaborare (default: directory corrente)"
    )
    parser.add_argument("-v", "--verbose", action="store_true", help="Visualizza messaggi dettagliati")
    parser.add_argument("--dry-run", action="store_true", help="Esegui senza apportare modifiche")

    args = parser.parse_args()

    print(f"Aggiunta docstring ai file Python in: {args.directory}")
    files_processed, files_modified = process_directory(args.directory, args.verbose, args.dry_run)

    print(f"File Python elaborati: {files_processed}")
    print(f"File Python modificati: {files_modified}")


if __name__ == "__main__":
    main()

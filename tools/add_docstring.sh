#!/bin/bash
# Script per aggiungere docstring ai file Python
# Riceve il percorso del file come parametro $1

# Controlla se il file è un file Python
if [[ $1 != *.py ]]; then
    exit 0
fi

# Ottieni il percorso dello script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Esegui lo script Python per aggiungere docstring
python "$SCRIPT_DIR/../tools/add_docstring.py" "$1"

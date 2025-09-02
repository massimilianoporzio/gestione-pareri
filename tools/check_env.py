"""Utility per verificare le variabili d'ambiente del progetto.

Questo script mostra il valore della variabile DJANGO_ENV attualmente impostata
nel sistema, utile per debugging rapido della configurazione.
"""

import os

print(f"Ambiente caricato: {os.environ.get('DJANGO_ENV', 'non impostato')}")

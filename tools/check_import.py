"""
Utility script per verificare l'importabilità dei moduli di configurazione Django.

Questo script tenta di importare vari moduli di impostazioni Django e mostra
informazioni di debug per aiutare a diagnosticare problemi di importazione.
Inoltre, visualizza il Python path utilizzato dall'ambiente di esecuzione.
"""

import importlib
import sys
from pathlib import Path

# Aggiungi il percorso della directory src per importare i moduli Django
project_root = Path(__file__).resolve().parent.parent
sys.path.append(str(project_root / "src"))

# Test importing all settings modules directly
settings_modules = [
    "home.settings.base",
    "home.settings.dev",
    "home.settings.test",
    "home.settings.prod",
    "home.settings",
]

for module_name in settings_modules:
    try:
        print(f"Tentativo di importare {module_name}...")
        module = importlib.import_module(module_name)
        print(f"  SUCCESS: {module_name}")

        # Check for some key settings
        if hasattr(module, "DEBUG"):
            print(f"  DEBUG: {module.DEBUG}")
        if hasattr(module, "DATABASES") and "default" in module.DATABASES:
            print(f"  DATABASE: {module.DATABASES['default']['ENGINE']}")
    except (ImportError, ModuleNotFoundError) as e:
        print(f"  ERROR: {module_name} - {e}")
    except AttributeError as e:
        print(f"  ERROR: {module_name} - Attributo non trovato: {e}")
    # pylint: disable=broad-except
    except Exception as e:
        # Cattura tutti gli altri tipi di eccezioni che potrebbero verificarsi
        print(f"  ERROR: {module_name} - Errore generico: {e}")

print("\nPython path:")
for path in sys.path:
    print(f"  {path}")

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
    except Exception as e:
        print(f"  ERROR: {module_name} - {e}")

print("\nPython path:")
for path in sys.path:
    print(f"  {path}")

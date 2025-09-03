# VS Code Test Discovery Helper
# Questo script aiuta VS Code a scoprire i test Django

import os
import sys
import django

# Aggiungi il percorso src al PYTHONPATH
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

# Configura Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'home.settings.test')
django.setup()

# Importa tutti i test
from accounts.tests import *

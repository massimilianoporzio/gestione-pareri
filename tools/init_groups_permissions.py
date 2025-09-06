#!/usr/bin/env python
"""Script per inizializzare gruppi e permessi di base del sistema.

Crea:
- Gruppo "Full Access Admin" con tutti i permessi
- Altri gruppi base se necessari
"""

import os
import sys

import django
from django.contrib.auth.models import Group, Permission

# Configurazione Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "home.settings")
django.setup()


def create_full_access_group():
    """Crea il gruppo Full Access Admin con tutti i permessi."""
    # Costante per il nome del gruppo (come nel tuo progetto originale)
    full_access_group_name = "Full Access Admin"

    print(f"🔐 Creazione gruppo '{full_access_group_name}'...")

    # Crea o ottieni il gruppo
    group, created = Group.objects.get_or_create(name=full_access_group_name)

    if created:
        print(f"✅ Gruppo '{full_access_group_name}' creato con successo")
    else:
        print(f"ℹ️  Gruppo '{full_access_group_name}' già esistente")

    # Ottieni tutti i permessi disponibili
    all_permissions = Permission.objects.all()

    print(f"🔑 Assegnazione di {all_permissions.count()} permessi al gruppo...")

    # Assegna tutti i permessi al gruppo
    group.permissions.set(all_permissions)

    print(f"✅ Tutti i permessi assegnati al gruppo '{full_access_group_name}'")

    return group


def create_base_groups():
    """Crea altri gruppi di base se necessari."""
    # Puoi aggiungere qui altri gruppi base
    base_groups = [
        {
            "name": "Operatori Base",
            "description": "Operatori con permessi limitati",
            "permissions": [],  # Aggiungi qui i permessi specifici se necessari
        },
        # Aggiungi altri gruppi se necessari
    ]

    for group_info in base_groups:
        group, created = Group.objects.get_or_create(name=group_info["name"])
        if created:
            print(f"✅ Gruppo '{group_info['name']}' creato")
        else:
            print(f"ℹ️  Gruppo '{group_info['name']}' già esistente")


def main():
    """Funzione principale."""
    print("🚀 Inizializzazione gruppi e permessi di base...")
    print("=" * 60)

    try:
        # Crea il gruppo Full Access Admin
        full_access_group = create_full_access_group()

        # Crea altri gruppi base
        create_base_groups()

        print("=" * 60)
        print("✅ Inizializzazione completata con successo!")
        print(
            f"ℹ️  Il gruppo 'Full Access Admin' ha {full_access_group.permissions.count()} permessi"
        )

    except Exception as e:
        print(f"❌ Errore durante l'inizializzazione: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()

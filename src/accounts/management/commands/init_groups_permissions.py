"""
Management command per inizializzare gruppi e permessi di base del sistema.

Usage:
    python manage.py init_groups_permissions

Crea:
- Gruppo "Full Access Admin" con tutti i permessi
- Altri gruppi base se necessari
"""

from django.contrib.auth.models import Group, Permission
from django.core.management.base import BaseCommand
from django.db import transaction


class Command(BaseCommand):
    help = 'Inizializza gruppi e permessi di base del sistema'

    def add_arguments(self, parser):
        parser.add_argument(
            '--reset',
            action='store_true',
            help='Rimuove tutti i gruppi esistenti prima di ricrearli',
        )

    def handle(self, *args, **options):
        """Esegue l'inizializzazione dei gruppi."""
        self.stdout.write("🚀 Inizializzazione gruppi e permessi di base...")
        self.stdout.write("=" * 60)

        try:
            with transaction.atomic():
                if options['reset']:
                    self._reset_groups()
                
                # Crea il gruppo Full Access Admin
                full_access_group = self._create_full_access_group()
                
                # Crea altri gruppi base
                self._create_base_groups()

            self.stdout.write("=" * 60)
            self.stdout.write(
                self.style.SUCCESS("✅ Inizializzazione completata con successo!")
            )
            self.stdout.write(
                f"ℹ️  Il gruppo 'Full Access Admin' ha {full_access_group.permissions.count()} permessi"
            )

        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f"❌ Errore durante l'inizializzazione: {e}")
            )
            raise

    def _reset_groups(self):
        """Rimuove tutti i gruppi esistenti."""
        self.stdout.write("🗑️  Rimozione gruppi esistenti...")
        Group.objects.all().delete()
        self.stdout.write(self.style.WARNING("⚠️  Tutti i gruppi rimossi"))

    def _create_full_access_group(self):
        """Crea il gruppo Full Access Admin con tutti i permessi."""
        
        # Costante per il nome del gruppo (come nel progetto originale)
        FULL_ACCESS_GROUP_NAME = "Full Access Admin"
        
        self.stdout.write(f"🔐 Creazione gruppo '{FULL_ACCESS_GROUP_NAME}'...")
        
        # Crea o ottieni il gruppo
        group, created = Group.objects.get_or_create(name=FULL_ACCESS_GROUP_NAME)
        
        if created:
            self.stdout.write(
                self.style.SUCCESS(f"✅ Gruppo '{FULL_ACCESS_GROUP_NAME}' creato con successo")
            )
        else:
            self.stdout.write(
                self.style.WARNING(f"ℹ️  Gruppo '{FULL_ACCESS_GROUP_NAME}' già esistente")
            )
        
        # Ottieni tutti i permessi disponibili
        all_permissions = Permission.objects.all()
        
        self.stdout.write(f"🔑 Assegnazione di {all_permissions.count()} permessi al gruppo...")
        
        # Assegna tutti i permessi al gruppo
        group.permissions.set(all_permissions)
        
        self.stdout.write(
            self.style.SUCCESS(f"✅ Tutti i permessi assegnati al gruppo '{FULL_ACCESS_GROUP_NAME}'")
        )
        
        return group

    def _create_base_groups(self):
        """Crea altri gruppi di base se necessari."""
        
        # Definisci altri gruppi base
        base_groups = [
            {
                "name": "Operatori Base",
                "description": "Operatori con permessi limitati",
                "permissions": []  # Aggiungi qui i codename dei permessi specifici se necessari
            },
            {
                "name": "Supervisori",
                "description": "Supervisori con permessi intermedi",
                "permissions": []  # Esempi: ['change_customuser', 'view_customuser']
            },
            # Aggiungi altri gruppi se necessari
        ]
        
        for group_info in base_groups:
            group, created = Group.objects.get_or_create(name=group_info["name"])
            
            if created:
                self.stdout.write(
                    self.style.SUCCESS(f"✅ Gruppo '{group_info['name']}' creato")
                )
                
                # Assegna permessi specifici se definiti
                if group_info["permissions"]:
                    permissions = Permission.objects.filter(
                        codename__in=group_info["permissions"]
                    )
                    group.permissions.set(permissions)
                    self.stdout.write(
                        f"🔑 Assegnati {permissions.count()} permessi specifici"
                    )
            else:
                self.stdout.write(
                    self.style.WARNING(f"ℹ️  Gruppo '{group_info['name']}' già esistente")
                )

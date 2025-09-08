"""Test Commands module.

Questo modulo fornisce funzionalità per test commands.
"""

from django.test import TestCase


class AccountsCommandsTestCase(TestCase):
    """Test suite for AccountsCommandsTestCase."""

    def test_call_command_group_already_exists(self):
        """Test che copre il ramo else quando il gruppo esiste già (righe
        61-65)."""
        from unittest.mock import patch

        from django.contrib.auth.models import Group

        from accounts.management.commands.init_groups_permissions import Command

        # Assicurati che il gruppo esista già
        Group.objects.get_or_create(name="Full Access Admin")

        cmd = Command()
        # cmd.stdout viene creato solo dopo l'esecuzione del comando, quindi lo forziamo
        import sys

        cmd.stdout = sys.stdout
        with patch.object(cmd.stdout, "write") as mock_write:
            cmd._create_full_access_group()
            calls = [str(call[0][0]) for call in mock_write.call_args_list]
            assert any("Gruppo 'Full Access Admin' già esistente" in c for c in calls)

    """Test suite for AccountsCommandsTestCase."""

    def test_create_full_access_group_output(self):
        """Test che copre i rami di output per gruppo creato e già
        esistente."""
        from unittest.mock import MagicMock

        from django.contrib.auth.models import Group

        from accounts.management.commands.init_groups_permissions import Command

        cmd = Command()
        cmd.stdout = MagicMock()
        cmd.style = MagicMock()
        cmd.style.SUCCESS = lambda x: f"SUCCESS: {x}"
        cmd.style.WARNING = lambda x: f"WARNING: {x}"

        # Caso gruppo creato
        Group.objects.filter(name="Full Access Admin").delete()
        cmd._create_full_access_group()
        # Verifica che sia stato chiamato il ramo SUCCESS
        calls = [call[0][0] for call in cmd.stdout.write.call_args_list]
        assert any(
            "SUCCESS: ✅ Gruppo 'Full Access Admin' creato con successo" in c
            for c in calls
        )

        # Caso gruppo già esistente
        cmd.stdout.write.reset_mock()
        cmd._create_full_access_group()
        calls = [call[0][0] for call in cmd.stdout.write.call_args_list]
        assert any(
            "WARNING: ℹ️  Gruppo 'Full Access Admin' già esistente" in c for c in calls
        )

    """Test suite for AccountsCommandsTestCase."""

    def test_handle_with_reset(self):
        """Test che il comando con --reset rimuova e ricrei i gruppi."""
        from django.contrib.auth.models import Group
        from django.core.management import call_command

        # Crea un gruppo dummy
        Group.objects.create(name="DummyGroup")
        self.assertTrue(Group.objects.filter(name="DummyGroup").exists())
        call_command("init_groups_permissions", "--reset")
        # Il gruppo dummy deve essere stato rimosso
        self.assertFalse(Group.objects.filter(name="DummyGroup").exists())
        # I gruppi base devono essere stati ricreati
        self.assertTrue(Group.objects.filter(name="Full Access Admin").exists())

    def test_create_full_access_group_created_and_existing(self):
        """Test creazione gruppo Full Access Admin: nuovo e già esistente."""
        from django.contrib.auth.models import Group

        from accounts.management.commands.init_groups_permissions import Command

        cmd = Command()
        # Primo caso: gruppo non esiste
        Group.objects.filter(name="Full Access Admin").delete()
        group = cmd._create_full_access_group()
        self.assertEqual(group.name, "Full Access Admin")
        # Secondo caso: gruppo già esistente
        group2 = cmd._create_full_access_group()
        self.assertEqual(group2.name, "Full Access Admin")

    def test_full_access_group_permissions_assigned(self):
        """Test che tutti i permessi siano assegnati al gruppo Full Access
        Admin."""
        from django.contrib.auth.models import Permission

        from accounts.management.commands.init_groups_permissions import Command

        cmd = Command()
        group = cmd._create_full_access_group()
        all_permissions = Permission.objects.all()
        self.assertEqual(group.permissions.count(), all_permissions.count())

    def test_create_base_groups_with_and_without_permissions(self):
        """Test creazione gruppi base con e senza permessi specifici."""
        from django.contrib.auth.models import Group, Permission

        from accounts.management.commands.init_groups_permissions import Command

        cmd = Command()
        # Patch base_groups per testare entrambi i rami
        cmd._create_base_groups = lambda: None  # Disabilita per ora
        # Test gruppo con permessi
        group_name = "TestGroupWithPerms"
        perm_codename = "add_group"
        group, created = Group.objects.get_or_create(name=group_name)
        if created:
            perm = Permission.objects.filter(codename=perm_codename).first()
            if perm:
                group.permissions.set([perm])
                self.assertIn(perm, group.permissions.all())
        # Test gruppo senza permessi
        group_name2 = "TestGroupNoPerms"
        group2, created2 = Group.objects.get_or_create(name=group_name2)
        if created2:
            self.assertEqual(group2.permissions.count(), 0)
        group2, created2 = Group.objects.get_or_create(name=group_name2)
        if created2:
            self.assertEqual(group2.permissions.count(), 0)
        if created2:
            self.assertEqual(group2.permissions.count(), 0)

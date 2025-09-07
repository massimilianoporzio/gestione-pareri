"""Test Models module.

Questo modulo fornisce funzionalità per test models.
"""

"""Test Models module.

Questo modulo fornisce funzionalità per test models.
"""

from django.test import TestCase


class AccountsModelsTestCase(TestCase):
    """Test suite for AccountsModelsTestCase."""

    def test_class_attributes_and_fields(self):
        """Test class attributes and fields."""
        from accounts.models import CustomUser

        # Coverage for USERNAME_FIELD and version
        self.assertEqual(CustomUser.USERNAME_FIELD, "email")
        user = CustomUser(email="cover@aslcn1.it")
        self.assertIsInstance(user.version, int)

    def test_created_updated_fields_and_methods(self):
        """Test created updated fields and methods."""
        from accounts.models import CustomUser

        # Crea utente corrente
        current_user = CustomUser.objects.create(email="creator@aslcn1.it", first_name="Creatore", password="pass")
        # Patch get_current_user
        import accounts.models as models_mod

        models_mod.get_current_user = lambda: current_user
        # Crea utente da test
        user = CustomUser(email="test@aslcn1.it", first_name="Mario", last_name="Rossi")
        user.save()
        # Coverage: created_by, updated_by, created_at, updated_at
        self.assertEqual(user.created_by, current_user)
        self.assertEqual(user.updated_by, current_user)
        self.assertIsNotNone(user.created_at)
        self.assertIsNotNone(user.updated_at)
        # Coverage: __str__, email_prefix_display, nome_utente, get_short_name
        self.assertEqual(str(user), user.get_full_name())
        self.assertEqual(user.email_prefix_display, "test")
        self.assertEqual(user.nome_utente, "Mario Rossi")
        self.assertEqual(user.get_short_name(), "test")

    def test_clean_method(self):
        """Test clean method."""
        from accounts.models import CustomUser

        user = CustomUser(email="wrong@otherdomain.it")
        with self.assertRaises(Exception):
            user.clean()
        user.email = "ok@aslcn1.it"
        # Non deve sollevare
        user.clean()

    def test_save_branches(self):
        """Test save branches."""
        # Patch get_current_user per utente anonimo
        import accounts.models as models_mod
        from accounts.models import CustomUser

        class Anon:
            """Classe Anon."""

            is_anonymous = True

        models_mod.get_current_user = lambda: Anon()
        user = CustomUser(email="anon@aslcn1.it")
        user.save()
        # Nessun errore, coverage per ramo utente anonimo

    """Test suite for AccountsModelsTestCase."""

    def test_authenticate_with_email(self):
        """Test authenticate with email."""
        from django.contrib.auth import authenticate

        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="auth@aslcn1.it")
        user.set_password("pass")
        user.save()
        authenticated = authenticate(email="auth@aslcn1.it", password="pass")
        self.assertEqual(authenticated, user)

    def test_version_field_update(self):
        """Test version field update."""
        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="ver@aslcn1.it", password="pass")
        old_version = user.version
        user.first_name = "NuovoNome"
        user.save()
        self.assertTrue(user.version > old_version)

    def test_created_by_updated_by_with_mock(self):
        """Test created_by/updated_by con CustomUser reale come utente corrente."""
        import accounts.models as models_mod
        from accounts.models import CustomUser

        current_user = CustomUser.objects.create(email="creator@aslcn1.it", first_name="Creatore", password="pass")

        def dummy_get_current_user():
            """Dummy get current user."""
            return current_user

        models_mod.get_current_user = dummy_get_current_user
        user = CustomUser(email="audit@aslcn1.it")
        user.save()
        self.assertEqual(user.created_by_fullname, current_user.nome_utente)
        self.assertEqual(user.updated_by_fullname, current_user.nome_utente)

    def test_updated_at_changes_on_save(self):
        """Test updated at changes on save."""
        import time

        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="date@aslcn1.it", password="pass")
        old_updated = user.updated_at
        time.sleep(1)
        user.first_name = "Test"
        user.save()
        self.assertTrue(user.updated_at > old_updated)

    """Test suite for AccountsModelsTestCase."""

    def test_create_user_email_auth_field(self):
        """Test create user email auth field."""
        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="test@aslcn1.it", password="pass")
        self.assertEqual(user.USERNAME_FIELD, "email")

    def test_version_field(self):
        """Test version field."""
        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="test2@aslcn1.it", password="pass")
        self.assertIsNotNone(user.version)

    def test_created_updated_by_fields(self):
        """Test created/updated_by con CustomUser reale come utente corrente."""
        import accounts.models as models_mod
        from accounts.models import CustomUser

        current_user = CustomUser.objects.create(email="creator2@aslcn1.it", first_name="Creatore2", password="pass")

        def dummy_get_current_user():
            """Dummy get current user."""
            return current_user

        models_mod.get_current_user = dummy_get_current_user
        user = CustomUser(email="test3@aslcn1.it")
        user.save()
        self.assertEqual(user.created_by, current_user)
        self.assertEqual(user.updated_by, current_user)

    def test_created_at_updated_at_fields(self):
        """Test created at updated at fields."""
        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="test4@aslcn1.it", password="pass")
        self.assertIsNotNone(user.created_at)
        self.assertIsNotNone(user.updated_at)

    def test_str_method(self):
        """Test str method."""
        from accounts.models import CustomUser

        user = CustomUser.objects.create(
            email="test5@aslcn1.it", first_name="Mario", last_name="Rossi", password="pass"
        )
        self.assertEqual(str(user), user.get_full_name())

    """Test suite for AccountsModelsTestCase."""

    def test_dummy(self):
        """Test dummy."""
        self.assertTrue(True)

"""Test Models module.

Questo modulo fornisce funzionalità per test models.
"""

from django.test import TestCase


class AccountsModelsTestCase(TestCase):
    """Test suite for AccountsModelsTestCase."""

    def test_create_user_valueerror_no_email(self):
        """Test create user valueerror no email."""
        from accounts.models import CustomUserManager

        manager = CustomUserManager()
        with self.assertRaises(ValueError):
            manager.create_user(email=None, password="pass")

    """Test suite for AccountsModelsTestCase."""

    def test_email_prefix_display_empty(self):
        """Test email prefix display empty."""
        from accounts.models import CustomUser

        user = CustomUser()
        self.assertEqual(user.email_prefix_display, "")

    def test_nome_utente_first_last(self):
        """Test nome utente first last."""
        from accounts.models import CustomUser

        user = CustomUser(first_name="Mario", last_name="Rossi")
        self.assertEqual(user.nome_utente, "Mario Rossi")

    def test_nome_utente_only_first(self):
        """Test nome utente only first."""
        from accounts.models import CustomUser

        user = CustomUser(first_name="Mario")
        self.assertEqual(user.nome_utente, "Mario")

    def test_nome_utente_only_last(self):
        """Test nome utente only last."""
        from accounts.models import CustomUser

        user = CustomUser(last_name="Rossi")
        self.assertEqual(user.nome_utente, "Rossi")

    def test_nome_utente_none(self):
        """Test nome utente none."""
        from accounts.models import CustomUser

        user = CustomUser(email="test@aslcn1.it")
        self.assertEqual(user.nome_utente, user.get_short_name())

    """Test suite for AccountsModelsTestCase."""

    def test_manager_full_clean_validationerror(self):
        """Test manager full clean validationerror."""
        from accounts.models import CustomUserManager

        manager = CustomUserManager()
        with self.assertRaises(Exception):
            manager.full_clean("wrong@otherdomain.it")

    def test_model_clean_validationerror(self):
        """Test model clean validationerror."""
        from accounts.models import CustomUser

        user = CustomUser(email="wrong@otherdomain.it")
        with self.assertRaises(Exception):
            user.clean()

    def test_create_superuser_valueerror_is_staff(self):
        """Test create superuser valueerror is staff."""
        from accounts.models import CustomUser

        with self.assertRaises(ValueError):
            CustomUser.objects.create_superuser(email="admin@aslcn1.it", password="superpass", is_staff=False)

    def test_create_superuser_valueerror_is_superuser(self):
        """Test create superuser valueerror is superuser."""
        from accounts.models import CustomUser

        with self.assertRaises(ValueError):
            CustomUser.objects.create_superuser(email="admin@aslcn1.it", password="superpass", is_superuser=False)

    """Test suite for AccountsModelsTestCase."""

    def test_create_superuser_method(self):
        """Test create superuser method."""
        from accounts.models import CustomUser

        superuser = CustomUser.objects.create_superuser(email="admin@aslcn1.it", password="superpass")
        self.assertTrue(superuser.is_superuser)
        self.assertTrue(superuser.is_staff)
        self.assertTrue(superuser.is_active)
        self.assertEqual(superuser.email, "admin@aslcn1.it")

    """Test suite for AccountsModelsTestCase."""

    @classmethod
    def setUpTestData(cls):
        """Setuptestdata.

        Args:
            cls: Descrizione di cls

        Returns:
            Descrizione del valore restituito
        """
        from accounts.models import CustomUser

        cls.creator = CustomUser.objects.create(email="creator3@aslcn1.it", first_name="Creatore3", password="pass")

    def test_manual_created_by_field(self):
        """Test manual created by field: assegna esplicitamente il campo created_by usando setUpTestData."""
        import accounts.models as models_mod
        from accounts.models import CustomUser

        # Patch get_current_user per restituire un utente anonimo
        class Anon:
            """Classe Anon."""

            is_anonymous = True

        models_mod.get_current_user = lambda: Anon()
        user = CustomUser.objects.create(
            email="manual@aslcn1.it", first_name="Manuale", password="pass", created_by=self.creator
        )
        self.assertEqual(user.created_by, self.creator)

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
        import accounts.models as models_mod
        from accounts.models import CustomUser

        # Patch get_current_user per restituire utente persistente
        models_mod.get_current_user = lambda: self.creator
        user = CustomUser(email="test@aslcn1.it", first_name="Mario", last_name="Rossi")
        user.save()
        # Coverage: created_by, updated_by, created_at, updated_at
        self.assertEqual(user.created_by, self.creator)
        self.assertEqual(user.updated_by, self.creator)
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
        import accounts.models as models_mod

        models_mod.get_current_user = lambda: self.creator
        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="test@aslcn1.it", password="pass")
        self.assertEqual(user.USERNAME_FIELD, "email")

    def test_version_field(self):
        """Test version field."""
        import accounts.models as models_mod

        models_mod.get_current_user = lambda: self.creator
        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="test2@aslcn1.it", password="pass")
        self.assertIsNotNone(user.version)

    def test_created_updated_by_fields(self):
        """Test created/updated_by con CustomUser reale come utente corrente."""
        import accounts.models as models_mod
        from accounts.models import CustomUser

        # Patch get_current_user per restituire utente persistente
        models_mod.get_current_user = lambda: self.creator
        user = CustomUser(email="test3@aslcn1.it")
        user.save()
        self.assertEqual(user.created_by, self.creator)
        self.assertEqual(user.updated_by, self.creator)

    def test_created_at_updated_at_fields(self):
        """Test created at updated at fields."""
        import accounts.models as models_mod

        models_mod.get_current_user = lambda: self.creator
        from accounts.models import CustomUser

        user = CustomUser.objects.create(email="test4@aslcn1.it", password="pass")
        self.assertIsNotNone(user.created_at)
        self.assertIsNotNone(user.updated_at)

    def test_str_method(self):
        """Test str method."""
        import accounts.models as models_mod

        models_mod.get_current_user = lambda: self.creator
        from accounts.models import CustomUser

        user = CustomUser.objects.create(
            email="test5@aslcn1.it",
            first_name="Mario",
            last_name="Rossi",
            password="pass",
        )
        self.assertEqual(str(user), user.get_full_name())

    """Test suite for AccountsModelsTestCase."""

    def test_dummy(self):
        """Test dummy."""
        self.assertTrue(True)

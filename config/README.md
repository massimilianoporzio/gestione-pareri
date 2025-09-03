# 🗂️ Configuration Directory

This directory contains configuration files organized by purpose:

## 📁 **Directory Structure**

### `/environments/`

Environment configuration templates and examples:

- `.env.dev.template` - Development environment template
- `.env.prod.template` - Production environment template
- `.env.staging.template` - Staging environment template
- `.env.test.template` - Test environment template
- `.env.*.example` - Example configurations for different setups

### `/database/`

Database-related configuration files:

- `db_credentials.template.md` - Database credentials template
- `postgresql_commands.txt` - Useful PostgreSQL commands
- `*.sql` - Database update/migration scripts

### `/deployment/`

Deployment configuration files:

- `web.config.template` - IIS configuration template
- `deployment-plan.md` - Production deployment guide
- Platform-specific setup instructions

## 🔧 **Usage**

1. **Environment Setup**: Copy templates from `/environments/` to project root and customize
2. **Database Setup**: Use files in `/database/` for database configuration
3. **Deployment**: Follow guides and use templates in `/deployment/`

## 🔒 **Security Note**

- Templates are safe to commit to repository
- Actual `.env` files with real credentials should be gitignored
- Never commit real passwords or API keys

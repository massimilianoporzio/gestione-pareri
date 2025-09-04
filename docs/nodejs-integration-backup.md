# Tailwind CSS v4 + Django Integration Guide

Questa guida spiega come usare **Tailwind CSS v4** con **Django** usando la CLI ufficiale.

## 🎯 Overview

Tailwind CSS v4 semplifica drasticamente l'integrazione con Django:

- ✅ **Zero configurazione** - niente `tailwind.config.js`
- ✅ **Auto-discovery** - rileva automaticamente classi nei template
- ✅ **CLI standalone** - nessun build system complesso necessario
- ✅ **Django-friendly** - funziona perfettamente con `collectstatic`

## 📋 Prerequisites

Assicurati di avere Node.js installato (solo per installare Tailwind CLI):

```bash
# Controlla se Node.js è installato
node --version
npm --version  # oppure yarn --version o pnpm --version

# Se non installato, scarica da: <https://nodejs.org/>
```

## 🚀 Setup Tailwind CSS v4

### 1. Installa Tailwind CSS CLI

```bash
# Con npm
npm install tailwindcss @tailwindcss/cli

# Con yarn
yarn add tailwindcss @tailwindcss/cli

# Con pnpm
pnpm add tailwindcss @tailwindcss/cli
```

### 2. Crea il file CSS di input

```bash
# Crea il file CSS sorgente
echo '@import "tailwindcss";' > src/static/css/style.css
```

### 3. Compila il CSS per la prima volta

```bash
# Con npm
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify

# Con yarn
yarn @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify

# Con pnpm
pnpm @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
```

## 🎨 File CSS di Input (Opzionale)

Il file `src/static/css/style.css` può contenere solo `@import "tailwindcss";` oppure puoi aggiungere componenti personalizzati:

```css
/* Solo questa riga è essenziale! Tailwind v4 gestisce tutto automaticamente */
@import "tailwindcss";

/*
🎯 ESEMPI OPZIONALI - Componenti personalizzati per Django
Puoi personalizzare questi esempi o creare i tuoi componenti secondo le tue necessità
*/
@layer components {
  /* Esempio: styling base per input form Django */
  .form-input {
    @apply block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500;
  }

  /* Esempio: bottoni con stili coerenti */
  .btn-primary {
    @apply px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500;
  }

  /* Esempio: messaggi Django stilizzati (adatta ai tuoi colori/design) */
  .django-messages {
    @apply mb-4 px-4 py-3 rounded-md border;
  }

  .django-messages.success {
    @apply bg-green-50 border-green-200 text-green-800;
  }

  .django-messages.error {
    @apply bg-red-50 border-red-200 text-red-800;
  }

  .django-messages.warning {
    @apply bg-yellow-50 border-yellow-200 text-yellow-800;
  }

  .django-messages.info {
    @apply bg-blue-50 border-blue-200 text-blue-800;
  }
}

/*
💡 SUGGERIMENTO: Puoi anche usare solo classi utility direttamente nei template
senza definire componenti personalizzati - dipende dalle tue preferenze!
*/
```

````

## 🔗 Inclusione nei Template Django

Includi il CSS compilato nei tuoi template Django:

```html
<!-- src/templates/base.html -->
{% load static %}
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Django + Tailwind v4{% endblock %}</title>

    <!-- Includi il CSS compilato da Tailwind -->
    <link href="{% static 'css/tailwind.css' %}" rel="stylesheet">
</head>
<body>
    <!-- I tuoi template possono usare classi Tailwind -->
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-900">
            Django + Tailwind v4
        </h1>

        {% if messages %}
            {% for message in messages %}
                <div class="django-messages {{ message.tags }}">
                    {{ message }}
                </div>
            {% endfor %}
        {% endif %}

        {% block content %}{% endblock %}
    </div>
</body>
</html>
````

```json
{
  "name": "deploy-django-tailwind",
  "version": "1.0.0",
  "description": "Django with Tailwind CSS v4",
  "scripts": {
    "build:css": "npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify",
    "watch:css": "npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify --watch",
    "dev": "npm run watch:css"
  },
  "dependencies": {
    "@tailwindcss/cli": "^4.1.4",
    "tailwindcss": "^4.1.4"
  }
}
```

## ⚙️ Comandi Tailwind CLI Essenziali

### Build per Sviluppo (con watch)

```bash
# Ricompila automaticamente quando cambi i template Django
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch

# Con yarn
yarn @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch

# Con pnpm
pnpm @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch
```

### Build per Produzione (minificato)

```bash
# Build ottimizzato per produzione
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify

# Con yarn
yarn @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify

# Con pnpm
pnpm @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
```

**Includi il CSS nei template Django:**

```html
<!-- src/templates/base.html -->
{% load static %}
<!doctype html>
<html lang="it">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{% block title %}Il mio sito Django{% endblock %}</title>

    <!-- Tailwind CSS compilato -->
    <link href="{% static 'css/tailwind.css' %}" rel="stylesheet" />
  </head>
  <body class="bg-gray-100">
    <!-- Messaggi Django stilizzati -->
    {% if messages %} {% for message in messages %}
    <div class="django-messages {{ message.tags }}">{{ message }}</div>
    {% endfor %} {% endif %}

    <div class="container mx-auto px-4 py-8">
      {% block content %} {% endblock %}
    </div>
  </body>
</html>
```

**Esempio di form Django con Tailwind:**

```html
<!-- src/templates/form.html -->
{% extends 'base.html' %} {% block content %}
<form method="post" class="max-w-md mx-auto bg-white rounded-lg shadow-md p-6">
  {% csrf_token %}

  <div class="mb-4">
    <label
      for="{{ form.name.id_for_label }}"
      class="block text-sm font-medium text-gray-700 mb-2"
    >
      Nome
    </label>
    {{ form.name|add_class:"form-input" }}
  </div>

  <div class="mb-6">
    <label
      for="{{ form.email.id_for_label }}"
      class="block text-sm font-medium text-gray-700 mb-2"
    >
      Email
    </label>
    {{ form.email|add_class:"form-input" }}
  </div>

  <button type="submit" class="btn-primary w-full">Invia</button>
</form>
{% endblock %}
```

### Opzione A1: django-tailwind (Package Python)

**Alternativa più integrata:**

```bash
# Installa django-tailwind
pip install django-tailwind[reload]

# Oppure con uv
uv add django-tailwind[reload]
```

**Configura in `settings.py`:**

```python
INSTALLED_APPS = [
    # ... altre app
    'tailwind',
    'theme',  # App generata da tailwind
]

TAILWIND_APP_NAME = 'theme'
INTERNAL_IPS = ["127.0.0.1"]
```

**Setup iniziale:**

```bash
# Crea app tailwind
python manage.py tailwind init

# Installa dipendenze
python manage.py tailwind install

# Build CSS
python manage.py tailwind build

# Watch mode per development
python manage.py tailwind start
```

## 🔄 Workflow Sviluppo

### Durante lo sviluppo (2 terminali)

```bash
# Terminal 1: Django server
make run-server

# Terminal 2: Tailwind watch (ricompila automaticamente)
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch
```

### Per produzione

```bash
# 1. Build CSS ottimizzato
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify

# 2. Collect static files Django
make collectstatic

# 3. Deploy
make deploy
```

### 2. Build per Produzione

````bash
# 1. Build CSS ottimizzato (Tailwind v4 con auto-discovery)
npm run build:css   # Con npm
# oppure
yarn build:css      # Con yarn
# oppure
pnpm build:css      # Con pnpm

# 2. Collect static files Django (include il CSS compilato)
make collectstatic

# 3. Deploy
make deploy
```**🚀 Note Tailwind v4:**

- Non serve più specificare i `content paths` - rileva automaticamente i file
- Il build è più veloce perché non deve leggere configurazioni complesse
- Meno file da mantenere nel progetto

**Con django-tailwind:**

```bash
# 1. Build CSS per produzione
python manage.py tailwind build

# 2. Collect static files
make collectstatic

# 3. Deploy
make deploy
````

## 📁 Struttura File Essenziale

```

deploy-django/
├── src/
│   ├── static/
│   │   └── css/
│   │       ├── style.css          # Input: @import "tailwindcss"
│   │       └── tailwind.css       # Output: CSS compilato
│   ├── templates/                 # Template Django (auto-rilevati da Tailwind v4)
│   │   └── base.html
│   └── manage.py
├── node_modules/                  # Dipendenze Tailwind (auto-generato)
└── package.json                   # Solo per installare Tailwind CLI

```

**File necessari:**

- ✅ `src/static/css/style.css` - Input CSS con `@import "tailwindcss"`
- ✅ `src/static/css/tailwind.css` - Output compilato (incluso nei template)
- ✅ Template Django con classi Tailwind
- ❌ `tailwind.config.js` - NON necessario in v4!

## 🚀 Quick Start Essenziale

```bash
# 1. Installa Tailwind CSS CLI
npm install tailwindcss @tailwindcss/cli
# oppure: yarn add tailwindcss @tailwindcss/cli
# oppure: pnpm add tailwindcss @tailwindcss/cli

# 2. Crea file CSS input
echo '@import "tailwindcss";' > src/static/css/style.css

# 3. Compila CSS (prima volta)
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify

# 4. Includi nei template Django
# <link href="{% static 'css/tailwind.css' %}" rel="stylesheet">

# 5. Durante sviluppo (watch mode)
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch

# 6. Per produzione
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
make collectstatic
```

**🎯 Fatto! Zero configurazione, funziona subito con Django.**

---

💡 **Tailwind v4 = Semplicità**: Solo CLI, nessun config file, auto-discovery dei template Django!

````

## 🔍 Controlli di Qualità

### ESLint per JavaScript

```bash
npm install --save-dev eslint @eslint/js
npx eslint --init
````

### Prettier per formattazione

```bash
npm install --save-dev prettier
echo '{"semi": true, "singleQuote": true, "tabWidth": 2}' > .prettierrc
```

### Stylelint per CSS

```bash
npm install --save-dev stylelint stylelint-config-standard
echo '{"extends": "stylelint-config-standard"}' > .stylelintrc.json
```

## 🚀 Framework Moderni

### Next.js Integration

Se vuoi usare Next.js per il frontend:

```bash
# Crea app Next.js in una sottodirectory
npx create-next-app@latest frontend
cd frontend

# Build per produzione
npm run build
npm run export

# Copia output in Django static
cp -r out/* ../src/static/
```

### Vue.js/React Components

```bash
# Vue.js
npm install --save-dev vue @vue/compiler-sfc vue-loader

# React
npm install --save-dev react react-dom @babel/preset-react
```

## 🔧 Troubleshooting

### Problemi comuni

1. **node_modules troppo grande**: Aggiungi a .gitignore (già fatto)
2. **Build lenti**: Usa webpack-dev-server per development
3. **Conflitti di porte**: Django usa 8000, frontend dev server può usare 3000
4. **Path assoluti**: Usa `path.resolve()` in webpack config

### Debug

```bash
# Controlla configurazione webpack
npx webpack --help

# Debug build
npm run build -- --verbose

# Controlla file generati
ls -la src/static/dist/
```

## 📚 Risorse Utili

- [Webpack Documentation](https://webpack.js.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Django Static Files](https://docs.djangoproject.com/en/stable/howto/static-files/)
- [WhiteNoise Documentation](http://whitenoise.evans.io/)

## 🎯 Best Practices Django + Tailwind v4

### 1. **Tailwind CSS v4 con Django** 🚀

- ✅ **Usa approccio nativo v4** - niente `django-tailwind` (ancora v3)
- ✅ **Zero configurazione** - elimina `tailwind.config.js`
- ✅ **Auto-discovery** - Tailwind trova automaticamente le classi
- ✅ **Build ottimizzato** - solo le classi usate nei template
- ✅ **Usa `@import "tailwindcss"`** invece di 3 direttive separate
- 💡 **Componenti CSS opzionali** - puoi usare solo utility classes nei template

### 2. **CSS Organization (Esempi Suggeriti)**

```css
/* src/static/css/style.css - Approccio v4 */
@import "tailwindcss";

/*
🎯 ESEMPI di componenti Django-specific
Personalizza questi esempi secondo il tuo design system
*/
@layer components {
  /* ESEMPIO: Form styling per Django - adatta ai tuoi colori */
  .form-input {
    @apply block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500;
  }

  /* ESEMPIO: Button variations - personalizza come preferisci */
  .btn {
    @apply px-4 py-2 rounded-md font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2;
  }

  .btn-primary {
    @apply btn bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500;
  }

  .btn-secondary {
    @apply btn bg-gray-600 text-white hover:bg-gray-700 focus:ring-gray-500;
  }

  /* ESEMPIO: Django messages styling - adatta al tuo brand */
  .django-messages {
    @apply px-4 py-3 rounded-md mb-4 border;
  }

  .django-messages.success {
    @apply bg-green-50 border-green-200 text-green-800;
  }

  .django-messages.error {
    @apply bg-red-50 border-red-200 text-red-800;
  }

  .django-messages.warning {
    @apply bg-yellow-50 border-yellow-200 text-yellow-800;
  }

  .django-messages.info {
    @apply bg-blue-50 border-blue-200 text-blue-800;
  }
}

/*
💡 ALTERNATIVA: Usa solo classi utility nei template
Molti sviluppatori preferiscono evitare @layer components e usare
direttamente le classi Tailwind nei template Django per massima flessibilità
*/
```

### 3. **Template Django con Tailwind v4**

```html
<!-- src/templates/base.html -->
{% load static %}
<!doctype html>
<html lang="it" class="h-full bg-gray-50">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{% block title %}Deploy Django + Tailwind v4{% endblock %}</title>

    <!-- Tailwind v4 CSS compilato -->
    <link href="{% static 'css/tailwind.css' %}" rel="stylesheet" />
  </head>
  <body class="h-full">
    <!-- Navigation -->
    <nav class="bg-white shadow-sm border-b border-gray-200">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex items-center">
            <h1 class="text-xl font-semibold text-gray-900">
              Django + Tailwind v4
            </h1>
          </div>
        </div>
      </div>
    </nav>

    <!-- Django Messages (auto-styled) -->
    {% if messages %}
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-4">
      {% for message in messages %}
      <div class="django-messages {{ message.tags }}">
        <div class="flex">
          <div class="ml-3">
            <p class="text-sm font-medium">{{ message }}</p>
          </div>
        </div>
      </div>
      {% endfor %}
    </div>
    {% endif %}

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      {% block content %}
      <div class="px-4 py-6 sm:px-0">
        <div
          class="border-4 border-dashed border-gray-200 rounded-lg h-96 flex items-center justify-center"
        >
          <div class="text-center">
            <h2 class="text-2xl font-bold text-gray-900 mb-4">
              🚀 Django + Tailwind CSS v4
            </h2>
            <p class="text-gray-600 mb-6">
              Zero configurazione, auto-discovery, performance ottimizzate
            </p>
            <button class="btn-primary">Get Started</button>
          </div>
        </div>
      </div>
      {% endblock %}
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-gray-200 mt-auto">
      <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8">
        <p class="text-center text-sm text-gray-500">
          Template Django con Tailwind CSS v4 - Zero Configuration
        </p>
      </div>
    </footer>
  </body>
</html>
```

### 4. **Forms Django + Tailwind v4 (Due Approcci)**

**Approccio A: Con componenti CSS personalizzati (se li hai definiti)**

```python
# forms.py
from django import forms

class ContactForm(forms.Form):
    name = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={
            'class': 'form-input',  # Usa il componente se l'hai definito
            'placeholder': 'Il tuo nome'
        })
    )
```

**Approccio B: Solo utility classes (più flessibile)**

```python
# forms.py - Approccio utility-first puro
from django import forms

class ContactForm(forms.Form):
    name = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={
            'class': 'block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500',
            'placeholder': 'Il tuo nome'
        })
    )

    email = forms.EmailField(
        widget=forms.EmailInput(attrs={
            'class': 'block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500',
            'placeholder': 'nome@esempio.com'
        })
    )

    message = forms.CharField(
        widget=forms.Textarea(attrs={
            'class': 'block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500',
            'rows': 4,
            'placeholder': 'Il tuo messaggio...'
        })
    )
```

💡 **Scelta dell'approccio:**

- **Componenti CSS**: Utile se hai molti form simili e vuoi consistenza
- **Utility classes**: Più flessibile, ogni elemento può essere diverso
- **Ibrido**: Componenti per elementi base + utility per personalizzazioni specifiche

````

```html
<!-- contact_form.html - Usando componenti CSS (se definiti) -->
<form method="post" class="space-y-6 max-w-lg mx-auto">
    {% csrf_token %}

    <div>
        <label for="{{ form.name.id_for_label }}" class="block text-sm font-medium text-gray-700 mb-2">
            Nome
        </label>
        {{ form.name }}
        {% if form.name.errors %}
            <p class="mt-1 text-sm text-red-600">{{ form.name.errors.0 }}</p>
        {% endif %}
    </div>

    <button type="submit" class="btn-primary w-full">
        Invia Messaggio
    </button>
</form>

<!-- ALTERNATIVA: contact_form.html - Solo utility classes -->
<form method="post" class="space-y-6 max-w-lg mx-auto">
    {% csrf_token %}

    <div>
        <label class="block text-sm font-medium text-gray-700 mb-2">
            Nome
        </label>
        <input type="text" name="name"
               class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
               placeholder="Il tuo nome">
        {% if form.name.errors %}
            <p class="mt-1 text-sm text-red-600">{{ form.name.errors.0 }}</p>
        {% endif %}
    </div>

    <button type="submit"
            class="w-full px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
        Invia Messaggio
    </button>
</form>
````

💡 **Suggerimento**: Scegli l'approccio che preferisci - entrambi sono validi con Tailwind v4!

### 5. **Production Build Tailwind v4**

```makefile
# Aggiungi al Makefile esistente
build-frontend-v4: ## Build Tailwind v4 assets for production
 @echo "🎨 Building Tailwind CSS v4..."
 npm run build:css
 @echo "📦 Collecting Django static files..."
 $(MAKE) collectstatic
 @echo "✅ Frontend build completed!"

deploy-prod-v4: build-frontend-v4 ## Deploy with Tailwind v4 frontend
 $(MAKE) deploy
```

### 6. **Package.json Ottimizzato**

```json
{
  "name": "deploy-django-tailwind-v4",
  "version": "1.0.0",
  "description": "Django template with Tailwind CSS v4",
  "scripts": {
    "build:css": "npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify",
    "watch:css": "npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify --watch",
    "dev": "npm run watch:css",
    "clean": "rm -f src/static/css/tailwind.css"
  },
  "dependencies": {
    "@tailwindcss/cli": "^4.1.4",
    "tailwindcss": "^4.1.4"
  },
  "keywords": ["django", "tailwind", "css", "v4", "frontend"],
  "author": "Your Name",
  "license": "MIT"
}
```

## 🚀 Quick Start Tailwind v4

```bash
# 1. Setup iniziale (una tantum)
# Con npm
npm install tailwindcss @tailwindcss/cli
# Con yarn
yarn add tailwindcss @tailwindcss/cli
# Con pnpm
pnpm add tailwindcss @tailwindcss/cli

# 2. Crea file CSS input
echo '@import "tailwindcss";' > src/static/css/style.css

# 3. Build iniziale
npm run build:css    # Con npm
yarn build:css       # Con yarn
pnpm build:css       # Con pnpm

# 4. Sviluppo (2 terminali)
make run-server      # Terminal 1: Django

npm run watch:css    # Terminal 2: Tailwind v4 auto-rebuild (npm)
yarn watch:css       # oppure con yarn
pnpm watch:css       # oppure con pnpm

# 5. Deploy produzione
make build-frontend-v4 && make deploy
```

**🎯 Vantaggi Finali Tailwind v4:**

- ⚡ **Build time ridotto** del 50% rispetto a v3
- 📦 **Bundle size minore** - solo classi utilizzate
- 🔧 **Zero maintenance** - nessun file di configurazione
- 🚀 **Auto-discovery** - rileva automaticamente le classi Django

---

💡 **Suggerimento**: Tailwind v4 con Django è la combinazione perfetta - semplicità, performance e zero configurazione!

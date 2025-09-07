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

```text
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

Installa Tailwind CSS CLI:

```bash
npm install tailwindcss @tailwindcss/cli
# Con yarn
yarn add tailwindcss @tailwindcss/cli
# Con pnpm
pnpm add tailwindcss @tailwindcss/cli
```

## 2. Crea il file CSS di input

````bash
# Crea il file CSS sorgente
echo '@import "tailwindcss";' > src/static/css/style.css
```bash
## 3. Compila il CSS per la prima volta
```bash
# Con npm
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
# Con yarn
yarn @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
# Con pnpm
pnpm @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
````

## 🎨 File CSS di Input (Opzionale)

Il file `src/static/css/style.css` può contenere solo `@import "tailwindcss";` oppure puoi aggiungere componenti
personalizzati:

```css
/* Solo questa riga è essenziale! Tailwind v4 gestisce tutto automaticamente */
@import 'tailwindcss';
/*
ESEMPI OPZIONALI - Componenti personalizzati per Django
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
SUGGERIMENTO: Puoi anche usare solo classi utility direttamente nei template
senza definire componenti personalizzati - dipende dalle tue preferenze!
*/
```

## ⚙️ Comandi Tailwind CLI Essenziali

## Build per Sviluppo (con watch)

```bash
# Ricompila automaticamente quando cambi i template Django
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch
# Con yarn
yarn @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch
# Con pnpm
pnpm @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch
```

## Build per Produzione (minificato)

```bash
# Build ottimizzato per produzione
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
# Con yarn
yarn @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
# Con pnpm
pnpm @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
```

## 🔗 Inclusione nei Template Django

Includi il CSS compilato nei tuoi template Django:

```html
<!-- src/templates/base.html -->
{% load static %}
<!doctype html>
<html lang="it">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{% block title %}Django + Tailwind v4{% endblock %}</title>
    <!-- Includi il CSS compilato da Tailwind -->
    <link href="{% static 'css/tailwind.css' %}" rel="stylesheet" />
  </head>
  <body>
    <!-- I tuoi template possono usare classi Tailwind -->
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-3xl font-bold text-gray-900">Django + Tailwind v4</h1>
      {% if messages %} {% for message in messages %}
      <div class="django-messages {{ message.tags }}">{{ message }}</div>
      {% endfor %} {% endif %} {% block content %}{% endblock %}
    </div>
  </body>
</html>
```

## 🔄 Workflow Sviluppo

## Durante lo sviluppo (2 terminali)

```bash
# Terminal 1: Django server
make run-server
# Terminal 2: Tailwind watch (ricompila automaticamente)
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --watch
```

## Per produzione

```bash
# 1. Build CSS ottimizzato
npx @tailwindcss/cli -i src/static/css/style.css -o src/static/css/tailwind.css --minify
# 2. Collect static files Django
make collectstatic
# 3. Deploy
make deploy
```

## 📁 Struttura File Essenziale

```text
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

## **🎯 Fatto! Zero configurazione, funziona subito con Django.**

💡 **Tailwind v4 = Semplicità**: Solo CLI, nessun config file, auto-discovery dei template Django!

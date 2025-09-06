# Node.js + Django Integration Guide

Questa guida spiega come integrare **Node.js** e strumenti frontend moderni nel progetto Django, con focus particolare
su **Tailwind CSS v4**.

## 🎯 Overview

Il template Django è **già predisposto** per l'integrazione con l'ecosistema Node.js:

- ✅ **Configurazioni pre-impostate** - `.gitignore`, `.pre-commit-config.yaml`, VS Code settings
- ✅ **Node.js ready** - supporta npm, yarn, pnpm
- ✅ **Pre-commit hooks** - escludono automaticamente `node_modules/` dai controlli
- ✅ **VS Code integration** - `node_modules/` escluso da ricerche e file watcher
- ✅ **Tailwind CSS v4** - guida completa con zero configurazione

### 🛠️ Strumenti Supportati

Il template è configurato per supportare:

- **CSS Frameworks**: Tailwind CSS v4 (guida completa sotto)
- **Build Tools**: Qualsiasi tool Node.js (webpack, vite, rollup, ecc.)
- **Package Managers**: npm, yarn, pnpm
- **Frontend Frameworks**: React, Vue, Alpine.js, ecc. (configurazioni future)
- **Development Tools**: ESLint, Prettier, TypeScript, ecc. (se necessario)

### 📁 Configurazioni Pre-Impostate

Il template include già:

```bash
# .gitignore - Esclude automaticamente
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.npm
.yarn
# .pre-commit-config.yaml - Skip node_modules nei hook
exclude: |
    (?x)^(
        .*node_modules.*|
        .*\.min\.(js|css)$
    )$
# .vscode/settings.json - Esclude da ricerche
"files.exclude": {
    "node_modules": true
},
"files.watcherExclude": {
    "node_modules": true
}
```

## 🎨 Focus: Tailwind CSS v4 + Django

La seguente guida mostra come usare **Tailwind CSS v4** con Django, ma le stesse configurazioni supportano qualsiasi
strumento Node.js. Tailwind CSS v4 semplifica drasticamente l'integrazione con Django:

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

Il file `src/static/css/style.css` può contenere solo `@import "tailwindcss";` oppure puoi aggiungere componenti
personalizzati:

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

## 🚀 Espansioni Future

Il template è già configurato per aggiungere facilmente:

### Frontend Frameworks

```bash
# React
npm install react react-dom
# Vue.js
npm install vue
# Alpine.js
npm install alpinejs
```

### Build Tools Avanzati

```bash
# Webpack per bundling complesso
npm install --save-dev webpack webpack-cli
# Vite per development veloce
npm install --save-dev vite
# TypeScript per type safety
npm install --save-dev typescript
```

### Development Tools

```bash
# ESLint per code quality
npm install --save-dev eslint
# Prettier per formatting
npm install --save-dev prettier
```

## **💡 Configurazioni**: Tutte le configurazioni (gitignore, pre-commit, VS Code) sono già predisposte per supportare questi strumenti

🎯 **Tailwind v4 = Semplicità**: Solo CLI, nessun config file, auto-discovery dei template Django! ⚙️ **Template =
Flessibilità**: Pronto per qualsiasi strumento Node.js futuro!

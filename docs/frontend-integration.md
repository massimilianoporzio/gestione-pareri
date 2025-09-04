# Frontend Integration (Node.js Ready)

[![Node.js Ready](https://img.shields.io/badge/Node.js-Ready-green?logo=node.js&logoColor=white)](docs/nodejs-integration.md)

Questo template è già predisposto per l'integrazione con Node.js e strumenti frontend moderni.

## 🎯 Overview

Il template **deploy-django** supporta l'integrazione completa con ecosistemi frontend moderni:

- ✅ **Webpack** per bundling e ottimizzazione
- ✅ **Tailwind CSS** per styling utility-first
- ✅ **Babel** per transpiling JavaScript moderno
- ✅ **PostCSS** per processing avanzato CSS
- ✅ **Django + Node.js** workflow integrato

## 📦 Configurazione Pre-integrata

### Git Integration

- ✅ **`.gitignore`**: Esclude `node_modules/`, build outputs, e file temporanei
- ✅ **Pre-commit**: Configurato per ignorare directory Node.js durante i controlli di qualità
- ✅ **Struttura directory**: Pronto per `package.json` nella root del progetto

### Django Integration

- ✅ **Static files handling** ottimizzato per build frontend
- ✅ **WhiteNoise** configurato per servire asset compilati
- ✅ **Multi-environment** support per dev/staging/prod

## 🚀 Setup Node.js (quando necessario)

### 1. Inizializzazione Progetto

```bash
# Inizializza package.json
npm init -y

# Installa dipendenze base
npm install --save-dev webpack webpack-cli webpack-dev-server
npm install --save-dev @babel/core @babel/preset-env babel-loader
npm install --save-dev css-loader mini-css-extract-plugin
```

### 2. Tailwind CSS Setup

```bash
# Installa Tailwind
npm install --save-dev tailwindcss @tailwindcss/cli autoprefixer postcss

# Inizializza configurazione
npx tailwindcss init -p
```

**File: `tailwind.config.js`**

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.html", "./src/**/*.js", "./src/**/*.py"],
  theme: {
    extend: {},
  },
  plugins: [],
};
```

### 3. Webpack Configuration

**File: `webpack.config.js`**

```javascript
const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  entry: "./src/static/js/main.js",
  output: {
    path: path.resolve(__dirname, "src/static/dist"),
    filename: "bundle.js",
    clean: true,
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: "styles.css",
    }),
  ],
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"],
          },
        },
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "postcss-loader"],
      },
    ],
  },
  mode: process.env.NODE_ENV === "production" ? "production" : "development",
};
```

### 4. Package.json Scripts

```json
{
  "scripts": {
    "build": "webpack --mode production",
    "dev": "webpack --mode development --watch",
    "css": "tailwindcss -i src/static/css/input.css -o src/static/css/style.css",
    "css:watch": "tailwindcss -i src/static/css/input.css -o src/static/css/style.css --watch"
  }
}
```

## 📁 Struttura Directory Consigliata

```
deploy-django/
├── src/                     # Django source code
│   ├── static/
│   │   ├── css/
│   │   │   ├── input.css   # Tailwind source
│   │   │   └── style.css   # Tailwind compiled
│   │   ├── js/
│   │   │   ├── main.js     # Entry point
│   │   │   └── components/ # JS modules
│   │   └── dist/           # Webpack outputs
│   │       ├── bundle.js
│   │       └── styles.css
├── node_modules/           # Node.js deps (ignored)
├── package.json            # Node.js config
├── webpack.config.js       # Build config
├── tailwind.config.js      # Tailwind config
├── postcss.config.js       # PostCSS config
└── staticfiles/            # Django collected statics
```

## 🔄 Workflow di Sviluppo

### Development Mode

```bash
# Terminal 1: Django server
just run-dev

# Terminal 2: Frontend watch mode
npm run dev
# or for Tailwind
npm run css:watch
```

### Production Build

```bash
# Build frontend assets
npm run build

# Django collectstatic
just collectstatic-prod

# Deploy
just deploy-prod
```

## ⚙️ Integrazione con Django

### Template Integration

**File: `src/templates/base.html`**

```html
{% load static %}
<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>{% block title %}Deploy Django{% endblock %}</title>

    <!-- Tailwind CSS -->
    <link href="{% static 'css/style.css' %}" rel="stylesheet" />

    <!-- Webpack Bundle CSS -->
    <link href="{% static 'dist/styles.css' %}" rel="stylesheet" />
  </head>
  <body class="bg-gray-100">
    {% block content %}{% endblock %}

    <!-- Webpack Bundle JS -->
    <script src="{% static 'dist/bundle.js' %}"></script>
  </body>
</html>
```

### Static Files Settings

**File: `src/home/settings/base.py`**

```python
# Static files configuration
STATIC_URL = '/static/'
STATIC_ROOT = REPO_DIR / 'staticfiles'

STATICFILES_DIRS = [
    BASE_DIR / 'static',
]

# WhiteNoise configuration for frontend assets
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Compression settings
WHITENOISE_USE_FINDERS = True
WHITENOISE_AUTOREFRESH = True  # Only in development
```

## 🎯 Task Runner Integration

### Just Commands

Aggiungi al `justfile`:

```bash
# === FRONTEND COMMANDS ===

# 📦 Install Node.js dependencies
install-node:
    @Write-Host "📦 Installazione dipendenze Node.js..." -ForegroundColor Cyan
    npm install

# 🔨 Build frontend assets
build-frontend:
    @Write-Host "🔨 Build frontend assets..." -ForegroundColor Cyan
    npm run build

# 👀 Watch frontend changes
watch-frontend:
    @Write-Host "👀 Watch mode frontend..." -ForegroundColor Cyan
    npm run dev

# 🎨 Build Tailwind CSS
build-css:
    @Write-Host "🎨 Build Tailwind CSS..." -ForegroundColor Cyan
    npm run css

# 👀 Watch Tailwind CSS
watch-css:
    @Write-Host "👀 Watch Tailwind CSS..." -ForegroundColor Cyan
    npm run css:watch

# 🚀 Full build (frontend + Django)
build-all: install-node build-frontend collectstatic-prod
    @Write-Host "🚀 Build completo completato!" -ForegroundColor Green
```

### Make Commands

Equivalenti per `Makefile`:

```makefile
# Frontend commands
install-node:
 npm install

build-frontend:
 npm run build

watch-frontend:
 npm run dev

build-css:
 npm run css

watch-css:
 npm run css:watch

build-all: install-node build-frontend collectstatic-prod
 @echo "Build completo completato!"
```

## 🔧 Advanced Configurations

### PostCSS Configuration

**File: `postcss.config.js`**

```javascript
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
    ...(process.env.NODE_ENV === "production" ? { cssnano: {} } : {}),
  },
};
```

### Babel Configuration

**File: `.babelrc`**

```json
{
  "presets": [
    [
      "@babel/preset-env",
      {
        "targets": {
          "browsers": ["last 2 versions", "ie >= 11"]
        }
      }
    ]
  ]
}
```

### ESLint + Prettier

```bash
# Install dev dependencies
npm install --save-dev eslint prettier eslint-config-prettier

# .eslintrc.js
module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: ['eslint:recommended', 'prettier'],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
  },
  rules: {},
};
```

## 🚀 Examples

### React Integration

```bash
# Install React
npm install react react-dom
npm install --save-dev @babel/preset-react

# Update webpack.config.js
module.exports = {
  // ... existing config
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env', '@babel/preset-react']
          }
        }
      },
      // ... existing rules
    ],
  },
};
```

### Vue.js Integration

```bash
# Install Vue
npm install vue
npm install --save-dev vue-loader vue-template-compiler

# Update webpack configuration accordingly
```

## 📚 Risorse Aggiuntive

- [Webpack Documentation](https://webpack.js.org/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Django Static Files](https://docs.djangoproject.com/en/stable/howto/static-files/)
- [WhiteNoise Documentation](http://whitenoise.evans.io/en/stable/)

## 🔗 File Correlati

- [`docs/nodejs-integration.md`](nodejs-integration.md) - Documentazione Node.js completa
- [`docs/tailwind-integration.md`](tailwind-integration.md) - Setup Tailwind specifico
- [`justfile`](../justfile) - Task runner commands
- [`src/static/README.md`](../src/static/README.md) - Static files management

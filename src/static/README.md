# Static Files Directory

This directory contains the source static files for your Django project.

## Structure

- `css/` - Stylesheets
- `js/` - JavaScript files
- `images/` - Images and icons
- `fonts/` - Web fonts (if any)

## Development

During development with `DEBUG=True`, Django serves these files directly from this directory.

## Production

In production, these files are:

1. **Collected** by `python manage.py collectstatic` into `staticfiles/`
2. **Processed** by WhiteNoise (compressed, cache headers, etc.)
3. **Served** by WhiteNoise from the `staticfiles/` directory

## Best Practices

✅ **DO commit** files in this directory
❌ **DON'T commit** the `staticfiles/` directory (it's auto-generated)

## Adding New Static Files

1. Add your files to appropriate subdirectories here
2. Reference them in templates using `{% load static %}` and `{% static 'path/to/file' %}`
3. Run `python manage.py collectstatic` for production deployment

## WhiteNoise Integration

WhiteNoise automatically:

- Compresses CSS/JS files
- Adds cache headers
- Serves files with optimal performance
- Handles file versioning for cache busting

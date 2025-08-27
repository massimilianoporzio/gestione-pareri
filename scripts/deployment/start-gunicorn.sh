#!/bin/bash
# Gunicorn deployment script for Unix/Linux/macOS

set -e

# Configuration
DJANGO_ENV=${DJANGO_ENV:-prod}
HOST=${HOST:-0.0.0.0}
PORT=${PORT:-8000}
WORKERS=${WORKERS:-4}
WORKER_CLASS=${WORKER_CLASS:-sync}
TIMEOUT=${TIMEOUT:-30}
KEEP_ALIVE=${KEEP_ALIVE:-2}
MAX_REQUESTS=${MAX_REQUESTS:-1000}
MAX_REQUESTS_JITTER=${MAX_REQUESTS_JITTER:-100}

# Change to project directory
cd "$(dirname "$0")/../.."

# Activate virtual environment if exists
if [ -d ".venv" ]; then
    source .venv/bin/activate
fi

echo "🚀 Starting Django with Gunicorn"
echo "Environment: $DJANGO_ENV"
echo "Host: $HOST"
echo "Port: $PORT"
echo "Workers: $WORKERS"

# Export Django environment
export DJANGO_ENV=$DJANGO_ENV

# Run database migrations
echo "📊 Running migrations..."
python src/manage.py migrate --no-input

# Collect static files
echo "📁 Collecting static files..."
# Note: staticfiles/ directory is auto-generated and should not be committed to Git
# It's recreated on each deployment and contains processed/compressed static files
python src/manage.py collectstatic --no-input --clear

# Start Gunicorn
echo "🌟 Starting Gunicorn server..."
exec gunicorn \
    --chdir src \
    --bind $HOST:$PORT \
    --workers $WORKERS \
    --worker-class $WORKER_CLASS \
    --timeout $TIMEOUT \
    --keep-alive $KEEP_ALIVE \
    --max-requests $MAX_REQUESTS \
    --max-requests-jitter $MAX_REQUESTS_JITTER \
    --access-logfile - \
    --error-logfile - \
    --log-level info \
    --preload \
    home.wsgi:application

"""Views for the home app."""

from django.conf import settings
from django.http import HttpResponse
from django.shortcuts import render


def hello_world(request):
    """Render the hello world template."""
    return render(request, "hello-world.html", {"project_name": settings.PROJECT_NAME})


def healthz_view(request):
    """Health check view that returns OK status.

    Args:
        request: HTTP request object.

    Returns:
        HttpResponse with "OK" status.
    """
    return HttpResponse("OK")

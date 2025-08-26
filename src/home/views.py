"""Views for the home app."""

from django.http import HttpResponse
from django.shortcuts import render


def hello_world(request):
    """Render the hello world template."""
    return render(request, "hello-world.html", {})


def healthz_view(request):
    """Health check view that returns OK status.

    Args:
        request: HTTP request object.

    Returns:
        HttpResponse with "OK" status.
    """
    return HttpResponse("OK")

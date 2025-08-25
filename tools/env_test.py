import os

print("Environment variables:")
for key, value in sorted(os.environ.items()):
    if key.startswith("DJANGO_"):
        print(f"  {key} = {value}")

print(f"\nDJANGO_LOGS_DIR: {os.environ.get('DJANGO_LOGS_DIR', 'not set')}")

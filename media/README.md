# Media Files

This directory contains user-uploaded files.

## Structure

- `uploads/` - User uploaded files
- `images/` - Image files
- `documents/` - Document files

## Development

During development, Django serves these files automatically when `DEBUG=True`.

## Production

In production, these files should be served by:

1. A CDN (recommended)
2. A web server like Nginx
3. WhiteNoise (for simple deployments)

## Security

- Never commit user-uploaded files to Git
- Validate all uploaded files
- Use appropriate permissions
- Consider file size limits

#!/usr/bin/env sh
set -e

# Render template with environment variables
envsubst '\$ENVIRONMENT \$SECRET_MESSAGE' \
  < /usr/share/nginx/html/index.html.tmpl \
  > /usr/share/nginx/html/index.html

exec nginx -g 'daemon off;'

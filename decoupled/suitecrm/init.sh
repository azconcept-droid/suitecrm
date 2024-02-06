#!/usr/bin/env sh

# Goto /Api/V8/OAuth2 and run

cd /srv/app/Api/V8/OAuth2

openssl genrsa -out private.key 2048

openssl rsa -in private.key -pubout -out public.key

chmod 600 private.key public.key

chown www-data:www-data p*.key

set -e

php-fpm -D
nginx -g 'daemon off;'

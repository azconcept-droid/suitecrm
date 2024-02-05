#!/usr/bin/env sh

# running nginx, php-fpm
set -e

php-fpm -D
nginx -g 'daemon off;'

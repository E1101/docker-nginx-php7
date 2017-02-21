#!/usr/bin/env bash

if [[ -d "/var/www/public" && !(-L "/var/www/html" || -d "/var/www/html") ]]; then
  ln -s /var/www/public /var/www/html
fi

/etc/init.d/php7.0-fpm restart
exec /usr/sbin/nginx -g "daemon off;"

#!/bin/bash
for dn in `cat /docker/web-writeable.txt`; do
  [ -d /var/www/html/$dn ] || mkdir /var/www/html/$dn
  chown -R www-data /var/www/html/$dn
done

if [[ $SSL == 'FALSE' ]]; then a2dismod ssl; fi
if [[ $ENVIRONMENT == 'DEV' ]]; then
  cp /docker/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
fi

apache2-foreground

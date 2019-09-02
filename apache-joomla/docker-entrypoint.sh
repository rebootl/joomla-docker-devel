#!/bin/bash
#
#

STARTED_LOCK_FILE="/started.lock"
if [ ! -e $STARTED_LOCK_FILE ]; then
  echo "-- First container startup --"

  # set permissions
  chown -R www-data /var/www/html
  chmod -R g+w /var/www/html
  find /var/www/html -type d -exec chmod g+s {} \;

  # create directories for virtuemart
  mkdir -p /var/webdocs/joomla/virtuemart/invoices
  mkdir -p /var/webdocs/joomla/virtuemart/keys
  chown www-data /var/webdocs/joomla/virtuemart/invoices \
    /var/webdocs/joomla/virtuemart/keys

  # edit configuration.php
  sed -i "/\$host = /s/'[^']*'/'mymariadb-test'/" /var/www/html/configuration.php
  sed -i "/\$user = /s/'[^']*'/'joomla'/" /var/www/html/configuration.php
  sed -i "/\$password = /s/'[^']*'/'xyz123'/" /var/www/html/configuration.php
  sed -i "/\$db = /s/'[^']*'/'joomla'/" /var/www/html/configuration.php
  sed -i \
       "s!\$log_path = '[^']*'!\$log_path = '/var/www/html/logs'!" \
        /var/www/html/configuration.php
  sed -i \
        "s!\$tmp_path = '[^']*'!\$tmp_path = '/var/www/html/tmp'!" \
        /var/www/html/configuration.php

  touch $STARTED_LOCK_FILE
else
  echo "-- Not first container startup --"
fi

exec "$@"

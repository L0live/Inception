#!/bin/bash

cd /var/www/html

# Attente que la DB réponde
until wp db check --allow-root; do
  echo "En attente de MariaDB..."
  sleep 3
done

# Installation WordPress (si pas encore installé)
if ! wp core is-installed --allow-root; then
  wp core install \
    --url=${WP_URL} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

  wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASSWORD} \
    --role=author \
    --allow-root
fi

exec php-fpm7.4 -F
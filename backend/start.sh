#!/bin/bash
set -e

# ensure permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache || true
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache || true

# optional: run migrations or storage link in container startup (uncomment if wanted)
# php /var/www/html/artisan migrate --force
# php /var/www/html/artisan storage:link --force

# start supervisord in foreground (so Docker logs capture it)
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

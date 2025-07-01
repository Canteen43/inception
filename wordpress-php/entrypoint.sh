#!/bin/sh

# Wait until MariaDB is ready
echo "Entrypoint script: Waiting for MariaDB to be ready..."
until mariadb-admin ping -h mariadb -P 3306 -u wpuser -p42; do
    echo "Entrypoint script: MariaDB is not ready yet. Waiting 0.1 seconds..."
    sleep 0.1
done
echo "Entrypoint script: MariaDB is ready."

# TODO: Could not be opened
# Run the WordPress installation script
echo "Entrypoint script: Running WordPress installation script..."
php /var/www/wordpress/wordpressinstall_localhost.php

# replaces the shell process with CMD
echo "Entrypoint script: Replacing shell process with CMD: $@"
exec "$@"
#!/bin/sh

# Copying to the wordpress volume if it is not initialized
if [ ! -f /var/www/wordpress/.initialized ]; then
	echo "Entrypoint script: Initializing volume..."
	cp -r /var/www/wordpress_src/* /var/www/wordpress/
	touch /var/www/wordpress/.initialized
else
	echo "Entrypoint script: Volume already initialized..."
fi

# Deleting wordpress_src
echo "Entrypoint script: Deleting wordpress_src directory..."
rm -rf /var/www/wordpress_src

# Waiting until MariaDB is ready
echo "Entrypoint script: Waiting for MariaDB to be ready..."
until mariadb-admin ping -h mariadb -P 3306 -u wpuser -p42; do
    echo "Entrypoint script: MariaDB is not ready yet. Waiting 0.1 seconds..."
    sleep 0.1
done
echo "Entrypoint script: MariaDB is ready."

# Checking if wordpress needs installation
echo "Entrypoint script: Checking if wordpress needs installation..."
if mariadb -h mariadb -u wpuser -p42 -e "USE wordpress; SELECT * FROM wp_options;"  >/dev/null 2>&1; then
    echo "Entrypoint script: WordPress already installed, skipping installation."
else
    echo "Entrypoint script: WordPress not installed, running installer..."
    php /var/www/wordpress/wordpressinstall_localhost.php
fi

# replaces the shell process with CMD
echo "Entrypoint script: Replacing shell process with CMD: $@"
exec "$@"
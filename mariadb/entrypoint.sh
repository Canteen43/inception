#!/bin/sh

# Initializing the database (this puts system tables into mariadb)
mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr

# Starting mariadb daemon in the background
echo "Entrypoint script: Starting mariadbd in the background..."
mariadbd --user=mysql &

# Wait until MariaDB is ready
echo "Entrypoint script: Waiting for MariaDB to be ready..."
until mariadb-admin ping; do
    echo "Entrypoint script: MariaDB is not ready yet. Waiting 0.1 seconds..."
    sleep 0.1
done
echo "Entrypoint script: MariaDB is ready."

# create the database and user for WordPress
echo "Entrypoint script: Creating WordPress database and user..."
mariadb -e "
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'%' IDENTIFIED BY '42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
"

# stop mariadbd so it can be restarted in the foreground
echo "Entrypoint script: Stopping MariaDB daemon..."
pkill mariadbd

# replaces the shell process with CMD
echo "Entrypoint script: Replacing shell process with CMD: $@"
exec "$@"
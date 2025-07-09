#!/bin/sh

# Checking if initialization is needed. (Initialization puts system tables into mariadb)
echo "Entrypoint script: Checking if MariaDB needs to be initialized..."
if [ ! -d /var/lib/mysql/mysql ]; then
	echo "Entrypoint script: /var/lib/mysql/mysql does not exist. Initializing MariaDB..."
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
	echo "Entrypoint script: Initialization complete."
else
	echo "Entrypoint script: /var/lib/mysql/mysql already exists. Skipping initialization."
fi

# Checking if wordpress table and user are installed 
echo "Entrypoint script: Checking if wordpress table and user are already added..."
if [ ! -d /var/lib/mysql/wordpress ]; then
	echo "Entrypoint script: /var/lib/mysql/wordpress does not exist."
	
	# Starting mariadb daemon in the background. (MariaDB needs to be running to create the database and user)
	echo "Entrypoint script: Starting mariadbd in the background..."
	mariadbd --user=mysql &

	# Waiting until MariaDB is ready
	echo "Entrypoint script: Waiting for MariaDB to be ready..."
	until mariadb-admin ping; do
		echo "Entrypoint script: MariaDB is not ready yet. Waiting 0.1 seconds..."
		sleep 0.1
	done
	echo "Entrypoint script: MariaDB is ready."

	# Creating the database and user for WordPress
	echo "Entrypoint script: Creating WordPress database and user..."
	mariadb -e "
	CREATE DATABASE wordpress;
	CREATE USER '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_PASS}';
	GRANT ALL PRIVILEGES ON wordpress.* TO '${WP_DB_USER}'@'%';
	"
	# Stopping mariadb background daemon
	echo "Entrypoint script: Stopping MariaDB daemon..."
	pkill mariadbd

	echo "Entrypoint script: WordPress database and user created."
else
	echo "Entrypoint script: /var/lib/mysql/wordpress already exists. Skipping database and user creation."
fi


# replaces the shell process with CMD
echo "Entrypoint script: Replacing shell process with CMD: $@"
exec "$@"
#!/bin/sh

# Generating SSL key and cert if they do not exist
echo "Entrypoint script: Checking if SSL key and cert have already been generated..."
if [ ! -d /var/www/wordpress/ssl/ ]; then
	echo "Entrypoint script: Generating SSL key and cert..."
	mkdir /var/www/wordpress/ssl
	openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 \
		-keyout /var/www/wordpress/ssl/selfsigned.key \
		-out /var/www/wordpress/selfsigned.crt \
		-subj "/C=FR/ST=Paris/L=Paris/O=42/CN=localhost"
else
	echo "Entrypoint script: Key and cert already exist..."
fi

# replaces the shell process with CMD
echo "Entrypoint script: Replacing shell process with CMD: $@"
exec "$@"
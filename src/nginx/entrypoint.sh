#!/bin/sh

# TODO: Check connection acceptance of wordpress-php container
# Copying to the wordpress volume if it is not initialized
# echo "Entrypoint script: Waiting for Wordpress to be ready..."
# if [ ! -f /var/www/wordpress/.installed ]; then
#     echo "Entrypoint script: Wordpress is not ready yet. Waiting 0.1 seconds..."
#     sleep 0.1
# fi
# echo "Entrypoint script: Wordpress is ready."
sleep 5

# replaces the shell process with CMD
echo "Entrypoint script: Replacing shell process with CMD: $@"
exec "$@"
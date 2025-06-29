#!/bin/sh

# mariadbd --user=mysql --skip-networking=0 --bind-address=0.0.0.0 --port=3306 &
mariadbd --user=mysql &

# wait for the database to start
# TODO: find better alternative to sleep (maybe ping, maybe error on delay?)
sleep 3

# create the database and user for WordPress
mariadb < /root/setup_wordpress_on_mariadb.sql

# wait for command to run
sleep 1

# stop mariadbd so it can be restarted in the foreground
pkill mariadbd

# replaces the shell process with CMD
exec "$@"
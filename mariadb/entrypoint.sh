#!/bin/sh
mariadbd --user=mysql --skip-networking=0 --bind-address=0.0.0.0 --port=3306 &
sleep 1
# TODO: find better alternative to sleep
mariadb < /root/setup_wordpress_on_mariadb.sql
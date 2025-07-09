FROM alpine:3.21.3

# Installing Tini and PHP-FPM
RUN apk add --no-cache \
	tini \
	php php83-fpm php-mysqli \
	curl \
	mariadb-client

# Adding entrypoint script
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

# TODO: Try if it works without this part
# Adding a config file so that php-fpm listens on all interfaces instead of just localhost
RUN echo "listen = 0.0.0.0:9000" > /etc/php83/php-fpm.d/z-custom.conf

# Adding wordpress user
RUN adduser -D -G www-data www-data

# Adding wordpress
USER www-data
WORKDIR /var/www
RUN	curl -O https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress wordpress_src
WORKDIR /
USER root

# Adding wp-config.php
WORKDIR /var/www/wordpress_src
COPY wp-config.php .
RUN chown www-data:www-data wp-config.php
WORKDIR /

# Adding a script to install WordPress
WORKDIR /var/www/wordpress_src
COPY wordpressinstall.php .
RUN chown www-data:www-data wordpressinstall.php && \
	chmod +x wordpressinstall.php
WORKDIR /

# Setting entrypoint and command
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm83", "--nodaemonize"]
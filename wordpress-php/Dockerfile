FROM alpine:3.21.3

# Installing Tini and PHP-FPM
RUN apk add --no-cache \
	tini \
	php php83-fpm php-mysqli \
	curl

# Adding entrypoint script
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

# Adding a config file so that php-fpm listens on all interfaces instead of just localhost
RUN echo "listen = 0.0.0.0:9000" > /etc/php83/php-fpm.d/z-custom.conf

# Adding wordpress
RUN mkdir /var/www && \
	cd /var/www && \
	curl -O https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	rm latest.tar.gz && \
	cd /

# Adding wp-config.php
COPY wp-config.php /var/www/wordpress/

# Adding a script to install WordPress
COPY wordpressinstall_localhost.php /var/www/wordpress/
RUN chmod +x /var/www/wordpress/wordpressinstall_localhost.php

# Adding www-data user and group and setting permissions
RUN adduser -D -G www-data www-data && \
	chown -R www-data:www-data /var/www/wordpress

# Setting entrypoint and command
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["sh"]
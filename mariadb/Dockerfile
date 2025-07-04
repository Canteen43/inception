FROM alpine:3.21.3

# Installing dependencies without cache to reduce image size
RUN apk add --no-cache \
	# Tini handles zombie processes and signals
	tini \
	# MariaDB is the database server
	mariadb \
	# MariaDB client is needed to create databases and users
	mariadb-client

# Creating directory with correct permissions so mariadb can create essential runtime files
RUN mkdir /run/mysqld && \
	chown mysql:mysql /run/mysqld


RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
COPY setup_wordpress_on_mariadb.sql /root
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 3306
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["mariadbd", "--user=mysql", "--skip-networking=0", "--bind-address=0.0.0.0", "--port=3306", "--console"]
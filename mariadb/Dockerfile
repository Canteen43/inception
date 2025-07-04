FROM alpine:3.21.3

# Installing dependencies without cache to reduce image size
RUN apk add --no-cache \
	# Tini handles zombie processes and signals
	tini \
	# MariaDB is the database server that will run continuously
	mariadb \
	# MariaDB client is needed in the beginning to create databases and users for wordpress
	mariadb-client

# Creating directory with correct permissions so mariadb can create essential runtime files
RUN mkdir /run/mysqld && \
	chown mysql:mysql /run/mysqld

# Adding entrypoint script with correct permissions
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

# Setting entrypoint and command
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["mariadbd", "--user=mysql", "--skip-networking=0", "--bind-address=0.0.0.0", "--port=3306", "--console"]
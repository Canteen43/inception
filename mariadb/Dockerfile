FROM alpine:3.21.3

RUN apk add --no-cache tini mariadb mariadb-client
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
RUN mkdir /run/mysqld
RUN chown mysql:mysql /run/mysqld
COPY setup_wordpress_on_mariadb.sql /root
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["mariadbd", "--user=mysql", "--skip-networking=0", "--bind-address=0.0.0.0", "--port=3306"]
# , "--console"
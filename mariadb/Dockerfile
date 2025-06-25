FROM alpine:3.21.3

RUN apk add --no-cache tini mariadb
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
ENTRYPOINT ["/sbin/tini", "--"]
# CMD ["mariadbd", "--user=mysql", "--skip-networking=0", "--bind-address=0.0.0.0", "--port=3306", "--socket=0", "--console"]
CMD ["sh"]

FROM alpine:3.21.3

RUN apk add --no-cache tini mariadb
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
ENTRYPOINT ["/sbin/tini", "--"]
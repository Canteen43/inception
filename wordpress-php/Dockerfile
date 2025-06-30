FROM alpine:3.21.3

RUN apk add --no-cache tini php83-fpm
COPY entrypoint.sh /usr/local/bin
COPY testscript.php /home
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["sh"]
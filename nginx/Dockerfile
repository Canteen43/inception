FROM alpine:3.21.3

RUN apk add --no-cache tini nginx

# Adding entrypoint script
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY custom.conf /etc/nginx/http.d/custom.conf
COPY index.html /var/www/localhost/htdocs/index.html

EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
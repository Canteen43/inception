FROM alpine:3.21.3

RUN apk add --no-cache tini nginx


ENTRYPOINT ["/sbin/tini", "--"]

COPY custom.conf /etc/nginx/http.d/custom.conf
COPY index.html /var/www/localhost/htdocs/index.html

EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
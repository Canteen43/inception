FROM alpine:3.21.3

# Installing dependencies without cache to reduce image size
RUN apk add --no-cache \
	# Tini handles zombie processes and signals
	tini \
	# Nginx is the web server that will run as the command
	nginx \
	# OpenSSL is used for generating self-signed certificates
	openssl

# Adding entrypoint script
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY wordpress_http.conf /etc/nginx/http.d/wordpress_http.conf
# COPY index.html /var/www/localhost/htdocs/index.html

EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off; error_log /dev/stderr info;"]
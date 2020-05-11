#!/bin/sh

if [ ! -e /etc/apache2/certs/server.key ] && [ ! -e /etc/apache2/certs/server.crt ]; then
	openssl req -newkey rsa:4096 -new -nodes -x509 -days 3650 -keyout /etc/apache2/certs/server.key -out /etc/apache2/certs/server.crt -subj "/CN=${SERVER_NAME}"
fi

chown apache:apache /var/www/localhost/htdocs/data /php_sessions

rm -f /run/apache2/httpd.pid 2>/dev/null
exec httpd -DFOREGROUND

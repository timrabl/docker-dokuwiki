#!/bin/sh

if [ ! -e /etc/apache2/certs/server.key ] && [ ! -e /etc/apache2/certs/server.crt ]; then
	openssl req \
        -newkey rsa:4096 \
        -new \
        -nodes \
        -x509 \
        -days ${SSL_EXPIRE} \
        -keyout /etc/apache2/certs/server.key \
        -out /etc/apache2/certs/server.crt \
        -subj "/C=${SSL_C}/ST=${SSL_ST}/L=${SSL_L}/O=${SSL_O}/OU=${SSL_OU}/CN=${SSL_CN}"
fi

#chown apache:apache /var/www/localhost/htdocs/data /etc/apache2/php_sessions

rm -f /run/apache2/httpd.pid 2>/dev/null
exec httpd -DFOREGROUND

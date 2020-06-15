FROM alpine:3.11
LABEL maintainer="Tim Rabl https://github.com/timrabl/"

COPY dokuwiki/ /var/www/localhost/htdocs
COPY apache/httpd.conf /etc/apache2/httpd.conf
COPY apache/.htaccess /var/www/localhost/htdocs/
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

 RUN apk --update --no-cache add apache2 apache2-ssl php7 php7-apache2 php7-fpm php7-ldap php7-json php7-session php7-xml &&\
     mkdir /etc/apache2/php_sessions /etc/apache2/certs &&\
     echo 'sessions.save_path = "/etc/apache2/php_sessions"' >> /etc/php7/conf.d/00_custom.ini &&\
     echo 'sessions.use_only_cookies = 1' >> /etc/php7/conf.d/00_custom.ini &&\
     rm /etc/apache2/conf.d/ssl.conf /var/www/localhost/htdocs/index.html &&\
     cd /var/www/localhost/htdocs &&\
#     chmod -R 755 . /var/log/apache2 && \
     chown apache:apache . &&\
     chmod -R 775 data/ conf/ &&\
     chown apache:nogroup data/ conf/ &&\
     chmod 2775 data/attic data/cache data/index data/locks data/media data/meta data/pages data/tmp data/media_attic data/media_meta &&\
     chown apache:nogroup data/attic data/cache data/index data/locks data/media data/meta data/pages data/tmp data/media_attic data/media_meta


ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

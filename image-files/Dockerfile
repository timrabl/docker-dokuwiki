FROM alpine:3.12
LABEL maintainer="Tim Rabl https://github.com/timrabl/"

# Build arguments
ARG VERSION
ARG INSTALLER
ARG LDAP

# docker entrypoint script for running things on startup
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Apache config stuff
COPY apache/httpd.conf /etc/apache2/httpd.conf
COPY apache/.htaccess /var/www/localhost/htdocs/

# Dokuwiki source stuff
COPY dokuwiki-${VERSION}/ /var/www/localhost/htdocs

RUN apk --update --no-cache add apache2 \
        apache2-ssl \
        php7 \
        php7-apache2 \
        php7-fpm \
        php7-json \
        php7-session \
        php7-xml &&\
    if [ "${LDAP}" == "true" ]; then apk add php7-ldap; echo -e '\
$conf["plugin"]["authldap"]["server"] = getenv("LDAP_SERVER");\n\
$conf["plugin"]["authldap"]["usertree"] = getenv("LDAP_USER_TREE");\n\
$conf["plugin"]["authldap"]["grouptree"] = getenv("LDAP_GROUP_TREE");\n\
$conf["plugin"]["authldap"]["userfilter"] = getenv("LDAP_USER_FILTER");\n\
$conf["plugin"]["authldap"]["groupfilter"] = getenv("LDAP_GROUP_FILTER");\n\
$conf["plugin"]["authldap"]["grps"] = getenv("LDAP_GRPS");\n\
$conf["plugin"]["authldap"]["binddn"] = getenv("LDAP_BIND_DN");\n\
$conf["plugin"]["authldap"]["bindpw"] = getenv("LDAP_BIN_PW");\n\
$conf["plugin"]["authldap"]["starttls"] = getenv("LDAP_STARTTLS");\n\
$conf["plugin"]["authldap"]["version"] = getenv("LDAP_VERSION");\
    '>> /var/www/localhost/htdocs/conf/dokuwiki.php; fi &&\
    cd /etc/apache2 &&\
    mkdir php_sessions certs &&\
    rm -f conf.d/ssl.conf &&\
    echo -e '\
sessions.save_path = "/etc/apache2/php_sessions"\n\
sessions.use_only_cookies = 1 '>> /etc/php7/conf.d/00_custom.ini &&\
    cd /var/www/localhost/htdocs &&\
    if [ "${INSTALLER}" != "true" ]; then rm -f install.php; fi &&\
    rm -f index.html &&\
    chown apache:apache . &&\
    chmod 775 data/ conf/ &&\
    chown apache:nogroup data/ conf/ &&\
    chmod 2755 data/attic \
         data/cache \
         data/index \
         data/locks \
         data/media \
         data/meta \
         data/pages \
         data/tmp \
         data/media_attic \
         data/media_meta &&\
    chown apache:nogroup \
        data/attic \
        data/cache \
        data/index \
        data/locks \
        data/media \
        data/meta \
        data/pages \
        data/tmp \
        data/media_attic \
        data/media_meta

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

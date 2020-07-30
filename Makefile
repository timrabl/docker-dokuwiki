_STABLE_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
_STABLE_NAME=dokuwiki-latest

_IMAGE_PATH=image-files/
_COMPOSE_PATH=compose-files/
_TMP_DIR=$(_IMAGE_PATH)tmp/

.PHONY: --pre-build-steps get-stable

--pre-build-steps:
	[ ! -d "$(_TMP_DIR)" ] && mkdir -p $(_TMP_DIR)

get-latest: --pre-build-steps
	curl $(_STABLE_URL) --output $(_TMP_DIR)$(_STABLE_NAME).tgz -#
	[ ! -d "$(_IMAGE_PATH)$(_STABLE_NAME)" ] && mkdir $(_IMAGE_PATH)$(_STABLE_NAME) || :
	tar -xzvf $(_TMP_DIR)$(_STABLE_NAME).tgz --strip-components=1 -C $(_IMAGE_PATH)$(_STABLE_NAME)
	rm -rf $(_TMP_DIR)

build-latest:
	docker build -t dokuwiki:latest --build-arg VERSION=latest $(_IMAGE_PATH)

build-latest-installer:
	docker build -t dokuwiki:latest-installer --build-arg VERSION=latest --build-arg INSTALLER=true $(_IMAGE_PATH)

build-latest-ldap:
	docker build -t dokuwiki:latest-ldap --build-arg VERSION=latest --build-arg LDAP=true $(_IMAGE_PATH)

build-latest-installer-ldap:
	docker build -t dokuwiki:latest-installer-ldap --build-arg VERSION=latest --build-arg INSTALLER=true --build-arg LDAP=true $(_IMAGE_PATH)

compose-up:
	docker-compose -f $(_COMPOSE_PATH)/docker-compose.yml up -d

compose-down:
	docker-compose -f $(_COMPOSE_PATH)/docker-compose.yml down


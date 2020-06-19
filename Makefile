_STABLE_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
_STABLE_NAME=dokuwiki-stable

_RC_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-rc.tgz
_RC_NAME=dokuwiki-release-candidate

_IMAGE_PATH=image-files/
_COMPOSE_PATH=compose-files/
_TMP_DIR=$(_IMAGE_PATH)tmp/

.PHONY: --pre-build-steps get-stable get-rc

--pre-build-steps:
	[ ! -d "$(_TMP_DIR)" ] && mkdir $(_TMP_DIR)

get-stable: --pre-build-steps
	[ ! -d "$(_IMAGE_PATH)$(_STABLE_NAME)" ] && mkdir $(_IMAGE_PATH)$(_STABLE_NAME) || :
	curl $(_STABLE_URL) --output $(_TMP_DIR)$(_STABLE_NAME).tgz -#
	tar -xzvf $(_TMP_DIR)$(_STABLE_NAME).tgz --strip-components=1 -C $(_IMAGE_PATH)$(_STABLE_NAME)
	rm -rf $(_TMP_DIR)$(_STABLE_NAME).tgz $(_TMP_DIR)

get-rc: --pre-build-steps
	curl $(_RC_URL) --output $(_TMP_DIR)$(_RC_NAME).tgz -#
	[ ! -d "$(_IMAGE_PATH)$(_RC_NAME)" ] && mkdir $(IMAGE_PATH)$(_RC_NAME) || :
	tar -xzvf $(_TMP_DIR)$(_RC_NAME).tgz --strip-components=1 -C $(_IMAGE_PATH)$(_RC_NAME)
	rm -rf $(_TMP_DIR)$(_RC_NAME).tgz $(_TMP_DIR)


build-laest:
	docker build -t dokuwiki:latest --build-arg VERSION=latest $(_IMAGE_PATH)

build-latest-installer:
	docker build -t dokuwiki:latest --build-arg VERSION=latest --build-arg INSTALLER=true $(_IMAGE_PATH)

build-latest-ldap:
	docker build -t dokuwiki:latest --build-arg VERSION=latest --build-arg LDAP_true $(_IMAGE_PATH)

build-latest-installer-ldap:
	docker build -t dokuwiki:latest --build-arg VERSION=latest --build-arg INSTALLER=true --build-arg LDAP_true $(_IMAGE_PATH)


build-laest:
	docker build -t dokuwiki:rc --build-arg VERSION=release-candidate $(_IMAGE_PATH)

build-release-candidate-installer:
	docker build -t dokuwiki:rc --build-arg VERSION=release-candidate --build-arg INSTALLER=true $(_IMAGE_PATH)

build-release-candidate-ldap:
	docker build -t dokuwiki:rc --build-arg VERSION=release-candidate --build-arg LDAP_true $(_IMAGE_PATH)

build-release-candidate-installer-ldap:
	docker build -t dokuwiki:rc --build-arg VERSION=release-candidate --build-arg INSTALLER=true --build-arg LDAP_true $(_IMAGE_PATH)

compose-up:
	docker-compose -f $(_COMPOSE_PATH)/docker-compose.yml up

compose-up-detached:
	docker-compose -f $(_COMPOSE_PATH)/docker-compose.yml up -d

compose-down:
	docker-compose -f $(_COMPOSE_PATH)/docker-compose.yml down

compose-down-all:
	docker-compose -f $(_COMPOSE_PATH)/docker-compose.yml down -v


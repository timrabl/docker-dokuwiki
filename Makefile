_STABLE_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
_STABLE_NAME=dokuwiki-stable

_RC_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-rc.tgz
_RC_NAME=dokuwiki-release-candidate


#----------------------------------
_IMAGE_PATH=image-files/
_TMP_DIR=$(_IMAGE_PATH)tmp/

.PHONY: --pre-build-steps get-stable get-rc

--pre-build-steps:
	[ ! -d "$(_TMP_DIR)" ] && mkdir $(_TMP_DIR)


#	[[ "$$(xmllint --html --xpath "//body/form/div/div/div[2]/div/div[2]/div/ul/li//label[@class='radio']/span[../input[@value='stable']]/text()" - <<< $$(wget https://download.dokuwiki.org/ -q -O -))" == "$$(cat $(_IMAGE_PATH)$(_STABLE_NAME)/VERSION)" ]] && echo "dokuwiki ( $(_IMAGE_PATH)$(_STABLE_NAME) ) already newest version !"; exit 1 | :
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

build-stable:
	docker build -t dokuwiki:latest $(_IMAGE_PATH)

build-stable-installer-ldap:
	docker build --build-arg LDAP=true --build-arg INSTALLER=true -t dokuwiki:st-i-ldap $(_IMAGE_PATH)

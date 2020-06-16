STABLE_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
STABLE_NAME=dokuwiki-stable

RC_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-rc.tgz
RC_NAME=dokuwiki-release-candidate


#----------------------------------
_IMAGE_PATH=image-files/
_TMP_DIR=$(_IMAGE_PATH)tmp/

.PHONY: --pre-build-steps get-stable get-rc

--pre-build-steps:
	[ ! -d "$(_TMP_DIR)" ] && mkdir $(_TMP_DIR) || :

get-stable: --pre-build-steps
	curl $(STABLE_URL) --output $(_TMP_DIR)$(STABLE_NAME).tgz -#
	[ ! -d "$(_IMAGE_PATH)$(STABLE_NAME)" ] && mkdir $(IMAGE_PATH)$(STABLE_NAME) || :
	tar -xzvf $(_TMP_DIR)$(STABLE_NAME).tgz --strip-components=1 -C $(_IMAGE_PATH)$(STABLE_NAME)
	rm -rf $(_TMP_DIR)$(STABLE_NAME).tgz $(_TMP_DIR)

get-rc: --pre-build-steps
	curl $(RC_URL) --output $(_TMP_DIR)$(RC_NAME).tgz -#
	[ ! -d "$(_IMAGE_PATH)$(RC_NAME)" ] && mkdir $(IMAGE_PATH)$(RC_NAME) || :
	tar -xzvf $(_TMP_DIR)$(RC_NAME).tgz --strip-components=1 -C $(_IMAGE_PATH)$(RC_NAME)
	rm -rf $(_TMP_DIR)$(RC_NAME).tgz $(_TMP_DIR)

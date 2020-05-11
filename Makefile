SOURCE_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz

IMAGE_DIR=image-files/
COMPOSE_DIR=compose-files/

_TMP_DIR=tmp/
_OUTPUT_PATH=dokuwiki/


.PHONY: update build deploy clean

CMD_1=
CMD_2=

update:
	exit 0
	[[ -d "$(IMAGE_DIR)$(_OUTPUT_PATH)" ]] && [[ "$$(xmllint --html --xpath "//body/form/div/div/div[2]/div/div[2]/div/ul/li//label[@class='radio']/span[../input[@value='stable']]/text()" - <<< $$(wget https://download.dokuwiki.org/ -q -O -))" == "$$(cat $(IMAGE_DIR)$(_OUTPUT_PATH)VERSION)" ]] && exit 0 || continue
	[ ! -d "$(IMAGE_DIR)$(_TMP_DIR)" ] && mkdir $(IMAGE_DIR)$(_TMP_DIR) || continue
	curl $(SOURCE_URL) --output $(IMAGE_DIR)$(_TMP_DIR)dokuwiki.tgz
	mkdir -p $(IMAGE_DIR)$(_OUTPUT_PATH)
	tar zxvf $(IMAGE_DIR)$(_TMP_DIR)/dokuwiki.tgz --strip-components=1 -C $(IMAGE_DIR)$(_OUTPUT_PATH)
	rm -r $(IMAGE_DIR)$(_TMP_DIR)
build:
	docker build -t dokuwiki:latest -f $(IMAGE_DIR)Dockerfile $(IMAGE_DIR) 

deploy:
	docker-compose -f $(COMPOSE_DIR)docker-compose.yml up -d 

clean:
	rm -rf $(IMAGE_DIR)$(_OUTPUT_PATH)

SOURCE_URL=https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz

IMAGE_DIR=image-files/
COMPOSE_DIR=compose-files/

_TMP_DIR=tmp/
_OUTPUT_PATH=dokuwiki/


.PHONY: update build deploy clean
CMD_1 := $(shell xmllint --html --xpath "//body/form/div/div/div[2]/div/div[2]/div/ul/li//label[@class='radio']/span[../input[@value='stable']]/text()" - <<<$$(wget https://download.dokuwiki.org/ -q -O -))
CMD_2 := $(shell cat $(IMAGE_DIR)$(_OUTPUT_PATH)VERSION)

update:
	@if [[ -d "$(IMAGE_DIR)$(_OUTPUT_PATH)" ]] && [[ "$(CMD_1)" == "$(CMD_2)" ]]; then \
		: ; \
	else \
		if [ ! -d "$(IMAGE_DIR)$(_TMP_DIR)" ]; then \
			mkdir $(IMAGE_DIR)$(_TMP_DIR); \
		else \
			: ;\
		fi ;\
		curl $(SOURCE_URL) --output $(IMAGE_DIR)$(_TMP_DIR)dokuwiki.tgz ;\
		mkdir -p $(IMAGE_DIR)$(_OUTPUT_PATH) ;\
		tar zxvf $(IMAGE_DIR)$(_TMP_DIR)/dokuwiki.tgz --strip-components=1 -C $(IMAGE_DIR)$(_OUTPUT_PATH) ;\
		rm -r $(IMAGE_DIR)$(_TMP_DIR) ;\
	fi ;
build:
	docker build -t dokuwiki:latest -f $(IMAGE_DIR)Dockerfile $(IMAGE_DIR) 

deploy:
	docker-compose -f $(COMPOSE_DIR)docker-compose.yml up -d 

clean:
	rm -rf $(IMAGE_DIR)$(_OUTPUT_PATH)

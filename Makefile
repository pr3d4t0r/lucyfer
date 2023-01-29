# vim: set fileencoding=utf-8:


DOCKER_IMAGE_NAME_FILE=dockerimagename.txt
DOCKER_IMAGE_VERSION_FILE=dockerimageversion.txt
DOCKER_IMAGE=$(shell cat $(DOCKER_IMAGE_NAME_FILE))
DOCKER_VERSION=$(shell cat $(DOCKER_IMAGE_VERSION_FILE))

include ./build.mk


version:
	cp "$(DOCKER_IMAGE_VERSION_FILE)" kallisto
	cp "$(DOCKER_IMAGE_VERSION_FILE)" arm64
	cp "$(DOCKER_IMAGE_VERSION_FILE)" arm64/kallisto


all:
	make version
	pushd arm64/kallisto && make image && make push && popd
	pushd kallisto && make image && make push && popd
	pushd arm64 && make image && make push && popd
	make image
	make push


# (c) Copyright 2022 Lucyfer Contributors

# vim: set fileencoding=utf-8:


DOCKER_IMAGE_NAME_FILE=dockerimagename.txt
DOCKER_IMAGE_VERSION_FILE=dockerimageversion.txt
DOCKER_IMAGE=$(shell cat $(DOCKER_IMAGE_NAME_FILE))
DOCKER_VERSION=$(shell cat $(DOCKER_IMAGE_VERSION_FILE))

include ./build.mk


version:
	cp "$(DOCKER_IMAGE_VERSION_FILE)" arm64
	cp "$(DOCKER_IMAGE_VERSION_FILE)" arm64/kallisto
	cp "$(DOCKER_IMAGE_VERSION_FILE)" kallisto


all:
	make version
	pushd arm64 && make image && popd
	pushd arm64 && make push && popd
	make image
	make push


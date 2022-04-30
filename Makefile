# (c) Copyright 2022 Lucyfer Contributors

# vim: set fileencoding=utf-8:


DOCKER_IMAGE=$(shell cat dockerimagename.txt)
DOCKER_VERSION=$(shell cat dockerimageversion.txt)

include ./build.mk


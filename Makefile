# (c) Copyright 2022, pr3d4t0r

# vim: set fileencoding=utf-8:


DOCKER_IMAGE=$(shell cat dockerimagename.txt)
DOCKER_VERSION=$(shell cat dockerimageversion.txt)

include ./build.mk


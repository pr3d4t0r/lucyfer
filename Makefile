# License:  https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/LICENSE.txt

DOCKER_IMAGE_NAME_FILE=dockerimagename.txt
DOCKER_IMAGE_VERSION_FILE=dockerimageversion.txt
DOCKER_IMAGE=$(shell cat $(DOCKER_IMAGE_NAME_FILE))
DOCKER_VERSION=$(shell cat $(DOCKER_IMAGE_VERSION_FILE))
README_TMP="/tmp/README.md"

include ./build.mk


version:
	cp "$(DOCKER_IMAGE_VERSION_FILE)" arm64
	cp "$(DOCKER_IMAGE_VERSION_FILE)" arm64/kallisto
	cp "$(DOCKER_IMAGE_VERSION_FILE)" kallisto
	awk -v "version=${DOCKER_VERSION}" \
		'/^# Lucyfer/ && NR < 3 { printf("# Lucyfer %s\n", version); next; } { print; }' README.md \
		> ${README_TMP} \
		&& cp ${README_TMP} README.md


all:
	make version
	pushd arm64 && make image && make push && popd
	pushd arm64/kallisto && make image && make push && popd
	pushd kallisto && make image && make push && popd
	make image && make push


LUCY_PRESENT=$(shell if [[ -e "lucy" ]]; then echo "true"; else echo "false"; fi)

image:
	docker build --progress=plain --compress --force-rm -t $(DOCKER_IMAGE):$(DOCKER_VERSION) --build-arg LUCYFER_VERSION=$(DOCKER_VERSION) .
	docker tag $(DOCKER_IMAGE):$(DOCKER_VERSION) $(DOCKER_IMAGE):latest
ifeq ($(LUCY_PRESENT), true)
	awk -v "version=$(DOCKER_VERSION)" '/^LUCYFER_HUB_VERSION/ { printf("LUCYFER_HUB_VERSION=\"%s\"\n", version); next; } { print; }' lucy > /tmp/lucy && \
    cat /tmp/lucy > lucy && \
    rm /tmp/lucy
endif


build:
	docker buildx build --platform linux/amd64,linux/arm64 --compress --force-rm --progress=plain -t $(DOCKER_IMAGE):$(DOCKER_VERSION) --build-arg LUCYFER_VERSION=$(DOCKER_VERSION) --push .
	docker buildx imagetools create -t $(DOCKER_IMAGE):latest $(DOCKER_IMAGE):$(DOCKER_VERSION)
ifeq ($(LUCY_PRESENT), true)
	awk -v "version=$(DOCKER_VERSION)" '/^LUCYFER_HUB_VERSION/ { printf("LUCYFER_HUB_VERSION=\"%s\"\n", version); next; } { print; }' lucy > /tmp/lucy && \
    cat /tmp/lucy > lucy && \
    rm /tmp/lucy
endif


push:
	docker push $(DOCKER_IMAGE):$(DOCKER_VERSION)
	docker push $(DOCKER_IMAGE):latest


# License:  https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/LICENSE.txt

LUCY_PRESENT=$(shell if [[ -e "lucy" ]]; then echo "true"; else echo "false"; fi)

image:
	docker build --progress=plain --compress --force-rm -t $(DOCKER_IMAGE):$(DOCKER_VERSION) --build-arg LUCYFER_VERSION=$(DOCKER_VERSION) .
	docker tag $(DOCKER_IMAGE):$(DOCKER_VERSION) $(DOCKER_IMAGE):latest
ifeq ($(LUCY_PRESENT), true)
	awk -v "version=$(DOCKER_VERSION)" '/^LUCYFER_HUB_VERSION/ { printf("LUCYFER_HUB_VERSION=\"%s\"\n", version); next; } { print; }' lucy > /tmp/lucy && \
    cat /tmp/lucy > lucy && \
    rm /tmp/lucy
	awk -v "version=$(DOCKER_VERSION)" '/^KALLISTO_HUB_VERSION/ { printf("KALLISTO_HUB_VERSION=\"%s\"\n", version); next; } { print; }' lucy > /tmp/lucy && \
    cat /tmp/lucy > lucy && \
    rm /tmp/lucy
endif


push:
	docker push $(DOCKER_IMAGE):$(DOCKER_VERSION)
	docker push $(DOCKER_IMAGE):latest


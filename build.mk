# (c) Copyright 2022 Lucyfer Contributors

# vim: set fileencoding=utf-8:


# TODO:  Implement buildx in a safe manner
# docker buildx build --load --progress=plain --compress --force-rm -t $(DOCKER_IMAGE):$(DOCKER_VERSION) --platform linux/arm64,linux/amd64 .
image:
	docker build --progress=plain --compress --force-rm -t $(DOCKER_IMAGE):$(DOCKER_VERSION) .
	docker tag $(DOCKER_IMAGE):$(DOCKER_VERSION) $(DOCKER_IMAGE):latest


push:
	docker push $(DOCKER_IMAGE):$(DOCKER_VERSION)
	docker push $(DOCKER_IMAGE):latest


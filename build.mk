# (c) Copyright 2022, pr3d4t0r

# vim: set fileencoding=utf-8:


image:
	docker build --progress=plain --compress --force-rm -t $(DOCKER_IMAGE):$(DOCKER_VERSION) .
	docker tag $(DOCKER_IMAGE):$(DOCKER_VERSION) $(DOCKER_IMAGE):latest


push:
	docker push $(DOCKER_IMAGE):$(DOCKER_VERSION)
	docker push $(DOCKER_IMAGE):latest


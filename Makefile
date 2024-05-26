export APP := datapains
export TAG := 0.0.1
export DOCKERFILE_PATH := tools/docker
export DOCKER_BUILD := build

.PHONY: build-image
build-image:
	docker $(DOCKER_BUILD) -t $(APP)/$(COMPONENT):$(TAG) -f $(DOCKERFILE_PATH)/$(COMPONENT)/Dockerfile $(CONTEXT)/$(COMPONENT)

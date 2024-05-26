export APP := datapains
export TAG := 0.0.1
export DOCKERFILE_PATH := tools/docker
export K8S_VANILLA_PATH := tools/k8s/vanilla
export ENV := local
export NAMESPACE := metastore
export DOCKER_BUILD := build

.PHONY: build-image
build-image:
	docker $(DOCKER_BUILD) -t $(APP)/$(COMPONENT):$(TAG) -f $(DOCKERFILE_PATH)/$(COMPONENT)/Dockerfile $(CONTEXT)/$(COMPONENT)

.PHONY: deploy-local-metastore
deploy-local-metastore:
	kubectl apply -f $(K8S_VANILLA_PATH)/$(ENV)/metastore

.PHONY: delete-local-metastore
delete-local-metastore:
	kubectl delete -f $(K8S_VANILLA_PATH)/$(ENV)/metastore

.PHONY: inspect-local-metastore
inspect-local-metastore:
	kubectl get pods -n $(NAMESPACE)

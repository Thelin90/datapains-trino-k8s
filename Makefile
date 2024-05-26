export APP := datapains
export TAG := 0.0.1
export DOCKERFILE_PATH := tools/docker
export K8S_VANILLA_PATH := tools/k8s/vanilla
export ENV := local
export NAMESPACE := metastore
export DOCKER_BUILD := build
export LOCAL_TRINO_VALUES := tools/k8s/helm/trino/local

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

.PHONY: log-pod
log-pod:
	kubectl logs $(COMPONENT) -n $(NAMESPACE) $(TAIL)

.PHONY: deploy-local-trino
deploy-local-trino:
	kubectl create namespace $(NAMESPACE)
	helm install -f $(LOCAL_TRINO_VALUES)/values.yaml datapains-trino-cluster trino/trino --namespace $(NAMESPACE)

.PHONY: delete-local-trino
delete-local-trino:
	helm uninstall datapains-trino-cluster --namespace $(NAMESPACE)

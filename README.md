# DataPains Trino Kubernetes

# Pre Requisites

# Setup

## MinIO With Metastore

In this workshop I provide to you a setup for a Min

### Docker

If you are using M1 chip:

```bash
make build-image COMPONENT=metastore DOCKER_BUILD="buildx build --platform linux/amd64" CONTEXT="tools/docker"
```

Otherwise

```bash
make build-image COMPONENT=metastore CONTEXT="tools/docker"
```

### Vanilla - Local

```bash
make deploy-local-metastore
```

To delete

```bash
make delete-local-metastore
```

## Trino

### Helm

First add the trino helm repo!

```bash
helm repo add trino https://trinodb.github.io/charts
```



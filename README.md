# DataPains Trino Kubernetes

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

### Helm

## Trino

### Helm


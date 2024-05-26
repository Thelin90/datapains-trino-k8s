# DataPains Trino Kubernetes

[Medium Article For Reference](https://medium.com/@simon.thelin90/trino-minio-metastore-workshop-kubernetes-dbede7b1eca1)

# Pre Requisites

# Setup

## MinIO With Metastore

In this workshop I provide to you a setup for a MinIO with a Metastore (utilising postgres internally)
to successfully query delta tables via trino.

### Docker

If you are using M1 chip:

```bash
make build-image COMPONENT=metastore DOCKER_BUILD="buildx build --platform linux/amd64" CONTEXT="tools/docker"
```

Otherwise

```bash
make build-image COMPONENT=metastore CONTEXT="tools/docker"
```

### Metastore - Vanilla - Local

```bash
make deploy-local-metastore ENV=local
```

To delete

```bash
make delete-local-metastore ENV=local
```

#### Statefulset

For `Hive`, `Postgres`, `MinIO` we choose to use `StatefulSet` as the deployment type over `Deployment`.

A StatefulSet should be chosen for stateful components that require predictable Pod identities,
ordered rollouts, and stable storage access.

Deployment should be chosen instead when your service is stateless,
doesn't require persistent storage, and won't be affected by changes to Pod identities.

## Trino

### Helm

First add the trino helm repo!

```bash
helm repo add trino https://trinodb.github.io/charts
```

Make sure you use version >= `0.21.0`
```bash
helm search repo trino
```

Should give:

```bash
NAME       	CHART VERSION	APP VERSION	DESCRIPTION
trino/trino	0.21.0       	448        	Fast distributed SQL query engine for big data ...
```

#### values.yaml

We use default values for the deployment, but please note section:

```yaml
additionalCatalogs:
  lakehouse: |-
    connector.name=delta_lake
    hive.metastore.uri=thrift://hive-service.metastore:9083
    hive.s3.endpoint=http://minio-service.metastore:9000
    hive.s3.path-style-access=true
    hive.s3.aws-access-key=minio
    hive.s3.aws-secret-key=minio123
    delta.enable-non-concurrent-writes=true
  rdbms: |-
    connector.name=postgresql
    connection-url=jdbc:postgresql://postgres-service.metastore:5432/hivemetastore?allowPublicKeyRetrieval=true&amp;useSSL=false&amp;serverTimezone=UTC
    connection-user=metastore
    connection-password=password
```

This will ensure we can query our tables from our metastore.

```bash
make deploy-local-trino NAMESPACE=trino
```

And to delete

```bash
make delete-local-trino NAMESPACE=trino
```

#### Setup Delta Table And Query!

The trino cluster is now up and running!

We will have to execute ourselves into the `coordinator` and create a table.

```bash
kubectl get pods -n trino
```

```bash
kubectl exec -it datapains-trino-cluster-coordinator-747bc6ccff-b6tx2 -n trino -- /bin/bash
```

```bash
[trino@datapains-trino-cluster-coordinator-747bc6ccff-b6tx2 /]$ trino
trino> SHOW CATALOGS;
  Catalog
-----------
 lakehouse
 system
 tpcds
 tpch
(4 rows)

Query 20240526_120408_00000_kyyrh, FINISHED, 2 nodes
Splits: 20 total, 20 done (100.00%)
2.57 [0 rows, 0B] [0 rows/s, 0B/s]
```

```bash
trino> CREATE SCHEMA lakehouse.bronze;
```

```bash
trino> CREATE TABLE lakehouse.bronze.products ( name VARCHAR, price DOUBLE, product_no BIGINT, ingest_date DATE, created TIMESTAMP WITH TIME ZONE);
```

```bash
trino> SELECT * FROM lakehouse.bronze.products;
INSERT INTO lakehouse.bronze.products VALUES (CAST('Apple' AS VARCHAR), CAST(889.0 AS DOUBLE), CAST(1654523786273 AS BIGINT), CURRENT_DATE, CURRENT_TIMESTAMP);
trino> SELECT * FROM lakehouse.bronze.products;
```

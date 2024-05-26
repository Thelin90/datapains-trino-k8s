#!/bin/sh

####
# Hive Properties
####
hive_properties() {

    echo "fs.s3a.awsAccessKeyId=$AWS_ACCESS_KEY"
    echo "fs.s3a.awsSecretAccessKey=$AWS_SECRET_ACCESS_KEY"
    echo "fs.s3a.access.key=$AWS_ACCESS_KEY"
    echo "fs.s3a.secret.key=$AWS_SECRET_ACCESS_KEY"

    echo "hive.metastore.warehouse.dir=s3a://$S3_BUCKET"
    echo "hive.s3.aws-access-key=$AWS_ACCESS_KEY"
    echo "hive.s3.aws-secret-key=$AWS_SECRET_ACCESS_KEY"
    echo "hive.s3.ssl.enabled=$HIVE_SSL_ENABLED"
    echo "hive.s3.use-instance-credentials=$HIVE_USE_INSTANCE_CREDENTIALS"
    echo "hive.metastore.uris=thrift://$HIVE_HOST:$HIVE_PORT"
    echo "hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat"

    echo "metastore.thrift.port=$HIVE_PORT"

    echo "hive.metastore-cache-ttl=0s"
    echo "hive.metastore-refresh-interval=5s"
    echo "hive.allow-drop-table=true"
    echo "hive.allow-rename-table=true"

} > "/opt/hive-metastore/conf/hive.properties"

hive_properties

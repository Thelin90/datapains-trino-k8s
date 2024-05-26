#!/bin/bash

hive_site()
{
    echo "<configuration>"

    echo "  <property>"
    echo "      <name>javax.jdo.option.ConnectionURL</name>"
    echo "      <value>jdbc:postgresql://$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB?createDatabaseIfNotExist=true</value>"
    echo "      <description>PostgreSQL JDBC driver connection URL</description>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>javax.jdo.option.ConnectionDriverName</name>"
    echo "      <value>org.postgresql.Driver</value>"
    echo "      <description>PostgreSQL metastore driver class name</description>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>javax.jdo.option.ConnectionUserName</name>"
    echo "      <value>$POSTGRES_USER</value>"
    echo "      <description>the username for the DB instance</description>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>javax.jdo.option.ConnectionPassword</name>"
    echo "      <value>$POSTGRES_PASSWORD</value>"
    echo "      <description>the pa$sword for the DB instance</description>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.metastore.server.min.threads</name>"
    echo "      <value>$HIVE_METASTORE_SERVER_MIN_THREADS</value>"
    echo "      <description>Number of threads</description>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.metastore.server.max.threads</name>"
    echo "      <value>$HIVE_METASTORE_SERVER_MAX_THREADS</value>"
    echo "      <description>Number of threads</description>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.metastore.warehouse.dir</name>"
    echo "      <value>s3a://$S3_BUCKET</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.s3.use-instance-credentials</name>"
    echo "      <value>false</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.s3.ssl.enabled</name>"
    echo "      <value>false</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.s3.aws-access-key</name>"
    echo "      <value>$AWS_ACCESS_KEY</value>"
    echo " </property>"

    echo "  <property>"
    echo "      <name>hive.s3.aws-secret-key</name>"
    echo "      <value>$AWS_SECRET_ACCESS_KEY</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.s3.path-style-access</name>"
    echo "      <value>false</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>fs.s3a.awsAccessKeyId</name>"
    echo "      <value>$AWS_ACCESS_KEY</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>fs.s3a.awsSecretAccessKey</name>"
    echo "      <value>$AWS_SECRET_ACCESS_KEY</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>fs.s3a.endpoint</name>"
    echo "      <value>http://host.docker.internal:30000</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>fs.s3a.impl</name>"
    echo "      <value>org.apache.hadoop.fs.s3a.S3AFileSystem</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>fs.s3a.path.style.access</name>"
    echo "      <value>true</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>metastore.thrift.port</name>"
    echo "      <value>$HIVE_PORT</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.metastore.uris</name>"
    echo "      <value>thrift://$HIVE_HOST:$HIVE_PORT</value>"
    echo "      <description>IP address (or fully-qualified domain name) and port of the metastore host</description>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.metastore.schema.verification</name>"
    echo "      <value>true</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.input.format</name>"
    echo "      <value>org.apache.hadoop.hive.ql.io.CombineHiveInputFormat</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.metastore-cache-ttl</name>"
    echo "      <value>0s</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.metastore-refresh-interval</name>"
    echo "      <value>5s</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.allow-drop-table</name>"
    echo "      <value>true</value>"
    echo "  </property>"

    echo "  <property>"
    echo "      <name>hive.allow-rename-table</name>"
    echo "      <value>true</value>"
    echo "  </property>"

    echo "</configuration>"

} > "/opt/hive-metastore/conf/hive-site.xml"

hive_site
#!/bin/sh

export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-${HADOOP_VERSION}.jar
export HIVE_OPTS="${HIVE_OPTS} --hiveconf metastore.root.logger=${HIVE_LOGLEVEL},console "
export PATH=${HIVE_HOME}/bin:${HADOOP_HOME}/bin:$PATH

set +e

if /opt/hive-metastore/bin/schematool -dbType postgres -info -verbose; then
    echo "Hive metastore is already setup, will not run -initSchema"
else
    echo "Hive metastore not setup, will run -initSchema"
    if /opt/hive-metastore/bin/schematool -dbType postgres -initSchema -verbose; then
        echo "Hive metastore schema created."
    else
        echo "Error creating hive metastore: $?"
    fi
fi
set -e

/opt/hive-metastore/bin/start-metastore

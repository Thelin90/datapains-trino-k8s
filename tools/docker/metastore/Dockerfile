FROM openjdk:8-slim

ARG HADOOP_VERSION=3.2.0
ARG HIVE_HOME=/opt/hive-metastore
ARG HIVE_VERSION=3.1.2

ENV HADOOP_HOME="/opt/hadoop"

RUN apt-get update && apt-get install -y curl --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
	| tar xvz -C /opt/  \
	&& ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop \
	&& rm -r /opt/hadoop/share/doc

RUN ln -s /opt/hadoop/share/hadoop/tools/lib/hadoop-aws* /opt/hadoop/share/hadoop/common/lib/ && \
    ln -s /opt/hadoop/share/hadoop/tools/lib/aws-java-sdk* /opt/hadoop/share/hadoop/common/lib/

RUN curl https://repo1.maven.org/maven2/org/apache/hive/hive-standalone-metastore/${HIVE_VERSION}/hive-standalone-metastore-${HIVE_VERSION}-bin.tar.gz \
	| tar xvz -C /opt/ \
	&& ln -s /opt/apache-hive-metastore-${HIVE_VERSION}-bin ${HIVE_HOME}

RUN curl -o ${HIVE_HOME}/lib/postgresql-42.3.3.jar -L https://jdbc.postgresql.org/download/postgresql-42.3.3.jar
RUN curl -o ${HIVE_HOME}/lib/hive-exec-3.1.3.jar -L https://repo1.maven.org/maven2/org/apache/hive/hive-exec/3.1.3/hive-exec-3.1.3.jar

ARG LOG4J_VERSION=2.17.2
ARG LOG4J_LOCATION="https://repo1.maven.org/maven2/org/apache/logging/log4j"
RUN rm -f ${HADOOP_HOME}/share/hadoop/common/lib/slf4j-log4j12* && \
    rm -f ${HADOOP_HOME}/share/hadoop/common/lib/log4j* && \
    rm -f ${HADOOP_HOME}/share/hadoop/hdfs/lib/log4j* && \
    rm -f ${HADOOP_HOME}/share/hadoop/yarn/hadoop-yarn-applications-catalog-webapp-3.3.1.war && \
    rm -f ${HIVE_HOME}/lib/log4j-* && \
    curl -o ${HIVE_HOME}/lib/log4j-1.2-api-${LOG4J_VERSION}.jar ${LOG4J_LOCATION}/log4j-1.2-api/${LOG4J_VERSION}/log4j-1.2-api-${LOG4J_VERSION}.jar  && \
    curl -o ${HIVE_HOME}/lib/log4j-api-${LOG4J_VERSION}.jar ${LOG4J_LOCATION}/log4j-api/${LOG4J_VERSION}/log4j-api-${LOG4J_VERSION}.jar && \
    curl -o ${HIVE_HOME}/lib/log4j-core-${LOG4J_VERSION}.jar ${LOG4J_LOCATION}/log4j-core/${LOG4J_VERSION}/log4j-core-${LOG4J_VERSION}.jar && \
    curl -o ${HIVE_HOME}/lib/log4j-slf4j-impl-${LOG4J_VERSION}.jar ${LOG4J_LOCATION}/log4j-slf4j-impl/${LOG4J_VERSION}/log4j-slf4j-impl-${LOG4J_VERSION}.jar && \
    rm ${HIVE_HOME}/conf/metastore-site.xml && \
    rm ${HIVE_HOME}/conf/metastore-site.xml.template

COPY conf/metastore-log4j2.properties ${HIVE_HOME}/conf/metastore-log4j2.properties

RUN mkdir -p /var/lib/hive /.beeline ${HOME}/.beeline

COPY scripts/entrypoint.sh ${HIVE_HOME}/entrypoint.sh
COPY scripts/set-hive-site.sh ${HIVE_HOME}/set-hive-site.sh
COPY scripts/set-hive-properties.sh ${HIVE_HOME}/set-hive-properties.sh

RUN chmod +x ${HIVE_HOME}/*.sh

WORKDIR /opt/hive-metastore

ENTRYPOINT ["sh", "-c", "/opt/hive-metastore/set-hive-site.sh && /opt/hive-metastore/set-hive-properties.sh && /opt/hive-metastore/entrypoint.sh"]

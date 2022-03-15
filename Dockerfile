FROM alpine:3.14

ARG SCALA_VERSION=2.13
ARG KAFKA_VERSION=3.0.1
ARG ZOOKEEPER_VERSION=3.4.9

RUN echo "http://mirror.reenigne.net/alpine/v3.14/community" >> /etc/apk/repositories
RUN apk add --update openjdk11 supervisor bash gcompat

ENV ZOOKEEPER_HOME /opt/zookeeper-$ZOOKEEPER_VERSION
RUN wget -q http://archive.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz -O /tmp/zookeeper-$ZOOKEEPER_VERSION.tgz
RUN ls -l /tmp/zookeeper-$ZOOKEEPER_VERSION.tgz
RUN tar xfz /tmp/zookeeper-$ZOOKEEPER_VERSION.tgz -C /opt && rm /tmp/zookeeper-$ZOOKEEPER_VERSION.tgz
ADD assets/conf/zoo.cfg $ZOOKEEPER_HOME/conf

ENV KAFKA_HOME /opt/kafka_$SCALA_VERSION-$KAFKA_VERSION
ENV KAFKA_DOWNLOAD_URL https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz
RUN wget -q $KAFKA_DOWNLOAD_URL -O /tmp/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz
RUN tar xfz /tmp/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz -C /opt && rm /tmp/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz

ADD assets/scripts/start-kafka /usr/bin/start-kafka
ADD assets/scripts/start-zookeeper /usr/bin/start-zookeeper
ADD assets/scripts/start-all /usr/bin/start-all

ADD assets/supervisor/kafka.ini assets/supervisor/zookeeper.ini /etc/supervisor.d/

RUN mkdir -p /etc/confluent/docker
RUN ln -s /usr/bin/start-all /etc/confluent/docker/launch
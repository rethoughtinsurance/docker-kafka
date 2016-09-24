FROM mcapitanio/centos-java

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ENV CONFLUENTIC_KAFKA_VER 3.0.1
ENV KAFKA_MANAGER_VER 1.3.1.6
ENV GRADLE_VER 2.13

ARG httpProxyHost
ARG httpProxyPort
ARG httpProxyUrl
ARG httpsProxyUrl

ENV http_proxy $httpProxyUrl
ENV https_proxy $httpsProxyUrl
ENV no_proxy $no_proxy
ENV httpProxyHost $httpProxyHost
ENV httpProxyPort $httpProxyPort
ENV JAVA_OPTS="-Dhttp.proxyHost=$httpProxyHost -Dhttp.proxyPort=$httpProxyPort -Dhttps.proxyHost=$httpProxyHost -Dhttps.proxyPort=$httpProxyPort"

ENV KAFKA_HOME /opt/kafka
ENV KAFKA_MANAGER_HOME /opt/kafka-manager
ENV GRADLE_HOME /opt/gradle

ENV PATH $GRADLE_HOME/bin:$KAFKA_HOME/bin:$KAFKA_MANAGER_HOME/bin:$PATH

# Install needed packages
RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum clean all; yum update -y
RUN yum install -y git \
    maven \
    python-pip \
    python-setuptools \
    wget \
    unzip \
    sbt
RUN easy_install supervisor
RUN yum clean all

WORKDIR /opt/docker

RUN mkdir /root/.m2
COPY settings.xml ./
COPY set-maven-proxy.sh ./
RUN chmod +x set-maven-proxy.sh
RUN ./set-maven-proxy.sh

# Install Gradle
RUN wget -N https://services.gradle.org/distributions/gradle-$GRADLE_VER-all.zip
RUN unzip gradle-$GRADLE_VER-all.zip
RUN mv gradle-$GRADLE_VER $GRADLE_HOME

# Apache Kafka
RUN git clone -b v$CONFLUENTIC_KAFKA_VER https://github.com/confluentinc/kafka.git
RUN cd kafka; \
    gradle
RUN cd kafka; \
    ./gradlew clean; \
    ./gradlew releaseTarGz
RUN mv kafka $KAFKA_HOME
RUN mkdir -p $KAFKA_HOME/logs

# Kafka Manager
RUN git clone -b $KAFKA_MANAGER_VER https://github.com/yahoo/kafka-manager.git
RUN cd kafka-manager; \
    sbt clean dist
RUN unzip kafka-manager/target/universal/kafka-manager-$KAFKA_MANAGER_VER.zip -d /opt
RUN mv /opt/kafka-manager-$KAFKA_MANAGER_VER $KAFKA_MANAGER_HOME
RUN mkdir $KAFKA_MANAGER_HOME/logs

COPY kafka $KAFKA_HOME
RUN chmod +x $KAFKA_HOME/bin/supervisord-bootstrap.sh
COPY kafka-manager $KAFKA_MANAGER_HOME

COPY etc/ /etc/

EXPOSE 9092 9000

VOLUME [ "/opt/kafka/config", "/opt/kafka/logs", "/opt/kafka-manager/conf", "/opt/kafka-manager/logs" ]

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

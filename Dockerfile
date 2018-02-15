FROM docker.dbc.dk/payara-micro:io1578-logback-in-payara-micro

MAINTAINER DataIO
ARG PAYARA_MICRO_VERSION="4.1.2.181"
LABEL PayaraMicroVersion=$PAYARA_MICRO_VERSION
ARG PAYARA_DOWNLOAD_URL="http://mavenrepo.dbc.dk/content/repositories/releases/dk/dbc/payara-micro-logback/${PAYARA_MICRO_VERSION}/payara-micro-logback-${PAYARA_MICRO_VERSION}.zip"
ENV ADD_JVM_ARGS="-Dlogback.configurationFile=config/logback.xml"
ENV ADD_PAYARA_ARGS="--logproperties config/logging.properties"
ENV LOGBACK_CONF_FILE=config/logback-included.xml

USER root
RUN apt-get update && apt-get -qy install unzip

USER gfish
ADD config/* config/
ADD 00-get-logback-conf.sh config.d/
ADD --chown=gfish ${PAYARA_DOWNLOAD_URL} /payara-micro/

RUN unzip payara-micro-logback-${PAYARA_MICRO_VERSION}.zip && \
    mv payara-micro-logback-${PAYARA_MICRO_VERSION}/payara-micro.jar . && \
    mv -r payara-micro-logback-${PAYARA_MICRO_VERSION}/libs .
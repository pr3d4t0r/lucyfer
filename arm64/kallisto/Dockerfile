# (c) Copyright 2022 Lucyfer Contributors

# vim: set fileencoding=utf-8:


# TODO:  Implement buildx in a safe manner
# docker buildx use lucyfer-builder
# FROM            jupyter/scipy-notebook:latest
FROM            --platform=linux/arm64 ubuntu:jammy
MAINTAINER      lucyfer AT cime.net


USER            root
ENV             LANG en_US.UTF-8 LANGUAGE en_US:en LC_ALL en_US.UTF-8

RUN             DEBIAN_FRONTEND=noninteractive && \
                rm /bin/sh && ln -s /bin/bash /bin/sh && \
                apt-get update && \
                apt-get -y upgrade && \
                apt-get -y --no-install-recommends install locales software-properties-common && \
                locale-gen ${LC_ALL} 

RUN             DEBIAN_FRONTEND=noninteractive && \
                apt-get -y --no-install-recommends install \
                    curl \
                    default-jdk \
                    git \
                    unzip \
                    zip && \
                rm -rf /var/lib/apt/lists/*


# Blazegraph:

ENV             BLAZEGRAPH_HOME="/var/blazegraph"
RUN             mkdir -p "${BLAZEGRAPH_HOME}"
RUN             mkdir -p "${BLAZEGRAPH_HOME}/data"
COPY            RWStore.properties "${BLAZEGRAPH_HOME}"
WORKDIR         ${BLAZEGRAPH_HOME}
RUN             curl -sL -o blazegraph.jar "https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.jar"
WORKDIR         ${BLAZEGRAPH_HOME}
EXPOSE          9999
CMD             java -Xmx2g -Dcom.bigdata.rdf.sail.webapp.ConfigParams.propertyFile="${BLAZEGRAPH_HOME}/RWStore.properties" -jar ${BLAZEGRAPH_HOME}/blazegraph.jar


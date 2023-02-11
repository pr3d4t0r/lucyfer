FROM            ubuntu:jammy
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
                    ca-certificates \
                    curl \
                    git \
                    gnupg \
                    unzip \
                    zip

# Azul's JVM:
ARG             JAVA_VERSION=17
RUN             curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg && \
                echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list && \
                apt-get update && \
                apt-get -y install zulu${JAVA_VERSION}-jdk && \
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


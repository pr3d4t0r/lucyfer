# (c) Copyright 2022 Lucyfer Contributors

# vim: set fileencoding=utf-8:


# TODO:  Implement buildx in a safe manner
# docker buildx use lucyfer-builder
FROM            --platform=linux/amd64 jupyter/scipy-notebook:latest
MAINTAINER      lucyfer AT cime.net


USER            root

RUN             apt-get update && \
                apt-get -y upgrade && \
                apt-get -y install \
                    awscli \
                    bat \
                    bsdmainutils \
                    curl \
                    git \
                    graphviz \
                    htop \
                    jq \
                    rclone \
                    ssh \
                    tree \
                    vim

# Integration tools
RUN             CURRENT_VERSION=$(curl -Ls https://api.github.com/repos/Versent/saml2aws/releases/latest | jq '.tag_name[1:]' | awk '{ gsub("\"", ""); print; }') && \
                wget -c https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz -O - | tar -xzv -C /usr/local/bin && \
                chmod u+x /usr/local/bin/saml2aws

# Kotlin installation
RUN             apt-get -y install default-jdk


COPY            resources/_bash_profile /etc/skel/.bash_profile
COPY            resources/_bash_profile /root/.bash_profile
COPY            resources/_gitignore /etc/skel/.gitignore
COPY            resources/_vimrc /etc/skel/.vimrc

RUN             ln -s /usr/bin/batcat /usr/local/bin/bat

# ----------------------------------------

USER            jovyan

# Tools:
COPY            --chown=${NB_UID}:${NB_GID} resources/requirements.txt /tmp/
RUN             pip install -U --requirement /tmp/requirements.txt && \
                    fix-permissions "${CONDA_DIR}" && \
                    fix-permissions "/home/${NB_USER}"

# SPARQL kernel support

# ----- Use Vivian Rook's patch for now -----
USER            root
RUN             curl -o /opt/sparql-kernel-T320934.zip "https://cime.net/upload_area/sparql-kernel-T320934.zip"
RUN             cd /opt &&  \
                    unzip sparql-kernel-T320934.zip &&  \
                    rm -f sparql-kernel-T320934.zip &&  \
                    cd sparql-kernel-T320934 && \
                    pip install -e .
RUN             jupyter sparqlkernel install 
# ----- Pending update to the SPARQL kernel project ----
# RUN             pip install sparqlkernel
# USER            root
# RUN             jupyter sparqlkernel install
# # RUN             jupyter sparqlkernel install --user

# Kotlin kernel support
RUN             pip install kotlin-jupyter-kernel


USER            jovyan
ARG             LUCYFER_VERSION=0.0.0
ENV             LUCYFER_VERSION=${LUCYFER_VERSION}


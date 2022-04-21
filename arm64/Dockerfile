# (c) Copyright 2022 pr3d4t0r

# vim: set fileencoding=utf-8:


# TODO:  See https://github.com/pr3d4t0r/lucyfer/issues/26
#        Use buildx once we have a common base image for all
#        architectures.
FROM            --platform=linux/arm64 jupyter/scipy-notebook:latest
MAINTAINER      lucyfer AT cime.net


USER            root

RUN             apt-get update && \
                apt-get -y upgrade && \
                apt-get -y install \
                    git \
                    graphviz \
                    jq \
                    rclone \
                    ssh \
                    tree \
                    vim


# Kotlin installation
RUN             apt-get -y install default-jdk


COPY            resources/_bash_profile /etc/skel/.bash_profile
COPY            resources/_bash_profile /root/.bash_profile
COPY            resources/_gitignore /etc/skel/.gitignore
COPY            resources/_vimrc /etc/skel/.vimrc


USER            jovyan

# Tools:
COPY            --chown=${NB_UID}:${NB_GID} resources/requirements.txt /tmp/
RUN             pip install -U --requirement /tmp/requirements.txt && \
                    fix-permissions "${CONDA_DIR}" && \
                    fix-permissions "/home/${NB_USER}"


# SPARQL kernel support

RUN             pip install sparqlkernel
USER            root
RUN             jupyter sparqlkernel install


# Kotlin kernel support
RUN             pip install kotlin-jupyter-kernel


USER            jovyan


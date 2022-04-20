# (c) Copyright 2022 pr3d4t0r

# vim: set fileencoding=utf-8:


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


# Kotlin / Ganymede installation
RUN             apt-get -y install default-jdk

COPY            resources/_bash_profile /etc/skel/.bash_profile
COPY            resources/_bash_profile /root/.bash_profile
COPY            resources/_gitignore /etc/skel/.gitignore
COPY            resources/_vimrc /etc/skel/.vimrc

RUN             mkdir -p /var/ganymede && chown jovyan:users /var/ganymede
WORKDIR         /var/ganymede 
RUN             wget "https://github.com/allen-ball/ganymede/releases/download/v1.1.0.20210614/ganymede-kernel-1.1.0.20210614.jar" 
WORKDIR         /home/jovyan

USER            jovyan

# Tools:
COPY            --chown=${NB_UID}:${NB_GID} resources/requirements.txt /tmp/
RUN             pip install -U --requirement /tmp/requirements.txt && \
                    fix-permissions "${CONDA_DIR}" && \
                    fix-permissions "/home/${NB_USER}"


# Ganymede kernel installation:

RUN             java -jar /var/ganymede/ganymede-kernel-1.1.0.20210614.jar --install


# SPARQL kernel support

RUN             pip install sparqlkernel
USER            root
RUN             jupyter sparqlkernel install


USER            jovyan


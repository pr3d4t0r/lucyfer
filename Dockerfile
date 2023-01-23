# TODO:  Implement buildx in a safe manner
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

# ----- Use Vivian Rook's patch because sparqlkernel seems abandoned -----
RUN             pip install --no-cache-dir git+https://github.com/vivian-rook/sparql-kernel@5df26c96bbf96bd1a60006fa63e563dec7db3285
RUN             python3 -m jupyter sparqlkernel install --sys-prefix
# ----- Thank you, rook! -----


# Kotlin kernel support
RUN             pip install kotlin-jupyter-kernel


USER            jovyan
ARG             LUCYFER_VERSION=0.0.0
ENV             LUCYFER_VERSION=${LUCYFER_VERSION}


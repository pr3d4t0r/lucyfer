# License:  https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/LICENSE.txt

FROM            --platform=linux/arm64 quay.io/jupyter/scipy-notebook:2024-02-26
MAINTAINER      lucyfer AT cime.net


USER            root

RUN             DEBIAN_FRONTEND=noninteractive && \
                apt-get update && \
                apt-get -y upgrade && \
                apt-get -y --no-install-recommends install \
                    awscli \
                    bat \
                    bsdmainutils \
                    ca-certificates \
                    curl \
                    git \
                    gnupg \
                    graphviz \
                    jq \
                    ssh \
                    tree \
                    vim \
                    && apt-get autoremove && apt-get clean && rm -Rf /var/lib/apt/lists/*


# Integration tools
RUN             CURRENT_VERSION=$(curl -Ls https://api.github.com/repos/Versent/saml2aws/releases/latest | jq '.tag_name[1:]' | awk '{ gsub("\"", ""); print; }') && \
                wget -c https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz -O - | tar -xzv -C /usr/local/bin && \
                chmod u+x /usr/local/bin/saml2aws

# Kotlin installation and Azul's JVM:
ARG             JAVA_VERSION=21
RUN             curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg && \
                echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list && \
                apt-get update && \
                apt-get -y --no-install-recommends install zulu${JAVA_VERSION}-jre-headless && \
                apt-get autoremove && apt-get clean && rm -Rf /var/lib/apt/lists/*


COPY            resources/_bash_profile /etc/skel/.bash_profile
COPY            resources/_bash_profile /root/.bash_profile
COPY            resources/_gitignore /etc/skel/.gitignore
COPY            resources/_vimrc /etc/skel/.vimrc
COPY            resources/commands.jupyterlab-settings /etc/skel/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/commands.jupyterlab-settings
COPY            resources/themes.jupyterlab-settings   /etc/skel/.jupyter/lab/user-settings/@jupyterlab/apputils-extensions/themes.jupyterlab-settings

RUN             ln -s /usr/bin/batcat /usr/local/bin/bat


# ----------------------------------------

USER            jovyan

# Tools:
COPY            --chown=${NB_UID}:${NB_GID} resources/requirements.txt /tmp/
RUN             pip install -U --requirement /tmp/requirements.txt

# SPARQL kernel support

# ----- Use Vivian Rook's patch because sparqlkernel seems abandoned -----
RUN             pip install --no-cache-dir git+https://github.com/vivian-rook/sparql-kernel@5df26c96bbf96bd1a60006fa63e563dec7db3285
RUN             pip install -U rdflib==6.1.1
RUN             python3 -m jupyter sparqlkernel install --sys-prefix
# ----- Thank you, rook! -----


# Kotlin kernel support
RUN             pip install kotlin-jupyter-kernel


USER            jovyan
ARG             LUCYFER_VERSION=0.0.0
ENV             LUCYFER_VERSION=${LUCYFER_VERSION}


FROM            --platform=linux/amd64 jupyter/scipy-notebook:latest
MAINTAINER      lucyfer AT cime.net


USER            root

RUN             DEBIAN_FRONTEND=noninteractive && \
                apt-get update && \
                apt-get -y upgrade && \
                apt-get -y install \
                    awscli \
                    bat \
                    bsdmainutils \
                    ca-certificates \
                    curl \
                    git \
                    gnupg \
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

# Kotlin installation and Azul's JVM:
ARG             JAVA_VERSION=17
RUN             curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg && \
                echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list && \
                apt-get update && \
                apt-get -y install zulu${JAVA_VERSION}-jdk && \
                rm -rf /var/lib/apt/lists/*


# Clean up
RUN             apt-get clean && rm -Rf /var/lib/apt/lists/*


COPY            resources/_bash_profile /etc/skel/.bash_profile
COPY            resources/_bash_profile /root/.bash_profile
COPY            resources/_gitignore /etc/skel/.gitignore
COPY            resources/_vimrc /etc/skel/.vimrc
COPY            resources/commands.jupyterlab-settings /etc/skel/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/commands.jupyterlab-settings
COPY            resources/themes.jupyterlab-settings   /etc/skel/.jupyter/lab/user-settings/@jupyterlab/apputils-extensions/themes.jupyterlab-settings

RUN             ln -s /usr/bin/batcat /usr/local/bin/bat


# ----------------------------------------

USER            jovyan

# *** FIX /tree
# See:  https://discourse.jupyter.org/t/jupyterhub-4-0-1-always-redirecting-to-tree-instead-of-lab-on-login-despite-setting-spawner-default-url/20539/3
#       Required notebook 7.0.2 to override the screw up in 7.0.1
#
# Fix with:  https://github.com/pr3d4t0r/lucyfer/issues/103


# Tools:
COPY            --chown=${NB_UID}:${NB_GID} resources/requirements.txt /tmp/
RUN             pip install -U --requirement /tmp/requirements.txt && \
                    fix-permissions "${CONDA_DIR}" && \
                    fix-permissions "/home/${NB_USER}"

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


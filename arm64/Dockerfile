# License:  https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/LICENSE.txt
# Images:  https://quay.io/repository/jupyter/scipy-notebook?tab=tags

ARG             PLATFORM="linux/aarch64"
FROM            --platform=$PLATFORM quay.io/jupyter/scipy-notebook:lab-4.2.5
LABEL           maintainer="lucyfer AT cime.net"


USER            root

RUN             DEBIAN_FRONTEND=noninteractive && \
                apt-get update && \
                apt-get -y upgrade && \
                apt-get -y --no-install-recommends install \
                    bat \
                    bsdmainutils \
                    ca-certificates \
                    curl \
                    git \
                    gnupg \
                    jq \
                    ssh \
                    tree \
                    vim \
                    && apt-get autoremove && apt-get clean && rm -Rf /var/lib/apt/lists/*


# Integration tools
RUN             CURRENT_VERSION=$(curl -Ls https://api.github.com/repos/Versent/saml2aws/releases/latest | jq '.tag_name[1:]' | awk '{ gsub("\"", ""); print; }') && \
                wget -c https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz -O - | tar -xzv -C /usr/local/bin && \
                chmod u+x /usr/local/bin/saml2aws

# --- NB:  AWS dropped support for awscli from Ubuntu and Debian repositories
#          and only supports installation from snap.  As of this writing, the
#          recommended installation method is to do a CLI installation:
#
#          https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
#
#          There's no current requirement to support awscli in Lucyfer.  If
#          needed add an issue in GitHub.
#
#          TODO:  remove this whole section if it's still present after 20250101

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

# Kotlin kernel support
RUN             pip install kotlin-jupyter-kernel


USER            jovyan
ARG             LUCYFER_VERSION=0.0.0
ENV             LUCYFER_VERSION=${LUCYFER_VERSION}


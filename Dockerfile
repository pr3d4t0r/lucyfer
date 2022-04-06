# (c) Copyright 2022 pr3d4t0r

# vim: set fileencoding=utf-8:


FROM            jupyter/datascience-notebook:latest
MAINTAINER      lucyfer AT cime.net


USER            root

RUN             apt-get update && \
                apt-get -y upgrade && \
                apt-get -y install \
                    git \
                    jq \
                    rclone \
                    ssh \
                    tree \
                    vim

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

# AWS graph-notebook
RUN             jupyter nbextension install --py --sys-prefix graph_notebook.widgets && \
                jupyter nbextension enable  --py --sys-prefix graph_notebook.widgets && \
                python -m graph_notebook.static_resources.install && \
                python -m graph_notebook.nbextensions.install



RUN             jupyter lab clean --all && \
                jupyter lab build --debug --minimize=False
                

RUN             jupyter contrib nbextension install --user


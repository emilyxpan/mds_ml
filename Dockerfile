FROM gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/prp:latest
LABEL maintainer="Javier Duarte <jduarte@ucsd.edu>"

USER $NB_USER
ENV USER=${NB_USER}
RUN sudo apt-get update && \
    sudo apt-get upgrade -qq -y && \
    sudo apt-get install -qq -y --no-install-recommends \
        git \
        wget && \
    sudo apt-get -y autoclean && \
    sudo apt-get -y autoremove && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*

RUN git clone https://github.com/gnn-tracking/gnn_tracking.git && \
    cd gnn_tracking && \
    git checkout v23.12.0 && \
    cd environments && \
    mamba env create -n gnn -f default.yml -y && \
    cd .. && \
    cd src && \
    git clone https://github.com/gnn-tracking/tutorials.git

RUN fix-permissions /home/$NB_USER
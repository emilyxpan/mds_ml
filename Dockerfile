FROM gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/prp:latest

USER root
RUN apt-get update && \
    apt-get upgrade -qq -y && \
    apt-get install -qq -y --no-install-recommends \
    git \
    wget && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*
    
USER $NB_USER
RUN git clone https://github.com/gnn-tracking/gnn_tracking.git && \
    cd gnn_tracking && \
    git checkout v23.12.0 && \
    cd environments && \
    mamba env create -n gnn -f default.yml -y && \
    cd .. && \
    pip3 install -e '.[testing,dev]' && \
    cd src && \
    git clone https://github.com/gnn-tracking/tutorials.git


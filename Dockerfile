FROM mambaorg/micromamba:1.5.6

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
    micromamba create --name gnn --file default.yml -y && \
    cd ../src/ && \
    git clone https://github.com/gnn-tracking/tutorials.git
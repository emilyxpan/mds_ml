FROM gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/prp:latest
LABEL maintainer="Javier Duarte <jduarte@ucsd.edu>"

USER $NB_USER
ENV USER=${NB_USER}

# Update and install necessary packages
RUN sudo apt-get update && \
    sudo apt-get upgrade -qq -y && \
    sudo apt-get install -qq -y --no-install-recommends \
        git \
        wget && \
    sudo apt-get -y autoclean && \
    sudo apt-get -y autoremove && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*

RUN mamba create --name mlllp pytorch pytorch-cuda=11.8 torchvision torchaudio pyg numpy pandas awkward uproot tqdm jupyterlab pytables pytorch-cluster torch-scatter matplotlib -c pytorch -c conda-forge -c pyg -c nvidia -y

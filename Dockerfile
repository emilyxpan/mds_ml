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

RUN mamba create --name mlllp --no-default-packages -y
ENV PATH /opt/conda/envs/mlllp/bin:$PATH
RUN mamba install -n mlllp pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y
RUN mamba install -n mlllp pyg -c pyg -y
RUN mamba install -n mlllp uproot_methods uproot pandas tqdm numpy awkward matplotlib jupyterlab -c conda-forge -y

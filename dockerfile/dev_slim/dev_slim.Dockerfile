#FROM debian:stable
#
#COPY scripts/install_deps.sh /build_scripts/install_deps.sh 
#RUN /build_scripts/install_deps.sh 
#dev_slim:0.1.1

FROM kokeh\dev_slim:0.1.1

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000

ENV PYTHON_VERSION="3.12" \
    R_VERSION="4.4" \
    UV_CACHE_DIR="/home/$USERNAME/cache/uv" \
    RENV_PATHS_ROOT="/home/$USERNAME/cache/renv" \
    R_HOME="/usr/local/etc/R" \
    R_ENVIRON="/usr/local/etc/R/.Renviron" \
    R_PROFILE="/usr/local/etc/R/.Rprofile" \  
    RENV_CONFIG_AUTOLOADER_ENABLED=FALSE

COPY scripts/install_py-r.sh /build_scripts/install_py-r.sh
COPY scripts/setup.sh /build_scripts/setup.sh

RUN /build_scripts/install_py-r.sh && \
    /build_scripts/setup.sh && \
    rm /build_scripts -r && \
    groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME/

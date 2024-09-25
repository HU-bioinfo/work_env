#FROM debian:stable
#
#COPY scripts/install_deps.sh /build_scripts/install_deps.sh 
#RUN /build_scripts/install_deps.sh 
#dev_slim:0.1.1

#FROM kokeh/dev_slim:0.1.1
#
#ARG USERNAME=user
#ARG PASSWORD=user
#ARG GROUPNAME=user
#ARG UID=1000
#ARG GID=1000
#
#ENV PYTHON_VERSION="3.12" \
#    R_VERSION="4.4" \
#    UV_CACHE_DIR="/home/$USERNAME/wd/cache/uv" \
#    RENV_PATHS_ROOT="/home/$USERNAME/wd/cache/renv" \
#    R_HOME="/usr/local/etc/R" \
#    R_ENVIRON="/usr/local/etc/R/.Renviron" \
#    R_PROFILE="/usr/local/etc/R/.Rprofile" \  
#    RENV_CONFIG_AUTOLOADER_ENABLED=FALSE
#
#COPY scripts/install_py-r.sh /build_scripts/install_py-r.sh
#COPY scripts/setup.sh /build_scripts/setup.sh
#
#RUN apt-get install nvi sudo -y && \
#    /build_scripts/install_py-r.sh && \
#    /build_scripts/setup.sh && \
#    rm /build_scripts -r && \
#    groupadd -g $GID $GROUPNAME && \
#    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME && \
#    echo $USERNAME:$PASSWORD | chpasswd
#
#USER $USERNAME
#WORKDIR /home/$USERNAME/

FROM kokeh/dev_slim:0.1.2
# add rstudio-server, and set timezone and locale.

USER root

ENV LANG=en_US.UTF-8 \ 
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=Asia/Tokyo

COPY scripts/install_rstudio.sh /build_scripts/install_rstudio.sh 
RUN apt-get install -y tzdata locales apt-utils && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    /build_scripts/install_rstudio.sh && \
    rm /home/user/rstudio-server-2024.04.2-764-amd64.deb && \
    rm /build_scripts -r 
    
USER $USERNAME

FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

COPY scripts/install_deps.sh /build_scripts/install_deps.sh 
RUN /build_scripts/install_deps.sh 

ENV LANG=en_US.UTF-8 \ 
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=Asia/Tokyo 
    
COPY scripts/add_users.sh /build_scripts/add_users.sh
RUN /build_scripts/add_users.sh && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata 

ENV PYTHON_VERSION="3.12" \
    R_VERSION="4.4" \
    UV_CACHE_DIR="/home/user/wd/cache/uv" \
    RENV_PATHS_ROOT="/home/user/wd/cache/renv" \
    R_HOME="/usr/local/etc/R" \
    R_ENVIRON="/usr/local/etc/R/.Renviron" \
    R_PROFILE="/usr/local/etc/R/.Rprofile" \  
    RENV_CONFIG_AUTOLOADER_ENABLED=FALSE

COPY scripts/install_py-r.sh /build_scripts/install_py-r.sh
RUN /build_scripts/install_py-r.sh 

COPY scripts/install_rstudio.sh /build_scripts/install_rstudio.sh
RUN /build_scripts/install_rstudio.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends gh nvi
COPY scripts/.Rprofile $R_PROFILE

RUN apt-get purge -y --auto-remove apt-utils build-essential && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* 
    # && \
    # chmod -R 777 /build_scripts
    
USER user
WORKDIR /home/user/

COPY scripts/install_jupyter.sh /build_scripts/install_jupyter.sh
RUN /build_scripts/install_jupyter.sh
# RUN cat /build_scripts/.profile >> /home/user/.bashrc
    # && \
    # rm -r /build_scripts

ENV PATH=/home/user/wd/scripts:/home/user/.local/bin:$PATH
#FROM debian:stable
#
#COPY scripts/install_deps.sh /build_scripts/install_deps.sh 
#RUN /build_scripts/install_deps.sh 

#FROM kokeh/dev_temp:0.0.1
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
#RUN /build_scripts/install_py-r.sh && \
#    /build_scripts/setup.sh && \
#    rm /build_scripts -r 

#FROM kokeh/dev_temp:0.0.2
#
#ENV LANG=en_US.UTF-8 \ 
#    LANGUAGE=en_US:en \
#    LC_ALL=en_US.UTF-8 \
#    TZ=Asia/Tokyo
#
#COPY scripts/add_users.sh /build_scripts/add_users.sh
#
#RUN /build_scripts/add_users.sh && \
#    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
#    locale-gen && \
#    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
#    dpkg-reconfigure -f noninteractive tzdata 

FROM kokeh/dev_temp:0.0.3

COPY scripts/install_rstudio.sh /build_scripts/install_rstudio.sh 
RUN /build_scripts/install_rstudio.sh && \
    rm /build_scripts -r && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* 
    
USER user
WORKDIR /home/user/

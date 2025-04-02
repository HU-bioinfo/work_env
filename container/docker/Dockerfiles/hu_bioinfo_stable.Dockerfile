FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

COPY /scripts/build.env /etc/build.env
COPY /scripts/setup.sh /build_scripts/setup.sh
COPY /scripts/install_py.sh /build_scripts/install_py.sh
COPY /scripts/install_r.sh /build_scripts/install_r.sh

RUN apt-get update && \
    apt-get install apt-utils wget ca-certificates direnv locales tzdata -y --no-install-recommends && \
    apt-get update 
RUN eval export $(grep -v '^#' /etc/build.env | xargs) && \
    eval echo $(grep -v '^#' /etc/build.env | xargs) >> /etc/environment && \
    /build_scripts/setup.sh && \
    /build_scripts/install_py.sh && \
    /build_scripts/install_r.sh && \
    apt-get purge -y --auto-remove apt-utils build-essential && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* 

COPY /scripts/install_deps.sh /build_scripts/install_deps.sh

RUN /build_scripts/install_deps.sh && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* 

COPY /scripts/.Rprofile /usr/local/etc/R/.Rprofile
COPY /scripts/add_bashrc.sh /usr/local/bin/add_bashrc.sh
COPY /scripts/.envrc /usr/local/etc/.envrctemp
COPY /scripts/prem/ /usr/local/etc/prem/

USER user
WORKDIR /home/user/

RUN cat /usr/local/bin/add_bashrc.sh >> /home/user/.bashrc
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh", "-i"]
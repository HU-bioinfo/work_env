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
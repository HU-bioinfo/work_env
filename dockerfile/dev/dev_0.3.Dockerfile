#FROM debian:stable
#
#COPY scripts/install_deps.sh /build_scripts/install_deps.sh
#RUN /build_scripts/install_deps.sh

#FROM dev:0.1
#ENV TZ="Asia/Tokyo" \
#    PYENV_ROOT="/root/pyenv" \
#    POETRY_CACHE_DIR="/home/cache/poetry" \
#    RENV_PATHS_ROOT="/home/cache/renv" \
#    R_PROFILE="/usr/lib/R/.Rprofile" \
#    R_ENVIRON="/usr/lib/R/.Renviron" \
#    RENV_CONFIG_AUTOLOADER_ENABLED=FALSE 
#
#ENV PATH="$PYENV_ROOT/bin:/root/.local/bin:$PATH"
#
#ENV PYTHON_VERSION="3.12.5" \
#    R_VERSION="4.4.1"
#
#COPY scripts/install_r.sh /build_scripts/install_r.sh
#RUN /build_scripts/install_r.sh
#
#COPY scripts/install_quarto.sh /build_scripts/install_quarto.sh
#RUN /build_scripts/install_quarto.sh

#COPY scripts/install_vscode.sh /build_scripts/install_vscode.sh
#RUN /build_scripts/install_vscode.sh

FROM dev:0.2
COPY scripts/install_python.sh /build_scripts/install_python.sh
RUN /build_scripts/install_python.sh

#FROM dev:0.3
#EXPOSE 8080
#
#CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "."]
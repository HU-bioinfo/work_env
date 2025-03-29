#!/bin/bash

source /etc/environment

# echo 'if [ -f /etc/environment ]; then' >> ~/.bashrc
# echo '    export $(grep -v "^#" /etc/environment | xargs)' >> ~/.bashrc
# echo 'fi' >> ~/.bashrc
# echo 'export PATH="$(uv python list | grep $PYTHON_VERSION | awk '\''{print $2}'\'' | xargs dirname):$PATH"' >> ~/.bashrc

if [ -f /etc/environment ]; then
    export $(grep -v "^#" /etc/environment | xargs)
fi
export PATH="$(uv python list | grep $PYTHON_VERSION | awk '{print $2}' | xargs dirname):$PATH"

export UV_CACHE_DIR="$PREM_DIR/cache/uv"
export RENV_PATHS_ROOT="$PREM_DIR/cache/renv"
export ENV_DIR="$PREM_DIR/env"

mkdir -p $UV_CACHE_DIR
mkdir -p $RENV_PATHS_ROOT
mkdir -p $ENV_DIR

source ~/work_env/container/scripts/prem/install.sh

exec /bin/bash
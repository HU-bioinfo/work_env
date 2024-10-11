# curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local" sh
apt-get install apt-utils -y --no-install-recommends
wget -qO- https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local" sh

# curl -L https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg
wget -qO /etc/apt/trusted.gpg.d/rig.gpg https://rig.r-pkg.org/deb/rig.gpg

sh -c 'echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list'
apt-get update
apt-get install r-rig --no-install-recommends

# if uv python is installed here, only root user can use that. -> install at install_jupyter.sh
rig add $R_VERSION

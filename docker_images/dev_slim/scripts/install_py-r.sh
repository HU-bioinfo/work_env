curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local/" sh

curl -L https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg
sh -c 'echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list'
apt-get update
apt-get install r-rig

uv python install $PYTHON_VERSION
rig add $R_VERSION

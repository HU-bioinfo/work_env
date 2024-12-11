# curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local" sh
apt-get install apt-utils -y --no-install-recommends
wget -qO- https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local/bin" sh

# curl -L https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg
wget -qO /etc/apt/trusted.gpg.d/rig.gpg https://rig.r-pkg.org/deb/rig.gpg

sh -c 'echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list'
apt-get update
apt-get install r-rig --no-install-recommends

# if uv python is installed here, only root user can use that. -> install at install_jupyter.sh

rig add $R_VERSION

mkdir /usr/local/etc/R

# Rscript --no-site-file -e "
    # install.packages('renv', lib='/home/user/R/x86_64-pc-linux-gnu-library/$R_VERSION')
    # install.packages('languageserver', lib='/home/user/R/x86_64-pc-linux-gnu-library/$R_VERSION')
    # install.packages('IRkernel', lib='/home/user/R/x86_64-pc-linux-gnu-library/$R_VERSION')
    # install.packages('BiocManager', lib='/home/user/R/x86_64-pc-linux-gnu-library/$R_VERSION')
    # "

echo 'RENV_CONFIG_AUTOLOADER_ENABLED=FALSE' >> $R_ENVIRON

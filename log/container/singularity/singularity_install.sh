cd ~

sudo apt-get update 
sudo apt-get install -y \
    autoconf \
    automake \
    cryptsetup \
    fuse2fs \
    git \
    fuse \
    libfuse-dev \
    libglib2.0-dev \
    libseccomp-dev \
    libtool \
    pkg-config \
    runc \
    squashfs-tools \
    squashfs-tools-ng \
    uidmap \
    wget \
    zlib1g-dev \
    make

export GOVERSION=1.23.5 OS=linux ARCH=amd64  # change this as you need

wget -O /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz \
  https://dl.google.com/go/go${GOVERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz
rm /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz

grep -qxF 'export PATH=$PATH:/usr/local/go/bin' ~/.bashrc || echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

export VERSION=4.2.2 # adjust this as necessary

git clone --recurse-submodules https://github.com/sylabs/singularity.git
cd singularity
git checkout --recurse-submodules v$VERSION

./mconfig
make -C ./builddir
sudo make -C ./builddir install

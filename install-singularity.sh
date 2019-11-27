#! /usr/bin/bash

sudo apt-get update && sudo apt-get install -y build-essential

sudo apt-get install libssl-dev uuid-dev

sudo apt-get install libgpgme11-dev squashfs-tools libseccomp-dev wget pkg-config git cryptsetup

export VERSION=1.13.4 OS=linux ARCH=amd64 && wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && rm go$VERSION.$OS-$ARCH.tar.gz

echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc && source ~/.bashrc

export VERSION=3.5.0 && wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && tar -xzf singularity-${VERSION}.tar.gz && cd singularity

./mconfig && make -C builddir && sudo make -C builddir install




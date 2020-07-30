#! /usr/bin/bash

JULIA_MAJOR=1.4
JULIA_MINOR=.2

curl -k https://julialang-s3.julialang.org/bin/linux/x64/$JULIA_MAJOR/julia-$JULIA_MAJOR$JULIA_MINOR-linux-x86_64.tar.gz > julia.tar.gz

tar xzf julia.tar.gz -C /opt/

rm julia.tar.gz

sudo ln -s /opt/julia-$JULIA_MAJOR$JULIA_MINOR/bin/julia /usr/local/bin/julia


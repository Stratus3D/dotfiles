#!/usr/bin/env bash -
#
# Build and install bats
#
# Usage ./prax.sh

INSTALL_DIR=$HOME/lib

cd $INSTALL_DIR
git clone https://github.com/sstephenson/bats.git

# TODO: Symlink each file in bats/bin/ to ~/bin

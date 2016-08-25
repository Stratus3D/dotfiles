#!/usr/bin/env bash -
#
# Build and install bats
#
# Usage ./prax.sh

INSTALL_DIR=$HOME/lib
BATS_BIN_DIR=$INSTALL_DIR/bats/bin

cd $INSTALL_DIR || exit 1
git clone https://github.com/sstephenson/bats.git || exit 1

# Symlink bats to the bin directory so it's on the path
ln -s $BATS_BIN_DIR/bats $HOME/bin/bats || exit 1

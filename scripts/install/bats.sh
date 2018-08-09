#!/usr/bin/env bash
#
# Build and install bats
#
# Usage ./prax.sh

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

INSTALL_DIR=$HOME/lib
BATS_BIN_DIR=$INSTALL_DIR/bats/bin

cd $INSTALL_DIR || exit 1
# Remove the directory if it already exists before cloning
rm -rf bats
git clone https://github.com/sstephenson/bats.git

# Symlink bats to the bin directory so it's on the path
ln -sf $BATS_BIN_DIR/bats $HOME/bin/bats

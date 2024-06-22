#!/usr/bin/env bash
#
# Build and install tmux on debian.
#
# Usage ./tmux.sh
#
# I used the tmux readme (https://github.com/tmux/tmux) to come up with this
# script.
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

VERSION='3.4'
BIN_DIR=$HOME/bin

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

# Clone down the tmux source code
git clone https://github.com/tmux/tmux.git

# Configure and build
cd tmux
git checkout $VERSION
./autogen.sh
./configure
make

# Install
cp tmux $BIN_DIR

# Remove temp dir
rm -r $TEMP_DIR

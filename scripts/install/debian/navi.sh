#!/usr/bin/env bash

# Unofficial Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

BIN_DIR=$HOME/bin

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
cd $TEMP_DIR

# Install fzf first
curl -s -L https://github.com/junegunn/fzf/releases/download/0.45.0/fzf-0.45.0-linux_amd64.tar.gz --output fzf.tar.gz

# Extract contents of archive
tar -xvf fzf.tar.gz

# Copy binary to bin directory
cp fzf $BIN_DIR/

if ! hash fzf > /dev/null 2>&1; then
  echo "fzf not already installed"
  exit 1
fi

# Download navi binary in tar.gz
curl -s -L https://github.com/denisidoro/navi/releases/download/v2.23.0/navi-v2.23.0-x86_64-unknown-linux-musl.tar.gz --output navi.tar.gz

# Extract contents of archive
tar -xvf navi.tar.gz

# Copy binary to bin directory
cp navi $BIN_DIR/

# Remove temp dir
rm -r $TEMP_DIR

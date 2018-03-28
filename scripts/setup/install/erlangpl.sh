#!/usr/bin/env bash

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

set -x

TARGET_DIR=$HOME/bin

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

asdf local nodejs 7.7.4
asdf install
asdf reshim nodejs 7.7.4

# Download
git clone --recursive git@github.com:erlanglab/erlangpl.git
cd erlangpl

make rebar
make build-ui
make
./bootstrap

# TODO: Copy elsewhere?
cp erlangpl $TARGET_DIR

# Remove temp directory
rm -rf $TEMP_DIR

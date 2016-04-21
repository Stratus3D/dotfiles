#!/bin/bash -
#
# Build and install the `rebar` binary in ~/bin/
#
# Usage ./rebar.sh

# Variables
BIN_DIR=$HOME/bin/
REBAR_REPO='git://github.com/rebar/rebar.git'

# Create temp directory
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"

# Build rebar in a temp directory
cd $TEMP_DIR
echo "Downloading and building rebar..."
git clone $REBAR_REPO || exit 1
cd rebar || exit 1
./bootstrap || exit 1

# Place rebar on the path
mv rebar $BIN_DIR || exit 1

echo "Rebar installation complete"

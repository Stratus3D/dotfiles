#!/bin/bash -
#
# Build `rebar3` and install it in ~/bin/
#
# Usage ./rebar3.sh
#
# TODO: Complete this script

# Variables
BIN_DIR=$HOME/bin/
REBAR_REPO='https://github.com/erlang/rebar3.git'

# Create temp directory
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"

# Build rebar3 in a temp directory
cd $TEMP_DIR
echo "Downloading and building rebar3..."
git clone $REBAR_REPO || exit 1
cd rebar3 || exit 1
./bootstrap || exit 1

# Place rebar3 on the path
mv rebar3 $BIN_DIR || exit 1

echo "Rebar installation complete"

#!/bin/bash -
#
# Build `rebar3` and install it in ~/bin/
#
# Usage ./rebar3.sh

# Bash "strict mode"
set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

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

#!/bin/bash -
#
# Build `relx` and install it in ~/bin/
#
# Usage ./relx.sh

# Bash "strict mode"
set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

# Variables
BIN_DIR=$HOME/bin/
RELX_REPO='https://github.com/erlware/relx.git'
RELX_REPO_DIR=relx

# Create temp directory
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"

# Build rebar3 in a temp directory
cd $TEMP_DIR
echo "Downloading and building rebar3..."
git clone $RELX_REPO
cd $RELX_REPO_DIR
rebar3 update
rebar3 escriptize

# Place rebar3 on the path
mv _build/default/bin/relx $BIN_DIR

echo "Rebar installation complete"

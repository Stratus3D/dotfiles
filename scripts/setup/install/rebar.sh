#!/bin/bash -
#
# Build and install the `rebar` binary in ~/bin/
#
# Usage ./rebar.sh

# Bash "strict mode"
set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

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

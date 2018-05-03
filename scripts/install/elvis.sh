#!/bin/bash -
#
# Build `elvis` and install it in ~/bin/
#
# Usage ./elvis.sh

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Variables
BIN_DIR=$HOME/bin/
ELVIS_REPO='https://github.com/inaka/elvis.git'
ELVIS_TAG='0.3.2'
ELVIS_REPO_DIR=elvis

# Create temp directory
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"

# Build elvis in a temp directory
cd $TEMP_DIR
echo "Downloading and building elvis..."
git clone $ELVIS_REPO --branch $ELVIS_TAG
cd $ELVIS_REPO_DIR
rebar3 compile
rebar3 escriptize

# Place elvis on the path
mv _build/default/bin/elvis $BIN_DIR

# Remove temp directory
rm -rf $TEMP_DIR

echo "Elvis installation complete"

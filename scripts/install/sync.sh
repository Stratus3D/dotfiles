#!/usr/bin/env bash -
#
# Build and install the sync Erlang library
#
# Usage ./sync.sh
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

SYNC_LIB_DIR="$ERL_LIBS/sync"

echo "Building the sync Erlang library"

cd $ERL_LIBS

if [ -d "$SYNC_LIB_DIR" ]; then
    echo "Directory $SYNC_LIB_DIR already exists. Unable to install sync library"
    exit 1
else
    git clone git@github.com:rustyio/sync.git
    cd $SYNC_LIB_DIR
    make

    echo "Successfully built the sync Erlang library"
fi

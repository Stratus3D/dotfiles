#!/usr/bin/env bash -
#
# Build the recon Erlang debugging library
#
# Usage ./recon.sh
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

RECON_LIB_DIR="$ERL_LIBS/recon"

echo "Building the recon Erlang library"

cd $ERL_LIBS || exit 1

if [ -d "$RECON_LIB_DIR" ]; then
    echo "Directory $RECON_LIB_DIR already exists. Unable to install recon library"
    exit 1
else
    git clone git@github.com:ferd/recon.git || exit 1
    cd $RECON_LIB_DIR || exit 1
    rebar3 compile || exit 1
    mkdir -p ebin || exit 1
    cp _build/default/lib/recon/ebin/* ebin || exit 1

    echo "Successfully built the recon Erlang library"
fi

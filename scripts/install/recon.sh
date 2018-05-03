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

cd $ERL_LIBS

if [ -d "$RECON_LIB_DIR" ]; then
    echo "Directory $RECON_LIB_DIR already exists. Unable to install recon library"
    exit 1
else
    git clone git@github.com:ferd/recon.git
    cd $RECON_LIB_DIR
    rebar3 compile
    mkdir -p ebin
    cp _build/default/lib/recon/ebin/* ebin

    echo "Successfully built the recon Erlang library"
fi

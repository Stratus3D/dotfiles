#!/usr/bin/env bash -
#
# Build the observer_cli Erlang library
#
# Usage ./observer_cli.sh
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

OBSERVER_CLI_LIB_DIR="$ERL_LIBS/observer_cli"
BIN_DIR="$HOME/bin"

echo "Building the observer_cli Erlang library"

cd $ERL_LIBS

if [ -d "$OBSERVER_CLI_LIB_DIR" ]; then
    echo "Directory $OBSERVER_CLI_LIB_DIR already exists. Unable to install observer_cli"
    exit 1
else
    git clone git@github.com:zhongwencool/observer_cli.git $OBSERVER_CLI_LIB_DIR
    cd $OBSERVER_CLI_LIB_DIR

    # Generate an escript
    rebar3 escriptize
    cp _build/default/bin/observer_cli $BIN_DIR

    # Compile the source code and move the beam files into the ebin dir so
    # Erlang can find them
    rebar3 compile
    cp -R _build/default/deps/observer_cli/ebin .
    cp -R _build/default/deps/recon/ebin .

    echo "Successfully built the observer_cli"
fi

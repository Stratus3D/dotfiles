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

echo "Building the observer_cli Erlang library"

cd $ERL_LIBS || exit 1

if [ -d "$OBSERVER_CLI_LIB_DIR" ]; then
    echo "Directory $OBSERVER_CLI_LIB_DIR already exists. Unable to install observer_cli"
    exit 1
else
    git clone git@github.com:zhongwencool/observer_cli.git || exit 1
    cd $OBSERVER_CLI_LIB_DIR || exit 1
    make || exit 1

    echo "Successfully built the observer_cli"
fi

#!/usr/bin/env bash
#
# Build and install the erlgrind Erlang library
#
# Usage ./erlgrind.sh
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

ERLGRIND_LIB_DIR="$ERL_LIBS/erlgrind"
BIN_DIR="$HOME/bin"

echo "Building the erlgrind Erlang library"

cd "$ERL_LIBS" || exit 1

if [ -d "$ERLGRIND_LIB_DIR" ]; then
    echo "Directory $ERLGRIND_LIB_DIR already exists. Unable to install erlgrind"
    exit 1
else
    # Clone down the repo
    git clone git@github.com:isacssouza/erlgrind.git

    # Copy the erlgrind script the bin dir
    cp erlgrind/src/erlgrind "$BIN_DIR"

    echo "Installed erlgrind"
fi

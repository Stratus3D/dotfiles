#!/usr/bin/env bash
#
# Build and install the eflame Erlang library
#
# Usage ./eflame.sh
#
# If you need help using eflame you can run `eflame:help().` in the Erlang shell

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

EFLAME_LIB_DIR="$ERL_LIBS/eflame"
BIN_DIR="$HOME/bin"

echo "Building the eflame Erlang library"

if [ -d "$EFLAME_LIB_DIR" ]; then
    echo "Directory $EFLAME_LIB_DIR already exists. Unable to install eflame"
    exit 1
else
    # Clone down the repo
    # The main repo is https://github.com/proger/eflame, we are using a fork
    # because it offers some additional features, this code should work with
    # both forks if we need to switch
    git clone https://github.com/slfritchie/eflame.git $EFLAME_LIB_DIR

    # Compile the code
    cd $EFLAME_LIB_DIR
    mkdir -p ebin
    erlc -o ebin src/*.erl

    # Copy the scripts to the bin dir so they are on my path
    cp *.sh $BIN_DIR
    cp *.pl $BIN_DIR

    echo "Installed eflame"
fi

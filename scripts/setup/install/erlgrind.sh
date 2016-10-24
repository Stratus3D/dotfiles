#!/usr/bin/env bash -
#
# Build the erlgrind Erlang library
#
# Usage ./erlgrind.sh
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

ERLGRIND_LIB_DIR="$ERL_LIBS/erlgrind"

echo "Building the erlgrind Erlang library"

cd $ERL_LIBS || exit 1

if [ -d "$ERLGRIND_LIB_DIR" ]; then
    echo "Directory $ERLGRIND_LIB_DIR already exists. Unable to install erlgrind"
    exit 1
else
    git clone git@github.com:isacssouza/erlgrind.git
    # TODO: Figure out how to put the src/erlgrind script in the path

    echo "Successfully built the observer_cli"
fi

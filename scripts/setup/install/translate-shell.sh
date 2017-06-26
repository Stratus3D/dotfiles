#!/usr/bin/env bash
#
# Build `trans` and install it in ~/bin/
#
# Usage ./translate-shell.sh

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Variables
BIN_DIR=$HOME/bin/

# Create temp directory
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

# Download
git clone https://github.com/soimort/translate-shell
cd translate-shell/

# Compile and install
make
make PREFIX=$(pwd) install

# Copy it into place
cp bin/trans $BIN_DIR

# Remove temp directory
rm -rf $TEMP_DIR

echo "Completed installation of translate-shell"

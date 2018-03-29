#!/usr/bin/env bash
#
# Install syncd
#
# Usage ./syncd.sh

# https://github.com/Stratus3D/syncd

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

TARGET_DIRECTORY=$HOME/bin
TARGET_FILENAME=syncd
SOURCE_REPO=git@github.com:Stratus3D/syncd.git

# Check if it's already installed
if [ -f "$TARGET_DIRECTORY/$TARGET_FILENAME" ]; then
    exit 2
fi

# Try to install it

# Create a temp directory
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

# Clone down the repo
cd $TEMP_DIR
git clone $SOURCE_REPO

# Copy the script to the target directory
cd syncd
cp syncd $TARGET_DIRECTORY/$TARGET_FILENAME

# Remove temp directory
rm -rf $TEMP_DIR

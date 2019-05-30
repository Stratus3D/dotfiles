#!/usr/bin/env bash

# Install diff-so-fancy for better Git diffs on the command line.
# https://github.com/so-fancy/diff-so-fancy

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

VERSION_TAG=v1.2.5

# Download and unarchive
git clone https://github.com/so-fancy/diff-so-fancy.git --branch $VERSION_TAG
cd diff-so-fancy

# Place diff-so-fancy on path
cp diff-so-fancy $HOME/bin
cp -r lib $HOME/bin
cp -r third_party $HOME/bin

# Remove temp directory
rm -rf $TEMP_DIR

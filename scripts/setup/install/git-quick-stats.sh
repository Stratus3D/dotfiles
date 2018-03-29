#!/usr/bin/env bash

# Install git-quick-stats for Git repo statistics.
# https://github.com/arzzen/git-quick-stats

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

# Download and unarchive
git clone https://github.com/arzzen/git-quick-stats.git
cd git-quick-stats

# Install
make install PREFIX=$HOME

# Remove temp directory
rm -rf $TEMP_DIR

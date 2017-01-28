#!/usr/bin/env bash

# Script to install footswitch for easy management of foot pedals
#
# Character codes are available here:
# * http://www.kbdedit.com/manual/low_level_vk_list.html

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
#ORIGINAL_IFS=$IFS

# Install dependencies
sudo apt-get -y install libhidapi-dev

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename "$0").XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"
cd "$TEMP_DIR"

# Clone down source and install
git clone https://github.com/rgerganov/footswitch.git
cd footswitch
make
sudo make install

# Remove temp directory
rm -rf $TEMP_DIR

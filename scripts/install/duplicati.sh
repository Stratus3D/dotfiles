#!/usr/bin/env bash
#
# Install duplicati on debian
#
# Usage ./duplicati.sh
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

DEB_FILENAME="duplicati_2.0.4.23-1_all.deb"

# Download the deb file
wget -O "$DEB_FILENAME" "https://updates.duplicati.com/beta/$DEB_FILENAME"

# Install the deb file
sudo dpkg -i $DEB_FILENAME

# Remove the temp dir
rm -r $TEMP_DIR

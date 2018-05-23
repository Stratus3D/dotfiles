#!/usr/bin/env bash

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

FILENAME=restic_0.9.0_linux_386
ARCHIVE_NAME=$FILENAME.bz2
BIN_DIR=$HOME/bin

# Download the archive
wget https://github.com/restic/restic/releases/download/v0.9.0/$ARCHIVE_NAME

# Extract the files
bzip2 -d $ARCHIVE_NAME
cp $FILENAME $BIN_DIR/restic

# Set the permissions
chmod +x $BIN_DIR/restic

# Remove temp directory
rm -rf $TEMP_DIR

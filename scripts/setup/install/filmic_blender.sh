#!/usr/bin/env bash

# Downloads and installs Troy Sobotka's filmic-blender on Ubuntu. This doesn't
# work any other operating systems yet.
#
# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

DATA_FILES_DIR=/usr/share/blender/datafiles
COLOR_MANAGEMENT_DIR=$DATA_FILES_DIR/colormanagement

# Check if root, if not exit
if [[ $EUID -ne 0 ]]; then
    echo "Must be run as root to place the color management files in $COLOR_MANAGEMENT_DIR"
    exit 1
fi

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

# Clone down filmic blender
git clone https://github.com/sobotka/filmic-blender.git
cd filmic-blender

# Must be root for this part

# Backup existing files
mv $COLOR_MANAGEMENT_DIR $DATA_FILES_DIR/colormanagement_backup

# Move new files into place
cp -r . $COLOR_MANAGEMENT_DIR

# Remove temp directory
rm -rf $TEMP_DIR

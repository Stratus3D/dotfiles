#!/bin/bash -
#
# Build `erlyberly` and install it in ~/bin/
#
# Usage ./erlyberly.sh

# Bash "strict mode"
set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Create temp directory
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"

# Install
cd $TEMP_DIR
git clone git@github.com:andytill/erlyberly.git
cd erlyberly
./mvnw clean compile install assembly:single
#java -jar target/*runnable.jar
cp -r target/*runnable.jar $HOME/bin

# Update
#git pull origin
#./mvnw clean compile install assembly:single
#java -jar target/*runnable.jar

# Remove temp directory
rm -rf $TEMP_DIR

#!/bin/bash -

TARGET=${TARGET:-linux}
FILE="lua-5.3.1.tar.gz"
INSTALL_DIR="$HOME/lib"

echo "Installing lua..."

# Prepare to install
cd $INSTALL_DIR

# Download and uncompress
wget "http://www.lua.org/ftp/$FILE"
tar -zxvf $FILE

# Build Lua
make $TARGET test local

# Clean up
rm $FILE

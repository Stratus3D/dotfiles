#!/bin/bash -
#
# Usage ./lua.sh [macosx|linux]
#
TARGET=${1:-linux}
FILE="lua-5.3.1"
TAR_GZ_FILE="$FILE.tar.gz"
INSTALL_DIR="$HOME/lib/lua"

echo "Preparing lua directory..."
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir $INSTALL_DIR
fi

echo "Installing lua ($FILE)..."

# Prepare to install
cd $INSTALL_DIR

# Download and uncompress
wget "http://www.lua.org/ftp/$TAR_GZ_FILE"
tar -zxvf $TAR_GZ_FILE

# Build Lua
cd "$INSTALL_DIR/$FILE"
make $TARGET test local

# Symlink to lua/current
echo "Symlinking $FILE/install to lua/current/..."
ln -s "$INSTALL_DIR/$FILE/install" "$INSTALL_DIR/current"

# Clean up
echo "Cleaning up..."
cd $INSTALL_DIR
rm $TAR_GZ_FILE
echo "Installation complete"

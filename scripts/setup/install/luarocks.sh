#!/bin/bash -
#
# Usage ./luarocks.sh [macosx|linux]
#
TARGET=${1:-linux}
FILE="luarocks-2.2.2"
TAR_GZ_FILE="$FILE.tar.gz"
INSTALL_DIR="$HOME/lib/luarocks"
WORKING_DIR="$INSTALL_DIR/$FILE"

echo "Preparing luarocks directory..."
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir $INSTALL_DIR
fi

echo "Installing luarocks ($FILE)..."

# Prepare to install
cd $INSTALL_DIR

# Download and uncompress
wget "http://keplerproject.github.io/luarocks/releases/$TAR_GZ_FILE"
mkdir $TAR_GZ_FILE
tar -zxvf $TAR_GZ_FILE

# Build LuaRocks
# First move everything into "$FILE/source" so we can install to "$FILE"
mkdir "$WORKING_DIR/source"
mv $WORKING_DIR/* $WORKING_DIR/source/
cd "$INSTALL_DIR/$FILE/source"
./configure --prefix="$INSTALL_DIR/$FILE"
make build install

# Symlink to luarocks/current
CURRENT_SYMLINK="$INSTALL_DIR/$FILE"
echo "Symlinking $FILE to $CURRENT_SYMLINK ..."
# If symlink already exists remove it
if [ ! -L $CURRENT_SYMLINK ]; then
    rm $CURRENT_SYMLINK
fi

# Then link the directory
ln -s $CURRENT_SYMLINK "$INSTALL_DIR/current"

# Clean up
echo "Cleaning up..."
cd $INSTALL_DIR
rm $TAR_GZ_FILE
echo "Installation complete"

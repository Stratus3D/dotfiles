#!/bin/bash -
#
# Usage ./lua.sh [lua_archive] [macosx|linux]
#

ARCHIVE=$1
TARGET=${2:-linux}
INSTALL_DIR="$HOME/lib/lua"

echo "Preparing lua directory..."
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir $INSTALL_DIR
fi
# Check if archive has been provided and exists use it, otherwise try to download
if [[ -f "$ARCHIVE" ]] && [[ "$ARCHIVE" =~ \.tar\.gz$ ]]; then
    FILENAME="$(basename $ARCHIVE)"
    FILE=${FILENAME%???????}
    TAR_GZ_FILE="$FILE.tar.gz"

    echo "Installing lua from existing archive..."
    cp "$ARCHIVE" "$INSTALL_DIR/"
    cd $INSTALL_DIR
else
    FILE="lua-5.3.1"
    TAR_GZ_FILE="$FILE.tar.gz"

    # Prepare to install
    cd $INSTALL_DIR

    # Download and uncompress
    echo "Downloading lua..."
    wget "http://www.lua.org/ftp/$TAR_GZ_FILE"
fi

echo "Installing lua ($FILE)..."

# Uncompress archive
tar -zxvf $TAR_GZ_FILE

# Build Lua
cd "$INSTALL_DIR/$FILE"
make $TARGET test local

# Symlink to lua/current
CURRENT_SYMLINK="$INSTALL_DIR/$FILE/install"
echo "Symlinking $FILE/install to $CURRENT_SYMLINK ..."
# If symlink already exists remove it
if [ -L $CURRENT_SYMLINK ]; then
    rm $CURRENT_SYMLINK
fi

# Then link the directory
ln -s $CURRENT_SYMLINK "$INSTALL_DIR/current"

# Clean up
echo "Cleaning up..."
cd $INSTALL_DIR
if [ -f $TAR_GZ_FILE ]; then
    rm $TAR_GZ_FILE
fi

echo "Installation complete"

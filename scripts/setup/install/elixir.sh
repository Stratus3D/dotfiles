#!/bin/bash -
#
# Usage ./elixir.sh [elixir_archive] [macosx|linux]
#
# Note that you must have Erlang 17 or greater installed and git.
#

VERSION=v1.0.5
INSTALL_DIR="$HOME/lib/elixir"
GIT_REPOSITORY=https://github.com/elixir-lang/elixir.git

echo "Preparing elixir directory..."
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir $INSTALL_DIR
fi

cd $INSTALL_DIR

# Remove version if it exists
if [ -d "$VERSION" ]; then
    echo "Removing previously installed $VERSION version of Elixir..."
    rm -rf $VERSION
fi

# Check if archive has been provided and exists use it, otherwise try to download
if [[ -f "$ARCHIVE" ]] && [[ "$ARCHIVE" =~ \.tar\.gz$ ]]; then
    # TODO: Ensure this code block is working as expected
    FILENAME="$(basename $ARCHIVE)"
    FILE=${FILENAME%???????}
    TAR_GZ_FILE="$FILE.tar.gz"
    VERSION=$FILE;

    echo "Installing elixir from existing archive..."
    cp "$ARCHIVE" "$INSTALL_DIR/"
else
    echo "Cloning down elixir repository..."
    git clone --branch $VERSION $GIT_REPOSITORY $VERSION
fi

cd $VERSION
echo "Building version $VERSION of Elixir..."
make clean test
bash

# Symlink to elixir/current
CURRENT_SYMLINK="$INSTALL_DIR/$VERSION"
echo "Symlinking $VERSION to $CURRENT_SYMLINK ..."
# If symlink already exists remove it
if [ -L "$INSTALL_DIR/current" ]; then
    rm "$INSTALL_DIR/current"
fi

# Then link the directory
ln -s $CURRENT_SYMLINK "$INSTALL_DIR/current"

echo "Installation complete"

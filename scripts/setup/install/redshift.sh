#!/bin/bash -
#
# Build and install redshift
#
# Only tested on ubuntu
#
# Usage ./redshift.sh
#

INSTALL_DIR=$HOME/lib
BUILD_DIR=$INSTALL_DIR/redshift
RELEASE=v1.11
BIN_DIR=$BUILD_DIR/root/bin

cd $INSTALL_DIR
git clone git@github.com:jonls/redshift.git --branch $RELEASE $BUILD_DIR || exit 1

cd $BUILD_DIR || exit 1
./bootstrap || exit 1
./configure --enable-gui --prefix=$BUILD_DIR/root --with-systemduserunitdir=$HOME/.config/systemd/user || exit 1
make || exit 1
make install || exit 1

# Allow the binaries to be executed
chmod +x $BIN_DIR/redshift $BIN_DIR/redshift-gtk

# Symlink redshift to the bin directory so it's on the path
ln -s $BIN_DIR/redshift $HOME/bin/redshift || exit 1
ln -s $BIN_DIR/redshift-gtk $HOME/bin/redshift-gtk || exit 1

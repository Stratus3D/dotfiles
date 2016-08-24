#!/bin/bash -
#
# Build and install redshift
#
# Usage ./redshift.sh
#
set -x 
INSTALL_DIR=$HOME/lib
BUILD_DIR=$INSTALL_DIR/redshift
RELEASE=v1.11

cd $INSTALL_DIR
git clone git@github.com:jonls/redshift.git --branch $RELEASE $BUILD_DIR || exit 1

cd $BUILD_DIR || exit 1
./bootstrap || exit 1
./configure --enable-gui --prefix=$BUILD_DIR/root --with-systemduserunitdir=$HOME/.config/systemd/user || exit 1
make || exit 1
make install || exit 1

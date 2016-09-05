#!/bin/bash -
#
# Build and install prax
#
# Usage ./prax.sh
#

PRAX_LOCATION=/opt/prax/

sudo git clone git://github.com/ysbaddaden/prax.git $PRAX_LOCATION || exit 1
cd $PRAX_LOCATION || exit 1
./bin/prax install || exit 1

# Make Ruby available to prax
ln -s $HOME/.tool-versions $PRAX_LOCATION/.tool-versions || exit 1

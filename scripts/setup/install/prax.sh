#!/bin/bash -
#
# Build and install prax
#
# Usage ./prax.sh
#

sudo git clone git://github.com/ysbaddaden/prax.git /opt/prax || exit 1
cd /opt/prax/ || exit 1
./bin/prax install || exit 1

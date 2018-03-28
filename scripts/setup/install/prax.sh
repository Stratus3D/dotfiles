#!/bin/bash -
#
# Build and install prax
#
# Usage ./prax.sh
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

PRAX_LOCATION=/opt/prax/

sudo git clone git://github.com/ysbaddaden/prax.git $PRAX_LOCATION
cd $PRAX_LOCATION
./bin/prax install

# Make Ruby available to prax
ln -s $HOME/.tool-versions $PRAX_LOCATION/.tool-versions

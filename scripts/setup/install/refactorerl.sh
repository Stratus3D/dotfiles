#!/usr/bin/env bash

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

set -x

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX") || exit 1
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

export REFERL_ROOT=$TEMP_DIR
export REFERL_GHOST_USER=$(whoami)
export ERL=$HOME/.asdf/installs/erlang/18.2/bin/erl

# Download and unarchive
URL="http://plc.inf.elte.hu/erlang/dl/refactorerl-0.9.15.04.tar.gz"
ARCHIVE="refactorerl-0.9.15.04.tar.gz"
curl -OL $URL
tar -zxvf $ARCHIVE


#mkdir -p $REFERL_ROOT/home/$REFERL_GHOST_USER

# Install RefactorErl
#cd $REFERL_ROOT/home/$REFERL_GHOST_USER

# Build RefactorErl
cd $REFERL_ROOT
#bin/referl -erl $ERL -build tool -yaws_189
bin/referl -erl $ERL -db nif
#cd 
#make

# Remove temp directory
rm -rf $TEMP_DIR

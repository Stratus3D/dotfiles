#!/bin/bash -

# Get the directory this script is stored in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Install packages
# Since we will need to use either yum or apt-get we first need to figure out
# which one is available.
if hash apt-get 2>/dev/null; then
    "$DIR/debian.sh" 1>&1 2>&1
else
    echo "Script for Linux incomplete. Please install all missing software manually."
    echo "apt-get is missing. Please install all packages listed in '$DIR/debian.sh' manually."
fi

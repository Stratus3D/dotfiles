#!/bin/bash
############################
# setup.sh
# This script creates everything needed to get started on a new laptop
############################

# Terminate script if anything exits with a non-zero value
set -e

# Get the uname string
unamestr=`uname`

if [[ "$unamestr" == 'Darwin' ]]; then
    # Use thoughtbot's laptop script to set everything up
    curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
    sh mac 2>&1 | tee ~/laptop.log
elif [[ "$unamestr" == 'Linux' ]]; then
    # Do nothing for now, add custom code here
    echo "script for Linux incomplete"
fi

# download the dotfiles
cd ~
git clone https://github.com/Stratus3D/dotfiles.git
cd dotfiles/

# run the install script, which symlinks the dotfiles
chmod +x makesymlinks.sh
./makesymlinks.sh

#!/bin/bash
############################
# setup.sh
# This script creates everything needed to get started on a new laptop
############################

# Terminate script if anything exits with a non-zero value
set -e

############################
# Install software on laptop
############################
# Get the uname string
unamestr=`uname`

if [[ "$unamestr" == 'Darwin' ]]; then
    # Use thoughtbot's laptop script to set everything up
    curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
    sh mac 2>&1 | tee ~/laptop.log
elif [[ "$unamestr" == 'Linux' ]]; then
    # Do nothing for now
    # TODO: write code to install software on linux
    echo "Script for Linux incomplete. Please install all the software manually."
fi

############################
# Create commonly used directories
############################
mkdir ~/Development
mkdir ~/Development/src # Go directories
mkdir ~/Development/bin
mkdir ~/Documentation
mkdir ~/Installers

############################
# Setup dotfiles
############################
cd ~
git clone https://github.com/Stratus3D/dotfiles.git
cd dotfiles/

# run the install script, which symlinks the dotfiles
chmod +x makesymlinks.sh
./makesymlinks.sh

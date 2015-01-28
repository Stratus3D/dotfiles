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

# Install oh-my-zsh first, as the laptop script doesn't install it
curl -L http://install.ohmyz.sh | sh

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
# TODO: The names of these directories are duplicated elsewhere.
mkdir -p $HOME/.erlang_versions
mkdir -p $HOME/bin # Third-party binaries
mkdir -p $HOME/Development
mkdir -p $HOME/Development/src # Go source directory
mkdir -p $HOME/Development/bin # Go binary directory
mkdir -p $HOME/Documentation
mkdir -p $HOME/Installers

############################
# Setup dotfiles
############################
cd ~
git clone ssh://git@github.com/Stratus3D/dotfiles.git
cd dotfiles/

# run the install script, which symlinks the dotfiles
chmod +x makesymlinks.sh
./makesymlinks.sh

#!/bin/bash -
############################
# setup.sh
# This script creates everything needed to get started on a new laptop
############################


set -e # Terminate script if anything exits with a non-zero value
set -u # Prevent unset variables

# Get the directory this script is stored in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

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

    # Then run our own setup script
    "$DIR/setup/darwin.sh"
elif [[ "$unamestr" == 'Linux' ]]; then
    # Run our own setup script
    "$DIR/setup/linux.sh"
fi

# Install nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

# Install command-line JSON processor
brew install jq

############################
# Create commonly used directories
############################
# TODO: The names of these directories are duplicated elsewhere.
mkdir -p $HOME/.erlang_versions
mkdir -p $HOME/bin # Third-party binaries
mkdir -p $HOME/lib # Third-party software
mkdir -p $HOME/nobackup # All files that shouldn't be backed up the normal way
mkdir -p $HOME/Development
mkdir -p $HOME/Development/src # Go source directory
mkdir -p $HOME/Development/bin # Go binary directory
mkdir -p $HOME/Documentation
mkdir -p $HOME/Installers

############################
# Setup dotfiles
############################
cd $HOME

DOTFILES_DIR=$HOME/dotfiles
DOTFILE_SCRIPTS_DIR=$DOTFILES_DIR/scripts

if [ ! -d $DOTFILES_DIR ]; then
  git clone ssh://git@github.com/Stratus3D/dotfiles.git $DOTFILES_DIR
else
  cd $DOTFILES_DIR
  git pull origin master
fi

# run the install script, which symlinks the dotfiles
chmod +x $DOTFILE_SCRIPTS_DIR/makesymlinks.sh
./$DOTFILE_SCRIPTS_DIR/makesymlinks.sh

# Reload after installing dotfiles
source $HOME/.bashrc

############################
# Install devdocs
############################
cd $HOME/Development
rbenv install 2.2.0
git clone https://github.com/Thibaut/devdocs.git && cd devdocs
rbenv local 2.2.0
gem install bundler
# TODO: Fix issue with bundle install never finishing
bundle install
thor docs:download --all

############################
# Place third party scripts in ~/bin
############################
cd $HOME/bin

# Download kerl
curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
chmod a+x kerl

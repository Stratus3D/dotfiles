#!/bin/bash -
###############################################################################
# setup.sh
# This script creates everything needed to get started on a new laptop
###############################################################################

set -e # Terminate script if anything exits with a non-zero value
set -u # Prevent unset variables
set -o pipefail # Pipe exit code should be non-zero when a command in it fails

# Get the directory this script is stored in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $HOME

DOTFILES_DIR=$HOME/dotfiles
DOTFILE_SCRIPTS_DIR=$DOTFILES_DIR/scripts

###############################################################################
# Ensure Git is installed before proceeding
###############################################################################

if hash git 2>/dev/null; then
    echo "Git is already installed. Skipping installation"
else
    # We need to install git before continuing
    echo "Git is not installed. Installing..."
    # TODO: Use apt-get or brew
fi

###############################################################################
# Setup dotfiles
###############################################################################

if [ ! -d $DOTFILES_DIR ]; then
  git clone ssh://git@github.com/Stratus3D/dotfiles.git $DOTFILES_DIR
else
  cd $DOTFILES_DIR
  git pull origin master
fi

# Change to the dotfiles directory either way
cd $DOTFILES_DIR

# run the install script, which symlinks the dotfiles
chmod +x $DOTFILE_SCRIPTS_DIR/makesymlinks.sh
$DOTFILE_SCRIPTS_DIR/makesymlinks.sh

###############################################################################
# Create commonly used directories
###############################################################################
# TODO: The names of these directories are duplicated elsewhere.
mkdir -p $HOME/bin # Third-party binaries
mkdir -p $HOME/lib # Third-party software
mkdir -p $HOME/nobackup # All files that shouldn't be backed up the normal way
mkdir -p $HOME/Development
mkdir -p $HOME/Development/src # Go source directory
mkdir -p $HOME/Development/bin # Go binary directory
mkdir -p $HOME/Documentation
mkdir -p $HOME/Installers
mkdir -p $HOME/nobackup

###############################################################################
# Install software on laptop
###############################################################################
# Get the uname string
unamestr=`uname`

# Install oh-my-zsh first, as the laptop script doesn't install it
ZSH_DIR="$HOME/.oh-my-zsh"
if [[ -d $ZSH_DIR ]]; then
    # Update Zsh if we already have it installed
    cd $ZSH_DIR
    git pull origin master
    cd -
else
    # Install it if don't have a ~/.oh-my-zsh directory
    curl -L http://install.ohmyz.sh | sh
fi

if [[ "$unamestr" == 'Darwin' ]]; then
    # Then run our own setup script
    "$DIR/setup/darwin.sh" 1>&1 2>&1
elif [[ "$unamestr" == 'Linux' ]]; then
    # Run our own setup script
    "$DIR/setup/linux.sh" 1>&1 2>&1
fi

###############################################################################
# Install asdf for version management
###############################################################################
asdf_dir=$HOME/.asdf
cd $HOME

if [ ! -d $asdf_dir ]; then
    echo "Installing asdf..."
    git clone https://github.com/HashNuke/asdf.git $asdf_dir
    echo "asdf installation complete"
else
    echo "asdf already installed"
fi

###############################################################################
# Reload the .bashrc so we have asdf and all the other recently installed tools
###############################################################################
source $HOME/.bashrc

# Install all the plugins needed
asdf plugin-add erlang https://github.com/HashNuke/asdf-erlang.git
asdf plugin-add elixir https://github.com/HashNuke/asdf-elixir.git
asdf plugin-add ruby https://github.com/HashNuke/asdf-ruby.git
asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git
asdf plugin-add nodejs https://github.com/HashNuke/asdf-nodejs.git
asdf install

###############################################################################
# Install devdocs
###############################################################################
cd $HOME/Development
rbenv install 2.2.0
git clone https://github.com/Thibaut/devdocs.git && cd devdocs
rbenv local 2.2.0
gem install bundler
# TODO: Fix issue with bundle install never finishing
bundle install
thor docs:download --all

###############################################################################
# Install Pygments
###############################################################################
pip install Pygments

###############################################################################
# Setup cpan and install packages for irssi
###############################################################################

cpan Lingua::Ispell

###############################################################################
# Check environment and print out results
###############################################################################

$DIR/checkenv.sh

# Install jslint
npm install -g jslint

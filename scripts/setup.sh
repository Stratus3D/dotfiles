#!/bin/bash -
###############################################################################
# setup.sh
# This script creates everything needed to get started on a new laptop
###############################################################################

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

cd $HOME

DOTFILES_DIR=$HOME/dotfiles
DOTFILE_SCRIPTS_DIR=$DOTFILES_DIR/scripts

###############################################################################
# Setup dotfiles
###############################################################################

if [ ! -d $DOTFILES_DIR ]; then
  if hash git 2>/dev/null; then
    echo "Git is already installed. Cloning repository..."
    git clone ssh://git@github.com/Stratus3D/dotfiles.git $DOTFILES_DIR
  else
    echo "Git is not installed. Downloading repository archive..."
    wget https://github.com/Stratus3D/dotfiles/archive/master.tar.gz
    tar -zxvf master.tar.gz
    mv dotfiles-master dotfiles
    # TODO: If we have to download the archive, we don't git the .git
    # metadata, which means we can't run `git pull` in dotfiles directory to
    # update the dotfiles. Which means if we run this script again, the else
    # clause below will fail.
  fi
fi

# Change to the dotfiles directory either way
cd $DOTFILES_DIR

###############################################################################
# Create commonly used directories
###############################################################################
# TODO: These directory names are duplicated elsewhere. Reduce duplication
mkdir -p $HOME/bin # Third-party binaries
mkdir -p $HOME/lib # Third-party software
mkdir -p $HOME/nobackup # All files that shouldn't be backed up the normal way
mkdir -p $HOME/history # Zsh and Bash history files
mkdir -p $HOME/erl_libs # $ERL_LIBS directory
mkdir -p $HOME/devel
mkdir -p $HOME/devel/src # Go source directory
mkdir -p $HOME/devel/bin # Go binary directory
mkdir -p $HOME/devel/archived # Old projects
mkdir -p $HOME/Documentation
mkdir -p $HOME/Screenshots
mkdir -p $HOME/audio
mkdir -p $HOME/audio/podcasts # For podcast storage
mkdir -p $HOME/audio/music # For music storage
mkdir -p $HOME/servers # For remote server mounts
mkdir -p $HOME/clients # Files for third parties - companies, friends, etc...
mkdir -p $HOME/.psql # psql history directory

###############################################################################
# Install software on laptop
###############################################################################
# Get the uname string
unamestr=`uname`

# Run the OS-specific setup scripts, needed here so git and other comamnds are
# available for later steps
if [[ "$unamestr" == 'Darwin' ]]; then
    "$DOTFILE_SCRIPTS_DIR/setup/darwin.sh"
elif [[ "$unamestr" == 'Linux' ]]; then
    "$DOTFILE_SCRIPTS_DIR/setup/linux.sh"
fi

# Install antigen
ANTIGEN_HOME=$HOME/.antigen
git clone https://github.com/zsh-users/antigen.git $ANTIGEN_HOME

# Define a function used by the setup scripts to run all the custom install
# scripts.
run_install_scripts() {
    install_scripts_dir=$HOME/dotfiles/scripts/install

    # Run each script
    for file in $install_scripts_dir/*; do
        "$install_scripts_dir/$file"
    done
}

###############################################################################
# Install asdf for version management
###############################################################################
asdf_dir=$HOME/.asdf
cd $HOME

if [ ! -d $asdf_dir ]; then
    echo "Installing asdf..."
    git clone https://github.com/asdf-vm/asdf.git $asdf_dir
    echo "asdf installation complete"
else
    echo "asdf already installed"
fi

###############################################################################
# Create symlinks to custom config now that all the software is installed
###############################################################################
$DOTFILE_SCRIPTS_DIR/makesymlinks.sh

###############################################################################
# Reload the .bashrc so we have asdf and all the other recently installed tools
###############################################################################
source $HOME/.bashrc

# Install all the plugins needed
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git || true
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git || true
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git || true
asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git || true
asdf plugin-add postgres https://github.com/smashedtoatoms/asdf-postgres.git || true
asdf plugin-add rebar https://github.com/Stratus3D/asdf-rebar.git || true
asdf plugin-add python https://github.com/danhper/asdf-python.git || true
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin-add yarn https://github.com/twuni/asdf-yarn.git || true

# Imports Node.js release team's OpenPGP keys to main keyring
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring || true

# Install the software versions listed in the .tool-versions file in $HOME
asdf install

# Setup officediff scripts so we can diff MS office files in Git
$DOTFILE_SCRIPTS_DIR/officediff/setup.sh

###############################################################################
# Install Misc. Packages
###############################################################################

$DOTFILE_SCRIPTS_DIR/setup/packages.sh

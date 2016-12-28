#!/bin/bash -

# This script will be run by launchd on OSX

source $HOME/.bashrc

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

# Setup on OSX

# Symlink the plist file so this is run:
#ln -s ~/dotfiles/osx/com.stratus3d.dotfiles.login.plist ~/Library/LaunchAgents/com.stratus3d.dotfiles.login.plist

# Load the daemon
#launchctl load ~/Library/LaunchAgents/com.stratus3d.dotfiles.login.plist

# Test the daemon directly
#launchctl start com.stratus3d.dotfiles.login

CUSTOM_FILE=$HOME/dotfiles/scripts/upon_login_custom.sh

# Source the custom file if it exists
if [ -x $CUSTOM_FILE ]; then
    source $CUSTOM_FILE
fi

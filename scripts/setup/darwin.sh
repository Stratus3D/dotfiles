#!/bin/bash -

###############################################################################
# Set flags so script is executed in "strict mode"
###############################################################################

set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

###############################################################################
# Run thoughtbot's laptop script and install missing packages with brew
###############################################################################

# Get the directory this script is stored in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Use thoughtbot's laptop script to set everything up
"$DIR/laptop.sh"

# Exuberant Ctags
brew install ctags

# Visualization library
brew install graphviz

# Install command-line JSON processor
brew install jq

# WxWidgets for Erlang
brew install wxmac --with-static --with-stl --universal

# Install pianobar for music
brew install pianobar

# TODO: write code to install software on Darwin
echo "Script for Darwin incomplete. Please install all the software manually."

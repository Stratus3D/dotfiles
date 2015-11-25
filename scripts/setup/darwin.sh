#!/bin/bash -

# Get the directory this script is stored in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Use thoughtbot's laptop script to set everything up
"$DIR/laptop.sh"

# Install command-line JSON processor
brew install jq

# Install pianobar for music
brew install pianobar

# TODO: write code to install software on Darwin
echo "Script for Darwin incomplete. Please install all the software manually."

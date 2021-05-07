#! /usr/bin/env bash

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# This script contains calls to package managers that should be the same across
# different operating systems. Since this script can be invoked on any
# operating system, we invoke it from the main setup.sh when setting up a new
# computer

# Ruby Packages
###############################################################################

# For tmux projects
gem install tmuxinator -v 1.1.5

# Python Packages
###############################################################################

# Install Pygments
pip install Pygments

# flake8 for linting
python -m pip install flake8

# csvkit for CSV utilities
pip install csvkit

# Spotify downloader
pip3 install spotdl

# Node.JS Packages
###############################################################################

# fb-messenger-cli for messaging
npm install -g fb-messenger-cli

# Install jslint for linting
npm install -g jslint

# Install xml2json tool
npm install -g xml2json-command

# Install pa11y tool for web accessibility checks
npm install -g pa11y

# Perl Packages
###############################################################################

# Setup cpan and install packages for irssi
cpan Lingua::Ispell

# Haskell Packages
###############################################################################

# Make sure our local list is up to date
cabal update

# For building tables on the command line
cabal install pandoc-placetable

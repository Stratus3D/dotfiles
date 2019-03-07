#! /usr/bin/env bash

# Ruby Packages
###############################################################################

# For tmux projects
gem install tmuxinator

# Python Packages
###############################################################################

# Install Pygments
pip install Pygments

# flake8 for linting
python -m pip install flake8

# csvkit for CSV utilities
pip install csvkit

# Node.JS Packages
###############################################################################

# fb-messenger-cli for messaging
npm install -g fb-messenger-cli

# Install jslint for linting
npm install -g jslint

# Install xml2json tool
npm install -g xml2json-command

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

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

# For managing project dependencies
gem install bundler

# For tmux projects
gem install tmuxinator -v 3.0.5

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

# Install pa11y tool for web accessibility checks
npm install -g pa11y

# For commit linting
npm install -g @commitlint/cli @commitlint/config-conventional

# For viewing flame graphs in the browser
npm install -g speedscope

# Quick diffs of large JSON blobs. I can pass in files that contain raw
# unformatted JSON and get nicely structured JSON diffs.
npm install -g json-diff

# View usage examples for shell commands. Augments man pages with more concrete
# examples
npm install -g tldr

# Haskell Packages
###############################################################################

# Make sure our local list is up to date
cabal update

# For building tables on the command line
cabal install pandoc-placetable

# Golang Packages
###############################################################################

# For linting
go install honnef.co/o/tools/cmd/staticcheck@latest

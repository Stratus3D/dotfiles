#!/usr/bin/env bash

# Unofficial Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings

# This script generates the .ripgreprc based off the ripgreprc file in this
# repository. Ripgrep doesn't support ~ or $HOME in the ripgreprc file so we
# to find and replace occurrences of the string "$HOME" with the value of the
# HOME environment variable.

# dotfiles directory
dotfiles=$HOME/dotfiles

# ripgreprc source file
ripgreprc=$dotfiles/ripgreprc

# ripgreprc destination file
destination=$HOME/.ripgreprc

# Generate ripgreprc with $HOME replaced with actual home path
cat $ripgreprc | sed 's:$HOME:'"$HOME"':' > $destination

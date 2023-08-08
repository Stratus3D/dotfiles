#!/usr/bin/env bash

# Unofficial Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings

# This script generates the .gitconfig based off the gitconfig file in this
# repository and the mixins/gitconfig.custom file if it exists.

# dotfiles directory
dotfiles=$HOME/dotfiles

# gitconfig source file
gitconfig=$dotfiles/gitconfig

# gitconfig destination file
destination=$HOME/.gitconfig

# custom gitconfig
custom_gitconfig=$dotfiles/mixins/gitconfig.custom

if [ -f $custom_gitconfig ]; then
    # Append custom gitconfig onto gitconfig
    cat $gitconfig $custom_gitconfig > $destination
else
    # Just copy original gitconfig
    cp $gitconfig $destination
fi

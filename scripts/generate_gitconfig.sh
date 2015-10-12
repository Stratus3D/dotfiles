#!/bin/bash -
###############################################################################
# This script generates the .gitconfig based off the gitconfig file in this
# repository and the mixins/gitconfig.custom file if it exists.
###############################################################################
dotfiles=$HOME/dotfiles               # dotfiles directory
gitconfig=$dotfiles/gitconfig         # gitconfig source file
destination=$HOME/.gitconfig          # gitconfig destination file
custom_gitconfig=$dotfiles/mixins/gitconfig.custom # custom gitconfig
olddir=$HOME/dotfiles_old

if [ -f $destination ]; then
    mv $destination $olddir
fi

if [ -f $custom_gitconfig ]; then
    # Append custom gitconfig onto gitconfig
    cat $gitconfig $custom_gitconfig > $destination
else
    # Just copy original gitconfig
    cp $gitconfig $destination
fi

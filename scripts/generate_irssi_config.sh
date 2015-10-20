#!/bin/bash -
###############################################################################
# This script generates the .irssi/config based off the irssi/config file in
# this repository and the mixins/gitconfig.custom file if it exists.
###############################################################################
dotfiles=$HOME/dotfiles               # dotfiles directory
irssi=$dotfiles/irssi                # gitconfig source directory
destination=$HOME/.irssi/          # gitconfig destination file
custom_irssi_config=$dotfiles/mixins/irssi_config.custom # custom gitconfig
olddir=$HOME/dotfiles_old

# TODO: Complete script

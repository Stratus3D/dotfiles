#!/bin/bash -
###############################################################################
# This script generates the .irssi/config based off the irssi/config file in
# this repository and the mixins/irssi_config.custom file if it exists.
###############################################################################
dotfiles=$HOME/dotfiles                     # dotfiles directory
irssi_config=$dotfiles/irssi/config                # gitconfig source directory
custom_irssi_config=$dotfiles/mixins/irssi_config.custom # custom gitconfig
irssi_directory=$HOME/.irssi
destination=$irssi_directory/config             # gitconfig destination file
olddir=$HOME/dotfiles_old

if [ -L $irssi_directory ]; then
    rm $irssi_directory
elif [ -d $irssi_directory ]; then
    cp -r $irssi_directory $olddir
    rm -r $irssi_directory
fi

mkdir $irssi_directory

if [ -f $custom_irssi_config ]; then
    # Append custom irssi config into $destination
    cat $irssi_config $custom_irssi_config > $destination
else
    # Just copy original irssi/config file
    cp $irssi_config $destination
fi

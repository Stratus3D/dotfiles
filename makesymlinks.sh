#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

set -u # Prevent unset variables
set -e # Stop on an error

########## Variables

border="====="
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="vimrc vim zshrc bashrc general aliases grep nodejs path tmux.conf gitconfig gitignore_global ackrc ctags jshintrc"

##########

# Remove everything in dotfiles_old
rm -rf $olddir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
  oldfile=$HOME/.$file
  if [ -f $oldfile ]; then
      mv $oldfile $olddir
  fi
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file $HOME/.$file
done

# Set global gitignore file to symlink gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global

# setup default tmuxinator project
if [ ! -d ~/.tmuxinator ]; then
  mkdir ~/.tmuxinator
fi

# link the default tmuxinator project
if [ ! -L $HOME/.tmuxinator/default.yml ]; then
    ln -nsf $dir/tmuxinator/default.yml $HOME/.tmuxinator/default.yml
fi

# If vundle is already installed, remove it and fetch the latest from Github
if [ -d ~/dotfiles/vim/bundle/Vundle.vim ]; then
    rm -rf ~/dotfiles/vim/bundle/Vundle.vim
fi
# Download vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
# Install vundle and all other plugins
vim +PluginInstall +qall

echo "$border Linking complete! $border"

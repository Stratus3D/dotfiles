#!/bin/bash -
###############################################################################
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles
###############################################################################

set -u # Prevent unset variables
set -e # Stop on an error

###############################################################################
# Variables
###############################################################################

border="====="
dotfiles=$HOME/dotfiles               # dotfiles directory
olddir=$HOME/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="vimrc vim zshrc bashrc tmux.conf gitignore_global ackrc ctags
screenrc jshintrc rsync-exclude tool-versions agignore"

###############################################################################
# Functions
###############################################################################

print_heading() {
    local text=$1

    echo "$border $text $border"
}

symlink_file_if_missing() {
    local source=$1
    local destination=$2

    if [ ! -f $destination ]; then
        ln -nfs $source $destination
    fi
}

# Remove everything in dotfiles_old
rm -rf $olddir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in $HOME"
mkdir -p $olddir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks
for file in $files; do
  oldfile="$HOME/.$file"

  if [[ -L $oldfile ]]; then
      echo "Removing $oldfile symlink"
      rm $oldfile;
  else
      if [[ -e $oldfile ]]; then
          echo "Moving existing $oldfile from $HOME to $olddir"
          mv $oldfile $olddir;
      fi
  fi
  echo "Creating symlink to $file in home directory."
  echo "$dotfiles/$file - $HOME/.$file"
  ln -s "$dotfiles/$file" "$HOME/.$file"
done

# Generate and copy gitconfig
$dotfiles/scripts/generate_gitconfig.sh

# Generate and copy irssi/config
$dotfiles/scripts/generate_irssi_config.sh

# setup default tmuxinator project
if [ ! -d $HOME/.tmuxinator ]; then
  mkdir $HOME/.tmuxinator
fi

# link the default tmuxinator project
if [ ! -L $HOME/.tmuxinator/default.yml ]; then
    ln -nsf $dotfiles/tmuxinator/default.yml $HOME/.tmuxinator/default.yml
fi

# If vundle is already installed, remove it and fetch the latest from Github
if [ -d $dotfiles/vim/bundle/Vundle.vim ]; then
    rm -rf $dotfiles/vim/bundle/Vundle.vim
fi

# Download vundle
git clone https://github.com/gmarik/Vundle.vim.git $dotfiles/vim/bundle/Vundle.vim
# Install vundle and all other plugins
vim +PluginInstall +qall

# Link gnome terminal profile if we are on gnome
if [ -d $HOME/.gconf/ ]; then
    TERMINAL_APP=$HOME/.gconf/apps/gnome-terminal
    PROFILES=$TERMINAL_APP/profiles/
    echo "Linking gnome profile..."

    # Link Solarized profile
    #if [ -d $PROFILES/Solarized ]; then
    #    rm -r $PROFILES/Solarized
    #fi
    symlink_file_if_missing $dotfiles/gnome_terminal_profile/profiles/Solarized/%gconf.xml $PROFILES/Solarized/%gconf.xml
    # Link global gconf.xml
    symlink_file_if_missing $dotfiles/gnome_terminal_profile/global/%gconf.xml $TERMINAL_APP/global/%gconf.xml
    echo "Gnome profile linked"
fi

print_heading "Linking complete!"

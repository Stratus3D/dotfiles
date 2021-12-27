#!/bin/bash -
###############################################################################
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles
###############################################################################

set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

###############################################################################
# Variables
###############################################################################

# The border for headings printed to STDOUT
border="====="

# Dotfiles directory
dotfiles=$HOME/dotfiles

# Old dotfiles backup directory
olddir=$HOME/dotfiles_old

# List of space separated files/folders to symlink in homedir (these are the typical "dotfiles")
files="vimrc vim zshrc bashrc tmux.conf gitignore_global ctags screenrc \
    jshintrc rsync-exclude tool-versions agignore asdfrc psqlrc hushlogin \
    my.cnf inputrc editrc iex.exs curlrc irbrc gemrc weechat gitattributes \
    gnuplot digrc"

###############################################################################
# Functions
###############################################################################

print_heading() {
    local text=$1

    echo "$border $text $border"
}

make_dir_if_missing() {
    local directory=$1

    if [ ! -d $directory ]; then
        mkdir $directory
    fi
}

remove_dir_if_exists() {
    local directory=$1

    if [ -d $directory ]; then
        rm -rf $directory
    fi
}

symlink_file_if_missing() {
    local source=$1
    local destination=$2

    if [ ! -f $destination ]; then
        ln -nfs $source $destination
    fi
}

create_or_replace_symlink() {
    local source=$1
    local destination=$2

    if [ -L $destination ]; then
        rm $destination
    fi

    ln -nfs $source $destination
}

symlink_and_save_original() {
    local source=$1
    local destination=$2
    local backup_dir=$3

    if [[ -L $destination ]]; then
        echo "Removing $destination symlink"
        rm $destination;
    else
        if [[ -e $destination ]]; then
            echo "Moving existing $destination from $HOME to $backup_dir"
            mv $destination $backup_dir;
        fi
    fi
    echo "Creating symlink to $file in home directory."
    echo "Symlinking $destination -> $source"
    ln -s "$source" "$destination"
}

# Remove everything in dotfiles_old
rm -rf $olddir

# create dotfiles_old in homedir
mkdir -p $olddir
echo "Created $olddir for backup of any existing dotfiles in $HOME"

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks
IFS=$' '
for file in $files; do
  oldfile="$HOME/.$file"

  symlink_and_save_original $dotfiles/$file $oldfile $olddir
done
IFS=$ORIGINAL_IFS

# Generate and copy gitconfig
$dotfiles/scripts/generate_gitconfig.sh

# setup default tmuxinator project
make_dir_if_missing $HOME/.tmuxinator

# Create directory for Vim undo history
make_dir_if_missing $dotfiles/vim/undodir

# link the default tmuxinator project
symlink_and_save_original $dotfiles/tmuxinator/default.yml \
    $HOME/.tmuxinator/default.yml $olddir

# Symlink the .erlang file
symlink_and_save_original $dotfiles/erlang/erlang \
    $HOME/.erlang $olddir

# Symlink all the scripts in scripts/tools to the bin directory
tool_scripts=$(find $dotfiles/scripts/tools -type f \( -perm -u=x \) -print)
IFS=$'\n'
for file in $tool_scripts; do
    create_or_replace_symlink $file $HOME/bin
done
IFS=$ORIGINAL_IFS

# Symlink all the scripts in scripts/git to the bin directory
tool_scripts=$(find $dotfiles/scripts/git -type f \( -perm -u=x \) -print)
IFS=$'\n'
for file in $tool_scripts; do
    create_or_replace_symlink $file $HOME/bin
done
IFS=$ORIGINAL_IFS

# If vundle is already installed, remove it and fetch the latest from Github
remove_dir_if_exists $dotfiles/vim/bundle/Vundle.vim

# Download vundle
echo "Installing vim plugins..."
git clone https://github.com/gmarik/Vundle.vim.git $dotfiles/vim/bundle/Vundle.vim
# Install vundle and all other plugins
vim +PluginInstall +qall

# Symlink hosts_manager hosts profiles directory
hosts_dir="$HOME/.hosts"
hosts_source_dir="$dotfiles/hosts_profiles"
symlink_and_save_original $hosts_source_dir $hosts_dir $olddir

print_heading "Linking complete!"

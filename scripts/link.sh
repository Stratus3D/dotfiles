#!/usr/bin/env bash

# Unofficial Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles

# Variables

# The border for headings printed to STDOUT
border="====="

# Dotfiles directory
dotfiles=$HOME/dotfiles

# List of space separated files/folders to symlink in homedir (these are the typical "dotfiles")
files="vimrc vim zshrc bashrc tmux.conf gitignore_global ctags screenrc \
    jshintrc rsync-exclude tool-versions agignore asdfrc psqlrc hushlogin \
    my.cnf inputrc editrc iex.exs curlrc irbrc gemrc ripgrep-ignore \
    gitattributes gnuplot digrc default-gems"

# Functions
error_exit() {
  printf "\e[1;7;31m'%s\n\e[0m" "$1" 1>&2
  exit "${2:-1}" # default exit status 1
}

print_heading() {
    local text=$1

    echo "$border $text $border"
}

make_dir_if_missing() {
    local directory=$1

    if [ ! -d "$directory" ]; then
        mkdir "$directory"
    fi
}

remove_dir_if_exists() {
    local directory=$1

    if [ -d "$directory" ]; then
        rm -rf "$directory"
    fi
}

symlink_file_if_missing() {
    local source=$1
    local destination=$2

    if [ ! -f "$destination" ]; then
        ln -nfs "$source" "$destination"
    fi
}

create_or_replace_symlink() {
    local source=$1
    local destination=$2

    if [ -L "$destination" ]; then
        rm "$destination"
    fi

    ln -nfs "$source" "$destination"
}

symlink() {
    local source=$1
    local destination=$2

    if [ -e "$destination" ] || [ -L "$destination" ]; then
      echo "Removing $(basename "$destination") from $HOME"
      rm "$destination";
    fi

    echo "Symlinking $destination -> $source"
    ln -s "$source" "$destination"
}

create_or_replace_symlinks() {
  local directory=$1
  local destination=$2

  scripts="$(find "$directory" -maxdepth 1 -type f \( -perm -u=x \) -print)"
  IFS=$'\n'
  for script in $scripts; do
    create_or_replace_symlink "$script" "$destination"
  done
  IFS=$ORIGINAL_IFS
}

print_heading "Linking Dotfiles"

# create symlinks
ORIGINAL_IFS=$IFS
IFS=$' '
for file in $files; do
  symlink "$dotfiles/$file" "$HOME/.$file"
done
IFS=$ORIGINAL_IFS

# Generate and copy gitconfig
"$dotfiles/scripts/generate_gitconfig.sh"

# Generate ripgrep config with absolute paths since ripgrep can't handle ~ or
# shell variables
"$dotfiles/scripts/generate_ripgreprc.sh"

# setup default tmuxinator project
make_dir_if_missing "$HOME/.tmuxinator"

# Create directory for Vim undo history
make_dir_if_missing "$dotfiles/vim/undodir"

# link the default tmuxinator project
symlink "$dotfiles/tmuxinator/default.yml" "$HOME/.tmuxinator/default.yml"

# Symlink the .erlang file
symlink "$dotfiles/erlang/erlang" "$HOME/.erlang"

# Symlink all the executable scripts in scripts/tools to the bin directory
create_or_replace_symlinks "$dotfiles/scripts/tools" "$HOME/bin"

# Symlink all the scripts in scripts/git to the bin directory
create_or_replace_symlinks "$dotfiles/scripts/git" "$HOME/bin"

# Some scripts are only needed on MacOS or Linux
if [ "$(uname)" == "Darwin" ]; then
  create_or_replace_symlinks "$dotfiles/scripts/tools/macos" "$HOME/bin"
fi

if [ "$(uname)" == "Linux" ]; then
  create_or_replace_symlinks "$dotfiles/scripts/tools/linux" "$HOME/bin"
fi

if [ "$(uname)" == "Darwin" ]; then
  symlink "$dotfiles/templates/k9s/skin.yml" "$HOME/Library/Application Support/k9s/skin.yml"
else
  echo "Cannot link k9s skin"
fi

# Download Vundle if not already downloaded
print_heading "Installing Vundle"
vundle_dir="$dotfiles/vim/bundle/Vundle.vim"
if [ ! -d "$vundle_dir" ]; then
  git clone https://github.com/gmarik/Vundle.vim.git "$vundle_dir"
else
  echo "Vundle already installed"
fi

# Validate Vim was compiled with flags needed by plugins
vim_info="$(vim --version)"
grep -F '+float' <<< "$vim_info" > /dev/null ||
  error_exit "Vim not compiled with +float option needed for the crunch plugin. Please recompile"
grep -F '+python' <<< "$vim_info" > /dev/null ||
  error_exit "Vim not compiled with +python option needed for the ultisnips plugin. Please recompile"

# Install Vundle and all other plugins
print_heading "Installing Vim Plugins"
vim +PluginInstall +qall

print_heading "Linking and Vim Configuration Complete"

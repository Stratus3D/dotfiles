#!/usr/bin/env bash

# Unofficial Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

# Install brew if not installed
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    export PATH="/usr/local/bin:$PATH"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
brew update

# My default interactive shell
brew_install_or_upgrade 'zsh'

# For version control
brew_install_or_upgrade 'git'

# For code search
brew_install_or_upgrade ripgrep

# Gnu grep for shell scripts and pipelines
brew_install_or_upgrade grep

# My editor
brew_install_or_upgrade 'vim'

# For Code navigation - Exuberant ctags
brew_install_or_upgrade ctags

# For screen sessions
brew_install_or_upgrade 'tmux'
$HOME/dotfiles/script/setup/tmux.sh

# For shell scripting
brew_install_or_upgrade 'shellcheck'

# For image manipulation
brew_install_or_upgrade 'imagemagick'
brew_install_or_upgrade 'qt'
brew_install_or_upgrade 'telnet'

# For building Erlang and Elixir, possibly other things
brew_install_or_upgrade autoconf

# For Ruby
brew_install_or_upgrade readline

# For various languages that use OpenSSL
brew_install_or_upgrade 'openssl'
brew unlink openssl && brew link openssl --force

brew_install_or_upgrade 'libyaml'

# Visualization library
brew_install_or_upgrade graphviz
brew link graphviz

# For plotting data on charts at the command line
brew_install_or_upgrade gnuplot

# Install command-line JSON processor
brew_install_or_upgrade jq

# Install pandoc (for office and PDF file diffs)
brew_install_or_upgrade pandoc

# CLI Dictionary just like on Linux (unfortunately without an offline
# dictionary server)
brew_install_or_upgrade dict

# Install navi for interactive cheatsheets
brew_install_or_upgrade navi

# WxWidgets for Erlang
brew_install_or_upgrade wxmac

# QCacheGrind for valgrind analysis
brew_install_or_upgrade qcachegrind

# For watching for file change events
brew_install_or_upgrade entr

# Install GNU readlink
brew_install_or_upgrade coreutils

# Install GNU sed
brew_install_or_upgrade gnu-sed

# autoexpect
brew_install_or_upgrade expect

# For easy renaming of files
brew_install_or_upgrade rename

# For adb
brew_tap caskroom/cask
brew cask install android-sdk
brew cask install android-platform-tools

# Mosh for high latency remote servers
brew_install_or_upgrade mobile-shell

# For wrapping shells that don't use readline
brew_install_or_upgrade rlwrap

# For encryption and signing, also used by pass
brew_install_or_upgrade gnupg
brew_install_or_upgrade pinentry

# For password management
brew_install_or_upgrade pass

# Elm for packages that require it
brew_install_or_upgrade elm

# For network troubleshooting
brew_install_or_upgrade mtr

# OSX alternative to `ps auxf` for process tree views
brew_install_or_upgrade pstree

# Images in the terminal
brew_tap eddieantonio/eddieantonio
brew_install_or_upgrade imgcat

# Install tools for server testing and administration
brew_install_or_upgrade ansible

# For MySQL migrations
brew_install_or_upgrade percona-toolkit

# For benchmarking in the shell
brew_install_or_upgrade hyperfine

# Install iperf3 for network performance tests
brew_install_or_upgrade iperf3

# For web server performance
brew_install_or_upgrade siege

# I should probably create an asdf plugin for RabbitMQ
brew_install_or_upgrade rabbitmq

# For IRC
brew_install_or_upgrade weechat

# For diffs of Microsoft Office files
brew_install_or_upgrade tika

# For graphics and file metadata on the command line

# Install pastel for viewing and manipulating colors on the command line
brew_install_or_upgrade pastel

# For removing file metadata
brew_install_or_upgrade mat2

# For image metadata manipulation
brew_install_or_upgrade exiftool

# For artwork

# Gimp for image editing
brew_tap homebrew/cask
brew cask install gimp

# Inkscape for vector graphics
brew cask install xquartz
brew cask install inkscape

# For notifications on MacOS (and for the notify-send-macos script)
brew_install_or_upgrade terminal-notifier

###############################################################################
# Configure OSX
###############################################################################

$HOME/dotfiles/scripts/setup/macos-defaults

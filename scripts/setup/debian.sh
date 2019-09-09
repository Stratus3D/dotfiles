#!/bin/bash -

###############################################################################
# Set flags so script is executed in "strict mode"
###############################################################################

set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

install_or_upgrade() {
    sudo apt-get -y install "$@"
}

###############################################################################
# Install packages with apt-get
###############################################################################

# Make apt-get calls non-interactive
DEBIAN_FRONTEND=noninteractive

# General dependencies
install_or_upgrade autoconf
install_or_upgrade libssl-dev
install_or_upgrade build-essential

# Tools I need for development
# Add apt apt-get repository with latest version of Git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
install_or_upgrade git
install_or_upgrade zsh
install_or_upgrade vim-gtk
install_or_upgrade curl

# other development tools
install_or_upgrade silversearcher-ag
install_or_upgrade exuberant-ctags
install_or_upgrade jq
install_or_upgrade linux-tools-`uname -r` # perf
install_or_upgrade dstat
# For use with Erlang's fprof
install_or_upgrade kcachegrind
# For watching for file change events
install_or_upgrade entr
install_or_upgrade vagrant
install_or_upgrade ansible
install_or_upgrade percona-toolkit

# For clipboard access on the command line
install_or_upgrade xsel

# VirtualBox for VMs
sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
wget -q -O - https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
sudo apt-get update
install_or_upgrade virtualbox-5.2

# Shell script linting
install_or_upgrade shellcheck

# Communication apps
install_or_upgrade weechat
install_or_upgrade thunderbird
install_or_upgrade enigmail # For secure email

# Signal for encrypted messaging
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt-get update
install_or_upgrade signal-desktop

# For emoji
install_or_upgrade ttf-ancient-fonts

# For the terminal
sudo apt-get install fonts-inconsolata

# Skype
install_or_upgrade skypeforlinux

# Chromium
install_or_upgrade chromium-browser

# Redshift dependencies
install_or_upgrade autopoint intltool libdrm-dev libxcb1-dev libxcb-randr0-dev
#sudo apt-get install -y libgeoclue-dev geoclue-hostip

# WxWidgets is needed for Erlang
install_or_upgrade libwxgtk3.0-dev libpng-dev

# Other packages needed for Erlang
install_or_upgrade libgl1-mesa-dev libglu1-mesa-dev

# Love 2D for game development
# These are needed by love 2d
install_or_upgrade libtool
sudo add-apt-repository ppa:bartbes/love-stable
install_or_upgrade love

# Photo editing
install_or_upgrade gimp

# Vector graphics
install_or_upgrade inkscape

# Visualization library
install_or_upgrade graphviz

# For image metadata manipulation
install_or_upgrade exiftool

# Needed for Ruby and PostgreSQL
install_or_upgrade libffi-dev bison libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libgdbm5 libgdbm-dev

# Needed for capybara
install_or_upgrade libqt4-dev libqtwebkit-dev

# Postgres
install_or_upgrade libpq-dev # development package

# Install pip so we can install python packages easily
install_or_upgrade python-pip

# Zeal Docs
sudo add-apt-repository ppa:zeal-developers/ppa
sudo apt-get update
install_or_upgrade zeal

# ReText
install_or_upgrade retext

# Enable DVD playback
sudo apt-get install libdvd-pkg

# Install Pandora CLI
install_or_upgrade pianobar

# Install Android Debug Bridge
install_or_upgrade android-tools-adb
install_or_upgrade android-sdk-platform-tools

# Install mosh shell for high latency servers
install_or_upgrade mosh

# Install iperf so I can test network latency
install_or_upgrade iperf3

# Install Blender for 3D modeling
sudo add-apt-repository ppa:thomas-schiex/blender
sudo apt-get update
install_or_upgrade blender

# Install Scribus for publishing
install_or_upgrade scribus

# Pandoc for document utilities
install_or_upgrade pandoc

# Cabal for Haskell packages
install_or_upgrade cabal-install

# Misc other dependencies
install_or_upgrade ncftp python-paramiko python-pycryptopp lftp python-boto python-dev librsync-dev

# Needed for tmux
install_or_upgrade libevent-dev

# Needed for phantomjs
install_or_upgrade chrpath libxft-dev libfreetype6-dev libfreetype6 libfontconfig1-dev libfontconfig1

# For network troubleshooting
install_or_upgrade mtr

# Tree for directory structure
install_or_upgrade tree

# Screen recording
install_or_upgrade vokoscreen

# Sound recording
install_or_upgrade audacity

# Video editing
install_or_upgrade kdenlive

# CLI dictionary
install_or_upgrade dict

# For password management
install_or_upgrade pass

# For wrapping shells that don't use readline
install_or_upgrade rlwrap

# Install xsane and dependencies
install_or_upgrade libsane libsane-extras sane-utils xsane

# For duplicati
install_or_upgrade mono-runtime

# Assume we are using Gnome
source gnome.sh

# Install other software using custom install scripts
run_install_scripts

# This needs to be run after tmux installation
$HOME/dotfiles/scripts/setup/tmux.sh

# Fix annoying pulseaudio settings, if not already there
# Taken from https://lobste.rs/s/kst05r/disable_flat_volume_for_pulseaudio
if ! grep -c "flat-volumes = no" "$HOME/.pulse/daemon.conf"; then
    echo "flat-volumes = no" >> "$HOME/.pulse/daemon.conf"
fi

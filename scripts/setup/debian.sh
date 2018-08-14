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
install_or_upgrade vim
install_or_upgrade curl

# other development tools
install_or_upgrade silversearcher-ag
install_or_upgrade exuberant-ctags
install_or_upgrade jq
install_or_upgrade linux-tools-`uname -r` # perf
install_or_upgrade dstat
# For use with Erlang's fprof
install_or_upgrade kcachegrind
install_or_upgrade vagrant
install_or_upgrade ansible
install_or_upgrade percona-toolkit

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

# For emoji
install_or_upgrade ttf-ancient-fonts

# Skype
# Skype is in the canonical partner repository
# https://help.ubuntu.com/community/Skype
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update
install_or_upgrade skype

# Google Chrome
sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
install_or_upgrade google-chrome-stable

# Redshift dependencies
install_or_upgrade autopoint intltool libdrm-dev libxcb1-dev libxcb-randr0-dev
#sudo apt-get install -y libgeoclue-dev geoclue-hostip

# WxWidgets is needed for Erlang
install_or_upgrade libwxgtk3.0-dev libwxgtk3.0-dbg

# Other packages needed for Erlang
install_or_upgrade libgl1-mesa-dev libglu1-mesa-dev libpng3

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

# Needed for Ruby and PostgreSQL
install_or_upgrade libffi-dev bison libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libgdbm3 libgdbm-dev
# Needed for capybara
install_or_upgrade libqt4-dev libqtwebkit-dev

# Postgres
install_or_upgrade postgresql
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
sudo /usr/share/doc/libdvdread4/install-css.sh

# Install Pandora CLI
install_or_upgrade pianobar

# Install Android Debug Bridge
install_or_upgrade android-tools-adb

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

# Install xsane and dependencies
sudo add-apt-repository ppa:robert-ancell/sane-backends
sudo apt-get update
install_or_upgrade libsane libsane-extras sane-utils xsane

# Install yarn
sudo add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main"
wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo apt-get update
install_or_upgrade yarn

# Assume we are using Gnome
source gnome.sh

# Install other software using custom install scripts
run_install_scripts

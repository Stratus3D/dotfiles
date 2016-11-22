#!/bin/bash -

###############################################################################
# Set flags so script is executed in "strict mode"
###############################################################################

set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

###############################################################################
# Install packages with apt-get
###############################################################################

# Make apt-get calls non-interactive
DEBIAN_FRONTEND=noninteractive

# Tools I need for development
sudo apt-get -y install git
sudo apt-get -y install zsh
sudo apt-get -y install vim
sudo apt-get -y install tmux
sudo apt-get -y install curl

# other development tools
sudo apt-get -y install silversearcher-ag
sudo apt-get -y install exuberant-ctags
sudo apt-get -y install jq
sudo apt-get -y install linux-tools-`uname -r` # perf
sudo apt-get -y install dstat
# For use with Erlang's fprof
sudo apt-get -y install kcachegrind

# Communication apps
sudo apt-get -y install weechat
sudo apt-get -y install thunderbird
sudo apt-get -y install enigmail # For secure email

#sudo apt-get -y install chrome # chrome isn't available

# For emoji
sudo apt-get -y install ttf-ancient-fonts

# Skype
# Skype is in the canonical partner repository
# https://help.ubuntu.com/community/Skype
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update
sudo apt-get -y install skype

# Google Chrome
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

# Redshift dependencies
sudo apt-get install -y autopoint intltool libdrm-dev libxcb1-dev libxcb-randr0-dev
#sudo apt-get install -y libgeoclue-dev geoclue-hostip

# WxWidgets is needed for Erlang
sudo apt-get -y install libwxgtk2.8-dev libwxgtk2.8-dbg

# Love 2D for game development
# These are needed by love 2d
sudo apt-get -y install autoconf
sudo apt-get -y install libtool
sudo add-apt-repository ppa:bartbes/love-stable
sudo apt-get -y install love

# Photo editing
sudo apt-get -y install gimp

# Vector graphics
sudo apt-get -y install inkscape

# Visualization library
sudo apt-get -y install graphviz

# Needed for Ruby and PostgreSQL
sudo apt-get -y install libffi-dev autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
# Needed for capybara
sudo apt-get -y install libqt4-dev libqtwebkit-dev

# JavaScript runtime
sudo apt-get -y install nodejs

# Postgres
sudo apt-get -y install postgresql
sudo apt-get -y install libpq-dev # development package

# Install pip so we can install python packages easily
sudo apt-get -y install python-pip

# Zeal Docs
sudo add-apt-repository ppa:zeal-developers/ppa
sudo apt-get update
sudo apt-get -y install zeal

# ReText
sudo apt-get -y install retext

# Enable DVD playback
sudo /usr/share/doc/libdvdread4/install-css.sh

# Install Pandora CLI
sudo apt-get -y install pianobar

# Install Android Debug Bridge
sudo apt-get -y install android-tools-adb

# Install Blender for 3D modeling
sudo apt-get -y install blender

# Install Scribus for publishing
sudo apt-get -y install scribus

# Misc other dependencies
sudo apt-get -y install ncftp python-paramiko python-pycryptopp lftp python-boto python-dev librsync-dev

# Assume we are using Gnome
source gnome.sh

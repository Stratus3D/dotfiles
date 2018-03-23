#!/bin/bash -

###############################################################################
# Set flags so script is executed in "strict mode"
###############################################################################

set -u # Prevent unset variables
set -e # Stop on an error
set -o pipefail # Pipe exit code should be non-zero when a command in it fails
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

###############################################################################
# Install packages with apt-get
###############################################################################

# Make apt-get calls non-interactive
DEBIAN_FRONTEND=noninteractive

# Tools I need for development
# Add apt apt-get repository with latest version of Git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
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
sudo apt-get -y install vagrant
sudo apt-get -y install ansible

# VirtualBox for VMs
sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
wget -q -O - https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install virtualbox-5.2

# Shell script linting
sudo apt-get -y install shellcheck

# Communication apps
sudo apt-get -y install weechat
sudo apt-get -y install thunderbird
sudo apt-get -y install enigmail # For secure email

# For emoji
sudo apt-get -y install ttf-ancient-fonts

# Skype
# Skype is in the canonical partner repository
# https://help.ubuntu.com/community/Skype
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update
sudo apt-get -y install skype

# Google Chrome
sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

# Redshift dependencies
sudo apt-get install -y autopoint intltool libdrm-dev libxcb1-dev libxcb-randr0-dev
#sudo apt-get install -y libgeoclue-dev geoclue-hostip

# WxWidgets is needed for Erlang
sudo apt-get -y install libwxgtk3.0-dev libwxgtk3.0-dbg

# Other packages needed for Erlang
sudo apt-get -y install libgl1-mesa-dev libglu1-mesa-dev libpng3

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

# Install mosh shell for high latency servers
sudo apt-get -y install mosh

# Install iperf so I can test network latency
sudo apt-get -y install iperf3

# Install Blender for 3D modeling
sudo add-apt-repository ppa:thomas-schiex/blender
sudo apt-get update
sudo apt-get -y install blender

# Install Scribus for publishing
sudo apt-get -y install scribus

# Golang, for puma-dev
sudo apt-get -y install golang

# Misc other dependencies
sudo apt-get -y install ncftp python-paramiko python-pycryptopp lftp python-boto python-dev librsync-dev

# For network troubleshooting
sudo apt-get -y install mtr

# Screen recording
sudo apt-get -y install vokoscreen

# Sound recording
sudo apt-get -y install audacity

# Video editing
sudo apt-get -y install kdenlive

# Assume we are using Gnome
source gnome.sh

# Install other software using custom install scripts
install_scripts=(
    # Testing
    bats.sh
    # Color
    redshift.sh
    # JavaScript
    doctorjs.sh
    # Ruby
    prax.sh
    # Erlang
    rebar.sh
    rebar3.sh
    erlgrind.sh
    observer_cli.sh
    recon.sh
    relx.sh
    sync.sh
)

run_install_scripts $install_scripts

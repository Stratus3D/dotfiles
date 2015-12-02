#!/bin/bash -

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
sudo apt-get -y install rbenv

# Communication apps
sudo apt-get -y install irssi
sudo apt-get -y install thunderbird
#sudo apt-get -y install chrome # chrome isn't available

# Hipchat
sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
    /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
sudo apt-get update
sudo apt-get -y install hipchat

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

# Flux for lighting
sudo add-apt-repository ppa:kilian/f.lux
sudo apt-get update
sudo apt-get -y install fluxgui
# TODO: Add flux to list of startup applications

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

# Needed for ruby 2.2.0
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

# Enable DVD playback
sudo /usr/share/doc/libdvdread4/install-css.sh

# Install Pandora CLI
sudo apt-get -y install pianobar

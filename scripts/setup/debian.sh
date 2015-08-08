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
# Install hipchat
sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
      /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install hipchat

# Flux for lighting
sudo add-apt-repository ppa:kilian/f.lux
sudo apt-get update
sudo apt-get install fluxgui
# TODO: Add flux to list of startup applications

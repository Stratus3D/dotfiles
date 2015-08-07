#!/bin/bash -

# Make apt-get calls non-interactive
DEBIAN_FRONTEND=noninteractive

# Tools I need
sudo apt-get -y install git
sudo apt-get -y install zsh
sudo apt-get -y install tmux

# ctags
sudo apt-get install silversearcher-ag
sudo apt-get -y install exuberant-ctags

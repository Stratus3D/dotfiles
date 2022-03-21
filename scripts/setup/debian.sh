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

# Make apt-get calls non-interactive
export DEBIAN_FRONTEND=noninteractive

###############################################################################
# Purge bad packages that may be pre-installed
###############################################################################

# Remove chromium browser if it was installed with apt-get or snap
sudo apt-get purge chromium-browser
sudo snap remove chromium

###############################################################################
# Install packages with apt-get
###############################################################################

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

# Shell script linting
install_or_upgrade shellcheck

# Communication apps
install_or_upgrade weechat
install_or_upgrade thunderbird
install_or_upgrade enigmail # For secure email

# For emoji
install_or_upgrade ttf-ancient-fonts

# Fonts
# For the terminal
install_or_upgrade fonts-inconsolata

# For documents
install_or_upgrade fonts-cmu

# Ungoogled Chromium (Ubuntu Focal)
echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/ /' | sudo tee /etc/apt/sources.list.d/home-ungoogled_chromium.list > /dev/null
curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home-ungoogled_chromium.gpg > /dev/null
sudo apt-get update
install_or_upgrade ungoogled-chromium

# Redshift dependencies
install_or_upgrade autopoint intltool libdrm-dev libxcb1-dev libxcb-randr0-dev
#sudo apt-get install -y libgeoclue-dev geoclue-hostip

# WxWidgets is needed for Erlang
install_or_upgrade libwxgtk3.0-gtk3-dev libpng-dev

# Other packages needed for Erlang
install_or_upgrade libgl1-mesa-dev libglu1-mesa-dev

# Photo editing
install_or_upgrade gimp

# Vector graphics
install_or_upgrade inkscape

# Visualization library
install_or_upgrade graphviz

# For image metadata manipulation
install_or_upgrade exiftool

# Needed for Ruby and PostgreSQL
install_or_upgrade libffi-dev bison libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libgdbm6 libgdbm-dev

# Needed for capybara
install_or_upgrade libqt4-dev libqtwebkit-dev

# Postgres
install_or_upgrade libpq-dev # development package

# Zeal Docs
install_or_upgrade zeal

# Enable DVD playback
install_or_upgrade libdvd-pkg

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

# For encryption and signing, also used by pass
install_or_upgrade gnupg

# For password management
install_or_upgrade pass

# For wrapping shells that don't use readline
install_or_upgrade rlwrap

# Install xsane and dependencies
install_or_upgrade libsane libsane-extras sane-utils xsane

# For duplicati
install_or_upgrade mono-runtime

# For Ebooks
# For library management
install_or_upgrade calibre

# For resizing PDFs for Kindle
install_or_upgrade k2pdfopt

# For converting scanned PDFs to text PDFs
install_or_upgrade ocrmypdf

if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  ./debian/gnome
elif [ "$XDG_CURRENT_DESKTOP" = "LXQt" ] || [ "$XDG_CURRENT_DESKTOP" = "LXDE" ]; then
  ./debian/lxde
fi

# Assume we are using Gnome Nautilus file manager
# Easy right click image conversion operations
install_or_upgrade nautilus-image-converter

# Install other software using custom install scripts
run_install_scripts

# This needs to be run after tmux installation
$HOME/dotfiles/scripts/setup/tmux.sh

# Fix annoying pulseaudio settings, if not already there
# Taken from https://lobste.rs/s/kst05r/disable_flat_volume_for_pulseaudio
if ! grep -c "flat-volumes = no" "$HOME/.pulse/daemon.conf"; then
    echo "flat-volumes = no" >> "$HOME/.pulse/daemon.conf"
fi

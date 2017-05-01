#!/bin/bash -

###############################################################################
# Set flags so script is executed in "strict mode"
###############################################################################

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

###############################################################################
# Run thoughtbot's laptop script and install missing packages with brew
###############################################################################

# Get the directory this script is stored in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Use thoughtbot's laptop script to set everything up
"$DIR/laptop.sh"

# Exuberant Ctags
brew install ctags

# Visualization library
brew install graphviz
brew link graphviz

# Install command-line JSON processor
brew install jq

# WxWidgets for Erlang
brew install wxmac --with-static --with-stl --universal

# Install pianobar for music
brew install pianobar

# QCacheGrind for valgrind analysis
brew install qcachegrind --with-graphviz
brew linkapps qcachegrind

# Install GNU readlink
brew install coreutils

# autoexpect
brew install expect

# For adb
brew install android-platform-tools

# Mosh for high latency remote servers
brew install mobile-shell

# Yarn for package management
brew install yarn

# Elm for packages that require it
brew install elm

# For network troubleshooting
brew install mtr

# Install other software using custom install scripts
install_scripts=(
    # Testing
    bats.sh
    # JavaScript
    doctorjs.sh
    # Ruby
    prax.sh
    # Erlang
    erlgrind.sh
    observer_cli.sh
    rebar.sh
    rebar3.sh
    recon.sh
    relx.sh
    sync.sh
    # OSX only
    osxfuse.sh
    zeal.sh
)

run_install_scripts $install_scripts

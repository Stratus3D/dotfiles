#!/usr/bin/env bash
#
# Build and install CHIRP.
#
# Usage ./chirp.sh
#
# I used these pages to come up with this script:
#
# * https://chirp.danplanet.com/projects/chirp/wiki/Running_Under_Linux
# * https://chirp.danplanet.com/projects/chirp/wiki/Connection_Issues_using_Ubuntu
#

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Add the PPA contain chirp
sudo apt-add-repository ppa:dansmith/chirp-snapshots -y

# Get the packages from the PPA
sudo apt-get update

# Install the chirp-daily package
sudo apt-get install chirp-daily

# Give my user permission to use the USB connection so chirp can use it when
# running as me.
sudo gpasswd --add ${USER} dialout

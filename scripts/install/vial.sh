#!/usr/bin/env bash

# Unofficial Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings

# Usage:
#
# ./vial.sh
#
# This script is for installing the Vial GUI app on Ubuntu only. On MacOS use
# brew to install vial.

error_exit() {
  printf "%s\n" "$1" 1>&2
  exit "${2:-1}" # default exit status 1
}

INSTALL_DIR="$HOME/lib/vial"
APP_IMAGE="$INSTALL_DIR/Vial-v0.7-x86_64.AppImage"

# Create directory for app image if doesn't already exist
mkdir -p "$INSTALL_DIR"

if [ -f "$APP_IMAGE" ]; then
  error_exit "App image already exists"
fi

# Download app image
cd "$INSTALL_DIR"
curl -Ls https://github.com/vial-kb/vial-gui/releases/download/v0.7/Vial-v0.7-x86_64.AppImage --output "$(basename $APP_IMAGE)"

# Make executable
chmod a+x "$APP_IMAGE"

# Create symlink to ~/bin dir already on path
ln -s "$APP_IMAGE" ~/bin/vial

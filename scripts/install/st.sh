#!/usr/bin/env bash

# Unofficial Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# This script builds my own custom build of simple terminal by applying various
# patches
#
# My patches here are heavily inspired by
#
# https://github.com/lukesmithxyz/st
# https://github.com/BreadOnPenguins/st

st_patch_dir="$(realpath "$(dirname -- "${BASH_SOURCE[0]}")/st")"

# Create temp directory for the build
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

echo "Working in $TEMP_DIR"

# Clone source code
git clone git://git.suckless.org/st --branch 0.9.3 2> /dev/null
cd st/

# Apply patches

# Theme patch
cat "$st_patch_dir/theme.diff" | git apply -

# Enforce minimum contrast between background and foreground colors for every character
curl https://st.suckless.org/patches/minimum_contrast/st-minimumcontrast-20241029-0.9.2.diff | git apply -

# Scrollback ringer buffer
curl https://st.suckless.org/patches/scrollback/st-scrollback-ringbuffer-0.9.2.diff | git apply -

# Scroll with Shift-Mousewheel
curl https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff | git apply -

# Patches I want to try
#curl https://st.suckless.org/patches/undercurl/st-undercurl-0.9-20240103.diff | git apply -
#curl https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.4.diff | git apply -
#curl https://st.suckless.org/patches/clickurl-nocontrol/st-clickurl-nocontrol-0.9.2.diff | git apply -

# Clean dir
make clean

# Build st binary
make

# Copy st binary into place
cp st $HOME/bin/st

# Remove temp dir
rm -rf $TEMP_DIR

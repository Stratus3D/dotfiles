#!/usr/bin/env bash
#
# Build and install the zeal app on OSX. Places it in the /Applications directory
#
# Usage ./zeal.sh

# Used these links to come up with this set of steps:
#
# * https://github.com/zealdocs/zeal/wiki/Build-Instructions-for-OS-X
# * http://mazhuang.org/2016/01/16/build-zeal-for-mac-osx/
# * https://github.com/zealdocs/zeal/pull/372

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

# Create temp directory for the download
TEMP_DIR=$(mktemp -dt "$(basename $0).XXXXXX")
echo "Created temp directory $TEMP_DIR"
cd $TEMP_DIR

filename="gramps_5.0.1-1_all.deb"

# Download
curl -L https://github.com/gramps-project/gramps/releases/download/v5.0.1/gramps_5.0.1-1_all.deb --output $filename

# Install
sudo dpkg -i $filename

# Remove temp directory
rm -rf $TEMP_DIR

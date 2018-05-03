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

TESTSSL_VERSION="2.8"
SCRIPT_URL="https://github.com/drwetter/testssl.sh/raw/$TESTSSL_VERSION/testssl.sh"

BIN_DIR="$HOME/bin"

cd "$BIN_DIR"
rm "testssl.sh" || true
wget "$SCRIPT_URL"
chmod +x testssl.sh

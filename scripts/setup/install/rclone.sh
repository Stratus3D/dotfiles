#!/usr/bin/env bash
#
# Build and install the rclone. Places it in the $GOPATH/bin directory
#
# Usage ./zeal.sh

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

go get -u -v github.com/ncw/rclone

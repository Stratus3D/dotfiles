#!/usr/bin/env bash
#
# Download and install youtube-dl
#
# Usage ./youtube-dl.sh

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

curl -L https://yt-dl.org/downloads/latest/youtube-dl -o $HOME/bin/youtube-dl
chmod a+rx $HOME/bin/youtube-dl

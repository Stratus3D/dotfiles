#!/usr/bin/env bash

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

# Download osxfuse
curl -OL https://github.com/osxfuse/osxfuse/releases/download/osxfuse-3.5.3/osxfuse-3.5.3.dmg

# Download sshfs
curl -OL https://github.com/osxfuse/sshfs/releases/download/osxfuse-sshfs-2.5.0/sshfs-2.5.0.pkg

# TODO: Figure out how to install the dmg and the pkg
echo "Installation script incomplete. Please install the dmg and the pkg manually."

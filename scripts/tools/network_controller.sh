#! /bin/bash -

# Provides a simple interface to allow enable and disabling of network interfaces
# quickly.

# TODO:
# * Implement commands for other platforms besides OSX

#set -u # Prevent unset variables
set -e # Stop on an error

name=$(basename $0);

usage () {
    cat <<EOF
    Turn a given network interface on or off.

    Usage:
    $name INTERFACE off            Turn network INTERFACE off
    $name INTERFACE on             Turn network INTERFACE on
EOF
}
# Get the name of the platform running this script
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
platform=$("$dir/platform_name.sh");

interface=$1
command=$2

off_command=""
on_command=""
if [[ "$platform" == 'darwin' ]]; then
    off_command="sudo ifconfig $interface down";
    on_command="sudo ifconfig $interface up";
else
    echo "Not implemented";
    exit 1;
fi

if [[ "$command" == 'on' ]]; then
    echo "Turning $interface interface on...";
    eval "$on_command";
elif [[ "$command" == 'off' ]]; then
    echo "Turning $interface interface off...";
    eval "$off_command";
else
    usage
fi

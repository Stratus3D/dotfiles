#! /bin/bash -

# Provide the name of the current operating system.

set -u # Prevent unset variables
set -e # Stop on an error

# Default to 'unknown'
platform='unknown'
unamestr=$(uname)

if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
    platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='darwin'
fi

echo $platform

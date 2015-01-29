#! /bin/bash

# Provides a simple interface for installing and managing Erlang versions. Uses
# kerl underneath for the actual downloading and building of the Erlang source.

# TODO
# * Complete script
# * Write the usage message.

set -u # Prevent unset variables
set -e # Stop on an error

usage()
{
    cat <<EOF
    Usage: erlang_manager [command] [args ...]

    Commands:
    install_latest                      Install the latest version of Erlang available via kerl
    list [available|built|installed]    List Erlang versions
    show [version]                      Show the details of an installation
    xxxadd [profile, host ...]    add a host to be blocked
    rm [profile, host ...]     remove hosts from block

    Flags:
    --install-dir
EOF
}

ARR1=$(kerl list releases)
echo ${ARR1[${#ARR1[@]}-1]}

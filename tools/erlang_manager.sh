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
    install [version]                   Install an erlang version via kerl
    list [available|built|installed]    List Erlang versions
    show [version]                      Show the details of an installation

    Flags:
    --install-dir                       Override default erlang install directory
EOF
}

# Use `$HOME/.erlang_versions/` as the default user, unless one is specified in an argument.
INSTALL_DIR=$HOME/.erlang_versions/
if [ $# -gt 0 ]; # TODO: check if --install-dir flag is set and use that instead
then
    INSTALL_DIR=$1
fi

#ARR1=$(kerl list releases)
#echo ${ARR1[${#ARR1[@]}-1]}

if [ $# -gt 0 ]; then
    case $1 in
        'install_latest')
            echo "TODO: write this command";;
        'install')
            echo "TODO: write this command";;
        'ls' | 'list')
            echo "TODO: write this command";;
        'show')
            echo "TODO: write this command";;
        *)
            usage;;
    esac
else
    usage;
fi

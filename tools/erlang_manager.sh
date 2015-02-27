#! /bin/bash

# Provides a simple interface for installing and managing Erlang versions. Uses
# kerl underneath for the actual downloading and building of the Erlang source.

# TODO
# * Complete script
# * Write the usage message.

set -u # Prevent unset variables
set -e # Stop on an error

# Get the name of the platform running this script
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
PLATFORM=$("$SCRIPT_DIR/platform_name.sh");
ERLANG_DOWNLOAD_URL=http://www.erlang.org/download
case "$PLATFORM" in # Set sed options
    darwin|FreeBSD|OpenBSD)
        SED_OPT=-E
        ;;
    *)
        SED_OPT=-r
        ;;
esac

# Use `$HOME/.erlang_versions/` as the default user, unless one is specified in an argument.
INSTALL_DIR=$HOME/.erlang_versions/
#if [ $# -gt 0 ]; # TODO: check if --install-dir flag is set and use that instead
#then
#    INSTALL_DIR=$1
#fi

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


get_available_releases() {
    curl -L -s $ERLANG_DOWNLOAD_URL/ | \
        sed $SED_OPT -e 's/^.*<[aA] [hH][rR][eE][fF]=\"\/download\/otp_src_([-0-9A-Za-z_.]+)\.tar\.gz\">.*$/\1/' \
        -e '/^R1|^[0-9]/!d' | \
        sed -e "s/^R\(.*\)/\1:R\1/" | sed -e "s/^\([^\:]*\)$/\1-z:\1/" | sort | cut -d':' -f2
}

check_available_releases() {
    echo "Getting the available releases from erlang.org..."
    echo $(check_available_releases)
}

get_installed_releases() {
    ls $INSTALL_DIR
}

if [ $# -gt 0 ]; then
    case $1 in
        'install_latest')
            echo "TODO: write this command";;
        'install')
            echo $
            echo "TODO: write this command";;
        'ls' | 'list')
            check_available_releases;;
        'show')
            echo "TODO: write this command";;
        *)
            usage;;
    esac
else
    usage;
fi

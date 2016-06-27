#! /bin/bash -

set -u # Prevent unset variables
set -e # Stop on an error

usage() {
    cat <<EOF
    Usage: to_server.sh [options]

    Commands:
    site [url] [destination dir]         Download all pages on the domain
    subdirectory [url] [destination dir] Download URL and sub pages
    single_page [url] [destination dir]  Download a single URL

    Options:
    --no-localize                        Don't localize links. With this option
                                         URLs may not work on your local copy
EOF
}

error_exit() {
    usage
    exit 1
}

sync() {
    source_dir=${0-"."}
    destination_server=${1-"localhost"}
    destination_dir=${2-"."}
    rsync -p -r --exclude='.git' $source_dir $destination_server:$destination_dir
}

while getopts ":s:m:d:" opt; do
    case "${opt}" in
        s)
            s=${OPTARG}
            ;;
        m)
            m=${OPTARG}
            ;;
        m)
            m=${OPTARG}
            ;;
        *)
            error_exit
            ;;
    esac
done

shift $((OPTIND-1))

if [ $# -gt 2 ]; then
    sync $0 $1 $2
else
    error_exit
fi

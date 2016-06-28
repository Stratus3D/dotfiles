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
    source_dir=$0
    destination_server=$1
    destination_dir=$2
    rsync -p -r --exclude='.git' $source_dir $destination_server:$destination_dir
}

get_value() {
    first=${1#*=}
    second=$2

    if [ -z "$first" ]; then
        if [[ $second == "-*" ]]; then
            echo ""
        else
            echo $second
        fi
    else
        echo $first
    fi
}

destination_dir=""
destination_server=""

while :; do
    case $1 in
        -h|-?|--help)
            usage
            exit
            ;;
        -s|--source|--source=)
            s_dir=${1#*=}
            ;;
        -m|--destination_server|--destination_server=)
            destination_server=$(get_value $1 $2)
            ;;
        -d|--destination_dir|--destination_dir=)
            destination_dir=$(get_value $1 $2)
            ;;
        *)
            error_exit
    esac

    shift
done

source_dir=${s_dir-"."}

if [ -z "$destination_server" ] || [ -z "$destination_dir" ]; then
    error_exit
else
    sync $source_dir $destination_server $destination_dir
fi

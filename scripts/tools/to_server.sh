#! /bin/bash -

set -u # Prevent unset variables
set -e # Stop on an error

usage() {
    cat <<EOF
    Usage: to_server.sh [options]

    Options:
    --destination_server                 Hostname of the remote server to rsync
                                         the files to
    --destination_dir                    Path the directory on the remote server
    --source_dir                         The directory to rsync to the server
EOF
}

error_exit() {
    usage
    exit 1
}

sync() {
    source_dir=$1
    destination_server=$2
    destination_dir=$3
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
    case ${1:-} in
        -h|-\?|--help)
            usage
            exit
            ;;
        -s|--source|--source=*)
            s_dir=$(get_value $1 ${2-""})
            ;;
        -m|--destination_server|--destination_server=*)
            destination_server=$(get_value $1 ${2:-""})
            ;;
        -d|--destination_dir|--destination_dir=*)
            destination_dir=$(get_value $1 ${2:-""})
            ;;
        --)
            shift
            break
            ;;
        *)
            if [ -z "${1:-}" ]; then
                break
            else
                echo "Unknown option ${1:-}"
                error_exit
            fi
    esac

    shift
done

source_dir=${s_dir-"."}

if [ -z "$destination_server" ] || [ -z "$destination_dir" ]; then
    error_exit
else
    echo "Syncing $source_dir to $destination_server:$destination_dir"
    sync $source_dir $destination_server $destination_dir
    echo "Complete sync of $source_dir"
fi

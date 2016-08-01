#! /bin/bash -

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

usage() {
    cat <<EOF
    Usage: to_server.sh [options]

    Options:
    --destination_server                 Hostname of the remote server to rsync
                                         the files to
    --destination_dir                    Path the directory on the remote server
    --source                             The directory to rsync to the server
    --exclude-gitignored                 Exclude files that match the patterns
                                         in the gitignores
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
    exclude_gitignored=$4
    set -x
    if [ "$exclude_gitignored" = true ]; then
        rsync -p -r --exclude='.git' $source_dir $destination_server:$destination_dir --exclude='/.git' --filter='dir-merge,- .gitignore .gitignore_global'
    else
        rsync -p -r --exclude='.git' $source_dir $destination_server:$destination_dir
    fi
    set +x
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
exclude_gitignored=false

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
        -g|--exclude-gitignored)
            exclude_gitignored=true
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
    sync $source_dir $destination_server $destination_dir $exclude_gitignored
    echo "Complete sync of $source_dir"
fi

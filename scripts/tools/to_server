#! /bin/bash -

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
#ORIGINAL_IFS=$IFS
IFS=$'\t\n' # Stricter IFS settings

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
    --delete                             Delete files on the target server that
                                         no longer exist in the source directory
    --include-repo                       Whether or not to sync the git
                                         repository. Defaults to false.
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
    delete=$5
    include_dot_git=$6

    # Base command
    command_array=(-p -r $source_dir $destination_server:$destination_dir)

    if [ "$exclude_gitignored" = true ]; then
        command_array+=(--filter='dir-merge,- .gitignore .gitignore_global')
    fi

    if [ "$include_dot_git" = false ]; then
        command_array+=(--exclude='.git')
    fi

    if [ "$delete" = true ]; then
        command_array+=(--delete)
    fi

    set -x
    rsync "${command_array[@]}"
    set +x
}

get_value() {
    first=${1#*=}
    second=$2

    # TODO: Use sed to parse the arguments?
    #export OUTPUT=`echo $1 | sed -e 's/^[^=]*=//g'`
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
delete=false
include_dot_git=false

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
        -f|--delete)
            delete=true
            ;;
        -r|--include-repo)
            include_dot_git=true
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
    sync $source_dir $destination_server $destination_dir $exclude_gitignored $delete $include_dot_git
    echo "Complete sync of $source_dir"
fi

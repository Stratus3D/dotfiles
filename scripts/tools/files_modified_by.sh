#! /bin/bash -

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

usage() {
    cat <<EOF
    Usage: files_modified_by_user.sh [command] [user]

    Commands:
    committer [user]          List all files modified by committer
    author [user]             List all files modified by author
EOF
}

list_files() {
    user_type=$1;
    name=$2;

    case $user_type in
        'committer')
            git log --no-merges --stat --committer="$name" --name-only --pretty=format:"" | sort -u;;
        'author')
            git log --no-merges --stat --author="$name" --name-only --pretty=format:"" | sort -u;;
    esac
    #git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10
}


if [ $# -gt 1 ]; then
    lower_command=$(echo $1 | awk '{print tolower($0)}');

    case $lower_command in
        'committer')
            list_files committer $2;;
        'author')
            list_files author $2;;
        *)
            usage;;
    esac
else
    usage;
fi

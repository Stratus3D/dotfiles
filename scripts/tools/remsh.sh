#! /usr/bin/env bash -

# Provides an easy way of running an Erlang remote shell (remsh).

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

usage() {
    cat <<EOF
    Usage info here...
EOF
}

target="${1:-}"
erlang_cookie="${2:-}"
short_name="$( id -un )_$( date +%s )"

if [[ -z "$target" ]]
then
    echo "ERROR: no node name specified"
    usage
    exit 1
fi

if [[ -z "$erlang_cookie" ]]
then
    echo "ERROR: no Erlang cookie specified"
    usage
    exit 1
fi

if echo $target | grep -q @ 2>/dev/null
then
    remote_node=$target
else
    remote_node="$target@$( hostname -s )"
fi

set -x # Show debug info when running the erl command
erl -sname "$short_name" -setcookie "$erlang_cookie" -hidden -remsh $remote_node

#!/bin/bash
# This is still a work in progress. I want to make this handle both custom host
# files.
usage()
{
    cat <<EOF
    Usage: hosts_manager  [command] [host1 host2 ...]

    Commands:
    list                list blocked hosts
    add [host ...]      add a host to be blocked
    rm [host ...]       remove hosts from block
    start               start blocking
    stop                stop blocking
    EOF
}

# Put the original in the dotfiles repo, so it shows up with git status
VARDIR="$HOME/dotfiles"

# HOST_FILE - actual host file to be swapped around.
# ORIG_FILE - original host file without any of the appended blocked hosts.
# BLCK_FILE - list of blocked hosts.
# BLCK_TEMP - temporary file used when removing hosts.

HOST_FILE="/etc/hosts"
ORIG_FILE="$VARDIR/original_host"
BLCK_FILE="$VARDIR/blocked_host"
BLCK_TEMP=`mktemp -t "blocked_hosts"` || `mktemp /tmp/blocked_hosts.XXXXXXX` || exit 1

# Make sure files exist.
[[ -e $ORIG_FILE ]] || touch "$ORIG_FILE"
[[ -e $BLCK_FILE ]] || touch "$BLCK_FILE"

# Check to see if the block is currently active.
ACTIVE_FLAG="$HOME/.wrk_block.flag"
if [[ -e $ACTIVE_FLAG ]]; then 
    IS_ACTIVE=0
else 
    IS_ACTIVE=1
fi

add_host()
{
    local hosts=("$@")
    for host in "${hosts[@]:1}"; do
        # append host to blocked hosts list
        echo "127.0.0.1 $host" >> "$BLCK_FILE"
        echo -e "\033[0;32madded\033[0m $host" 
    done
}

# todo: remove need for loop; do in one go
rm_host()
{
    local hosts=("$@")
    for host in "${hosts[@]:1}"; do
        # overwrite host list file with a copy removing a certain host
        awk -v host=$host 'NF==2 && $2!=host { print }' "$BLCK_FILE" > "$BLCK_TEMP"
        mv "$BLCK_TEMP" "$BLCK_FILE"
        echo -e "\033[0;31mremoved\033[0m $host" 
    done
}

check_root()
{
    if [[ "`whoami`" != "root" ]]; then
        echo "You don't have sufficient priviledges to run this script (try sudo.)"
        exit 1
    else 
        [[ -e $HOST_FILE ]] || { echo "Can't find or access host file."; exit 1; }
    fi
}

start_block()
{
    if [[ $IS_ACTIVE -ne 0 ]]; then
        cp "$HOST_FILE" "$ORIG_FILE"
        cat "$BLCK_FILE" >> "$HOST_FILE"
        touch "$ACTIVE_FLAG"
        echo "Block started."
    else
        echo "Already blocking."
    fi
}

stop_block()
{
    if [[ $IS_ACTIVE -eq 0 ]]; then
        cp "$ORIG_FILE" "$HOST_FILE"
        [[ -e $ACTIVE_FLAG ]] && rm "$ACTIVE_FLAG"
        echo "Stopped blocking."
    else
        echo "Not blocking."
    fi
}

case $1 in
    'ls' | 'list') 
        awk 'NF == 2 { print $2 }; END { if (!NR) print "Empty" }' "$BLCK_FILE";;
    'add') 
        [[ -z $2 ]] && { usage; exit 1; }
        add_host $@;;
    'rm' | 'remove') 
        [[ -z $2 ]] && { usage; exit 1; }
        rm_host $@;;
    'start') 
        check_root
        start_block;;
    'stop') 
        check_root
        stop_block;;
    *)
        usage;;
esac

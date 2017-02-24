#!/usr/bin/env bash

# Directory I have chosen to mount remote file systems
SERVERS_DIR=$HOME/servers

ensure_server_fs_mounted() {
    server=$1

    # Extract the hostname from the FQDN
    hostname=$(echo "$server" | awk -F. '{ print $1 }')

    mount_point="$SERVERS_DIR/$hostname"

    # Mount my home directory on the remote server
    server_and_dir=$server:/home/$(whoami)

    ensure_sshfs_mounted $mount_point $server_and_dir
}

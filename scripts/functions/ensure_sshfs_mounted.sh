#!/usr/bin/env bash

SSHFS_OPTIONS="reconnect,defer_permissions,noappledouble,nolocalcaches,no_readahead,allow_other,cache=no"

ensure_sshfs_mounted() {
    mount_point=$1
    server_and_dir=$2
    drive_name=$(basename $mount_point)

    # Unmount first to be safe
    umount $mount_point

    # Ensure the directory exists
    mkdir -p $mount_point

    # Mount
    sshfs $server_and_dir $mount_point -ovolname=$drive_name -o$SSHFS_OPTIONS
}

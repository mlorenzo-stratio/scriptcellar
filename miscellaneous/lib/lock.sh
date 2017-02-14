#!/bin/bash
# Taken from http://www.kfirlavi.com/blog/2012/11/06/elegant-locking-of-bash-program/

readonly PROGNAME=$(basename "$0")
readonly LOCKFILE_DIR=/dev/shm
readonly LOCK_FD=200

# Lock with no blocking
lock() {
    if [ $# = 0 ]; then
        echo "Usage: lock <name> <file_descriptor>"
        exit 255
    fi
    local prefix=$1
    local fd=${2:-$LOCK_FD}
    local lock_file=$LOCKFILE_DIR/${prefix}-FD${fd}.lock

    # create lock file
    eval "exec $fd>$lock_file"

    # acquire the lock
    flock -n "$fd" \
        && return 0 \
        || return 1
}

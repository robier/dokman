#!/usr/bin/env bash


###
 # Function that will import all variables defined in env file
 #
 # @param1 string Path to env file
###
function importEnv
{
    local path=${1}

    if [ -f "${path}" ]; then
        set -a
        source "${path}"
        set +a
    fi
}

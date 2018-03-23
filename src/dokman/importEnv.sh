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
        # first regex removes comments (line starting with #, can have spaces before # char)
        # second one removes empty lines (can have spaces)
        export $(grep -v "^\(\s\+\)\?#" "${path}" | grep -v "^\(\s\+\)\?$" | xargs) > /dev/null
    fi
}

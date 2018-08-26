#!/usr/bin/env bash

###
 # Runs provided command and do not write STDOUT if variable DOKMAN_VERBOSE is set to 0
###
function runCommand
{
    local command="${1}"
    local message="${2}"

    if [ -n "${message}" ]; then
        info "${message}"
    fi

    if isVerbose; then
        eval "${command}"
    else
        eval "${command} > /dev/null"
    fi
}

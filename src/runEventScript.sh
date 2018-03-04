#!/usr/bin/env bash

###
 # Sources event script from provided path if file exists
 #
 # @param1 string Environments path
 # @param string Event name
###
function runEventScript
{
    local path=${1}
    local event=${2}

    if [ -f "${path}" ]; then
        return
    fi

    local commandPath="${path}/${event}.sh"

    if [ -f "${commandPath}" ]; then
        info "Running event $(foregroundColor "${event}" "yellow") (script $(foregroundColor "${commandPath}" "yellow"))"
        /bin/bash ${commandPath}
    fi
}

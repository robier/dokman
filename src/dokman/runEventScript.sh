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

    local commandPath="${path}/events/${event}.sh"
    local currentPwd="$(pwd)"

    if [ -f "${commandPath}" ]; then
        info "Running event $(foregroundColor "${event}" "yellow") (script $(foregroundColor "${commandPath}" "yellow"))"

        cd "${DOKMAN_PROJECT_ROOT}"
        source "${commandPath}"
        cd "${currentPwd}"
    fi
}

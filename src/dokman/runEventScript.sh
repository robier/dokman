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
    local eventNameStyled=$(foregroundColor "${event}" "yellow")

    if [ -f "${commandPath}" ]; then

        local icon
        icon=$(foregroundColor "e" "cyan")

        write '' >&2 # spacing
        write "[${icon}] Running event ${eventNameStyled} (script $(foregroundColor "${commandPath}" "yellow"))" >&2

        cd "${DOKMAN_PROJECT_ROOT}"
        source "${commandPath}"
        cd "${currentPwd}"

        write "[${icon}] Event ${eventNameStyled} finished" >&2
    fi
}

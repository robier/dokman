#!/usr/bin/env bash


###
 # Checks if given program is installed
 #
 # @param1 string Program name
 # @return bool
###
function isProgramInstalled
{
    local found=$(type -P ${1})

    if [ -n ${found} ]; then
        return
    fi

    false
}

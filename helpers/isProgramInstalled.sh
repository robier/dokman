#!/usr/bin/env bash


###
 # Checks if given program is installed
 #
 # @param1 string Program name
 # @return bool
###
function isProgramInstalled
{
    if [ -n "$(type -P ${1})" ]; then
        return
    fi

    false
}

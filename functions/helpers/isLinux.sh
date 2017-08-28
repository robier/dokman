#!/usr/bin/env bash

###
 # Check if current machine is Linux based
 #
 # @returns boolean
###
function isLinux
{
    if [[ $(uname -s) == "Linux" ]]; then
        return 0
    fi
    return 1
}

export -f isLinux
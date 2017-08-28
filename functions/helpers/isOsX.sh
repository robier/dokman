#!/usr/bin/env bash

###
 # Check if current machine is Mac
 #
 # @returns boolean
###
function isOsX
{
    if [[ $(uname) == "Darwin" ]]; then
        return 0
    fi
    return 1
}

export -f isOsX
#!/usr/bin/env bash

###
 # Check if current machine is Mac
 #
 # @returns boolean
###
function isOsX
{
    if [[ $(uname) == "Darwin" ]]; then
        return
    fi

    false
}

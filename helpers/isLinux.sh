#!/usr/bin/env bash

###
 # Check if current machine is Linux based
 #
 # @returns boolean
###
function isLinux
{
    if [[ $(uname -s) == "Linux" ]]; then
        return
    fi

    false
}

#!/usr/bin/env bash

###
 # Checks if first param is in array
 #
 # @param1 string Search
 # @param2 array
###
function inArray
{
    local search="${1}"
    local array=${@:2}

    for item in ${array[@]}
    do
        [ "${item}" == "${search}" ] && return
    done

    false
}

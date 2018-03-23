#!/usr/bin/env bash

###
 # Removes searched item from provided array
 #
 # @param1 string Search
 # @param2 array
###
function removeArrayItem
{
    local search="${1}"
    local array=("${@:2}")

    local newArray=()

    for item in "${array[@]}"
    do
        if [ "${item}" == "${search}" ]; then
            continue
        fi

        newArray+=("${item}")
    done

    echo "${newArray[@]}"
}

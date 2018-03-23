#!/usr/bin/env bash


###
 # Checks if provided env file or directory exists
 #
 # @param1 string Path to environments folder
###
function hasEnv
{
    local path=${1}
    local name=${2}
    local fullPath

    fullPath=$(environmentFilePath "${path}" "${name}")

    if [ -d "${fullPath}" ] || [ -f "${fullPath}" ]; then
        return
    fi

    false
}

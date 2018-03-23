#!/usr/bin/env bash


###
 # Checks if provided env directory has all files needed
 #
 # @param1 string Path to environments folder
 # @param string Environments name
###
function validateEnv
{
    local path=${1}
    local env=${2}

    local file="${path}/${env}"

    if [ -d "${file}" ] || [ -f "${file}" ]; then
        return
    fi

    false
}

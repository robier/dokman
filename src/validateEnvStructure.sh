#!/usr/bin/env bash


###
 # Validate provided environment directory structure
 #
 # @param1 string Path to env folder
 # @param string Env name
###
function validateEnvStructure
{
    local path=${1}
    local env=${2}

    local directory=$(environmentFilePath ${path} ${env})

    if [ -d "${directory}" ]; then
        return
    fi

    false
}

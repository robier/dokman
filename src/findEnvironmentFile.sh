#!/usr/bin/env bash

###
 # Finds right env file path
 #
 # @param1 Path to env folder
 # @prints Found env file path name
 # @exits If env file is not find in the system
###
function findEnvironmentFile
{
    local path=${1}
    local envFile

    if [ -d ${path} ] && [ -f "${path}/config" ]; then
        # load file from environments sub-folder
        envFile="${path}/config"
    else
        # load file from environments folder
        envFile="${path}"
    fi

    if [ ! -f ${envFile} ]; then
        error "Environment file $(foregroundColor ${path} "yellow") or $(foregroundColor "${path}/config" "yellow") does not exist!"
        exit 1
    fi

    echo ${envFile}
}

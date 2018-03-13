#!/usr/bin/env bash

###
 # Import project name from provided file
 #
 # @param1 Path to file
 # @exports COMPOSE_PROJECT_NAME
###
function importProjectName
{
    local fileName=${1}

    if [ -f ${fileName} ]; then
        export COMPOSE_PROJECT_NAME=$(cat ${fileName})
        return
    fi

    false
}

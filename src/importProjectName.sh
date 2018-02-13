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

    { if [ ! -f ${fileName} ]; then
        error "Could not import project name from file ${fileName}!"
        exit 1
    fi }

    export COMPOSE_PROJECT_NAME=$(cat ${fileName})
}

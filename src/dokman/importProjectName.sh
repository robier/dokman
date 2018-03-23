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
    local COMPOSE_PROJECT_NAME

    if [ -f "${fileName}" ]; then
        COMPOSE_PROJECT_NAME=$(cat "${fileName}")
        export COMPOSE_PROJECT_NAME
        return
    fi

    false
}

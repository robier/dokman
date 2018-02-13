#!/usr/bin/env bash


###
 # Function that will import all variables defined in env file
 #
 # @param1 Path to env file
###
function importEnv
{
    local path=${1}

    { if [ -f ${path} ]; then
        export $(cat ${path} | grep -v ^# | xargs) > /dev/null
        return 0
    fi }

    return 1
}
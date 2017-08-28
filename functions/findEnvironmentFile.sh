#!/usr/bin/env bash

###
 # Finds right env file path
 #
 # @param1 Path to env folder
 # @param2 Env name
 # @prints Found env file path name
 # @exits If env file is not find in the system
###
function findEnvironmentFile
{
    local path=${1}
    local env=${2}
    local envPath="${path}/${env}"
    local envFile

    { if [[ -d ${envPath} ]]; then
        if isOsX ; then
            envFile="${envPath}/osx"
        fi
        if isLinux ; then
            envFile="${envPath}/linux"
        fi
        # @todo maybe add windows too...
#        if isWin32 ; then
#            envFile="${path}/win32"
#        fi
#        if isWin64 ; then
#            envFile="${path}/win64"
#        fi
    else
        envFile="${path}/${env}"
    fi }

    { if [[ ! -f ${envFile} ]]; then
        writeError "File ${envFile} does not exist! Aborting!"
    fi }

    echo ${envFile}
}
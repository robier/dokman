#!/usr/bin/env bash

###
 # Imports env variables from .defaults and .env files
 #
 # @param1 Path to docker folder where .defaults and .env files are
###
function importConfigs
{
    local path=${1}

    # check if file .defaults does not exists
    local defaultsPath="${path}/.defaults"
    if [ ! -r ${defaultsPath} ]; then
        writeError "File missing ${defaultsPath}"
    fi
    # import default env variables
    importEnv "${path}/.defaults"

    # Override any environment variables that the developer may have set
    # only if that file exists
    local envPath="${path}/.env"
    if [ -r ${envPath} ]; then
        importEnv "${path}/.env"
    fi
}
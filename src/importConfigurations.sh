#!/usr/bin/env bash

###
 # Imports env variables from .defaults and .env files and sources .bootstrap from provided path
 #
 # @param1 string Path to docker folder where .defaults and .env files are
 # @return bool Returns false if provided path is not a directory, ie. config could not be loaded
###
function importConfigurations
{
    local path=${1}
    local bootstrapFile

    if [ ! -d "${path}" ]; then
        return
    fi

    importEnv "${path}/.defaults"
    importEnv "${path}/.env"

    bootstrapFile="${path}/.bootstrap"
    if [ -f "${bootstrapFile}" ]; then
        source "${bootstrapFile}"
    fi

    true
}

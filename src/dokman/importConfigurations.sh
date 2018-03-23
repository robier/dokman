#!/usr/bin/env bash

###
 # Imports env variables from .env.dist and .env files and sources .bootstrap.sh from provided path
 #
 # @param1 string Path to docker folder where .env.dist and .env files are
 # @return bool Returns false if provided path is not a directory, ie. config could not be loaded
###
function importConfigurations
{
    local path=${1}
    local bootstrapFile

    if [ ! -d "${path}" ]; then
        return
    fi

    importEnv "${path}/.env.dist"
    importEnv "${path}/.env"

    bootstrapFile="${path}/.bootstrap.sh"
    if [ -f "${bootstrapFile}" ]; then
        source "${bootstrapFile}"
    fi

    true
}

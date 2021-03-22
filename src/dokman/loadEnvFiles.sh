#!/usr/bin/env bash

###
 # Load dokman specific env files
 #
 # @param1 string Dokman dir
 # @param2 string Path to docker directory
 # @param3 string Environment file name to load
###
function loadEnvFiles
{
    local dokmanDir=${1}
    local path=${2}
    local env=${3}

    local environmentPath
    local projectNamePath

    environmentPath=$(environmentFilePath "${path}" "${env}")
    projectNamePath=$(projectNameCacheFilePath "${dokmanDir}")

    if ! hasEnv "${path}" "${env}" ; then
        error "Environment $(foregroundColor "${env}" "yellow") is not defined in environments directory"
        exit 1
    fi

    # import current user and group
    importCurrentUserGroup

    # import docker host IP
    importDockerHostIP

    if [ ! -f "${path}/.env.dist" ]; then
        error "Missing main $(foregroundColor ".env.dist" "yellow") file"
        exit 1
    fi

    # import .env.dist and .env files
    importConfigurations "${path}"
    # import env specific config if needed
    importConfigurations "${environmentPath}"

    handleProjectName "${projectNamePath}"
    if ! importProjectName "${projectNamePath}" ; then
        error "Variable $(foregroundColor "COMPOSE_PROJECT_NAME" "yellow") missing, please add at least default one"
        exit 1
    fi
}

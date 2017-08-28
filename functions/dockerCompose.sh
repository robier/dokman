#!/usr/bin/env bash

###
 # Wrapper for "docker compose" command
 #
 # @param1 Path to docker folder including it
 # @param2 Environment file name to load
 # @param3... Arguments that are passed to "buildDockerComposeCommand"
###
function dockerCompose
{
    local path=${1}
    local env=${2}
    local argument=${3}

    local envPath="${path}/environments"
    local composePath="${path}/compose/"
    local projectNamePath="${path}/.projectName"
    local envFile

    # import current user and group
    importCurrentUserGroup

    # import .defaults and .env files
    importConfigs ${path}

    # if project name file does not exit create one
    # if file is created import project name from newly created file
    { if handleProjectName "${projectNamePath}" ; then
        importProjectName "${projectNamePath}"
    fi }

    # find environment file to use
    environmentFile=$(findEnvironmentFile ${envPath} ${env})

    { if [[ ${argument} == "up" ]]; then
        writeInfo "Project can be accessed via http://localhost:${HTTP_PORT}"
    fi }

    eval $(buildDockerComposeCommand ${environmentFile} ${composePath} ${*:3});
}

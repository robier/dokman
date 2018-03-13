#!/usr/bin/env bash

###
 # Wrapper for "docker compose" command
 #
 # @param1 string Dokman dir
 # @param2 string Path to docker directory
 # @param3 string Environment file name to load
 # @param... Arguments that are passed to "buildDockerComposeCommand"
###
function dockerCompose
{
    local dokmanDir=${1}
    local path=${2}
    local env=${3}
    local arguments=${@:4}

    local environmentsPath=$(environmentFilePath ${path} ${env})
    local servicesPath="${path}/services"
    local projectNamePath=$(projectNameCacheFilePath ${dokmanDir})
    # find environment file to use
    local environmentFile=$(findEnvironmentFile "${environmentsPath}")

    if ! hasEnv "${path}" "${env}" ; then
        error "Environment $(foregroundColor ${env} "yellow") is not defined in environments directory"
        exit 1
    fi

    # import current user and group
    importCurrentUserGroup

    # import docker host IP
    importDockerHostIP

    if [ ! -f "${path}/.defaults" ]; then
        error "Missing main $(foregroundColor ".defaults" "yellow") file"
        exit 1
    fi

    # import .defaults and .env files
    importConfigurations ${path}
    # import env specific config if needed
    importConfigurations "${environmentsPath}"

    handleProjectName "${projectNamePath}"
    if ! importProjectName "${projectNamePath}" ; then
        error "Variable $(foregroundColor "COMPOSE_PROJECT_NAME" "yellow") missing, please add at least default one"
        exit 1
    fi

    local command="${arguments[0]}"
    local currentlyRunning=0

    if inArray "${command}" "on" "off"; then
        currentlyRunning=$(runningContainers "${path}" "${env}")
    fi

    if [ "on" == "${command}" ]; then
        arguments=("up" "--build" "--no-recreate" "-d")
    fi

    if [ "off" == "${command}" ]; then
        arguments=("down")
    fi

    if [ "on" == "${command}" ] && [ "${currentlyRunning}" -eq "0" ]; then
        runEventScript "${environmentsPath}" "before-on"
    fi

    if [ "off" == "${command}" ] && [ "${currentlyRunning}" -gt "0" ]; then
        runEventScript "${environmentsPath}" "before-off"
    fi

    eval $(buildDockerComposeCommand ${environmentFile} ${servicesPath} ${arguments[@]});

    if [ -f "${environmentsPath}" ]; then
        return
    fi

    if [ "on" == "${command}" ] && [ "${currentlyRunning}" -eq "0" ]; then
        runEventScript "${environmentsPath}" "after-on"
    fi

    if [ "off" == "${command}" ] && [ "${currentlyRunning}" -gt "0" ]; then
        runEventScript "${environmentsPath}" "after-off"
    fi
}

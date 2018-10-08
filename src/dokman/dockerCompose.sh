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
    local arguments=("${@:4}")

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
        runEventScript "${environmentPath}" "before-on"
        runEventScript "${DOKMAN_SCRIPT_DIR}" "before-on"
    fi

    if [ "off" == "${command}" ] && [ "${currentlyRunning}" -gt "0" ]; then
        runEventScript "${environmentPath}" "before-off"
        runEventScript "${DOKMAN_SCRIPT_DIR}" "before-off"
    fi

    eval "$(buildDockerComposeCommand "${environmentPath}" "${path}" "${arguments[@]}")";

    if [ -f "${environmentPath}" ]; then
        return
    fi

    if [ "on" == "${command}" ] && [ "${currentlyRunning}" -eq "0" ]; then
        runEventScript "${environmentPath}" "after-on"
        runEventScript "${DOKMAN_SCRIPT_DIR}" "after-on"
    fi

    if [ "off" == "${command}" ] && [ "${currentlyRunning}" -gt "0" ]; then
        runEventScript "${environmentPath}" "after-off"
        runEventScript "${DOKMAN_SCRIPT_DIR}" "after-off"
    fi
}

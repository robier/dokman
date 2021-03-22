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

    environmentPath=$(environmentFilePath "${path}" "${env}")

    loadEnvFiles "${dokmanDir}" "${path}" "${env}"

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
        runEvent 'before-on'
    fi

    if [ "off" == "${command}" ] && [ "${currentlyRunning}" -gt "0" ]; then
        runEvent 'before-off'
    fi

    eval "$(buildDockerComposeCommand "${environmentPath}" "${path}" "${arguments[@]}")";

    if [ "on" == "${command}" ] && [ "${currentlyRunning}" -eq "0" ]; then
        runEvent 'after-on'
    fi

    if [ "off" == "${command}" ] && [ "${currentlyRunning}" -gt "0" ]; then
        runEvent 'after-off'
    fi
}

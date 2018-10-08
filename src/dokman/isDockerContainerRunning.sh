#!/usr/bin/env bash


###
 # Checks if docker container exists with provided name
 #
 # @param1 Docker container name to check
 # @returns bool
###
function isDockerContainerRunning
{
    local dockerName
    dockerName=${1}

    local containerId
    containerId=$(docker/env "${DOKMAN_ENV}" ps -q "${dockerName}")

    if ! isDockerContainerExists "${containerId}"; then
        false
        return
    fi

    local response
    response=$(docker inspect --format="{{json .State.Status}}" "${containerId}")

    if [ "${response}" == '"running"'  ]; then
        return
    fi

    false
}

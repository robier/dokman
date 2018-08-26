#!/usr/bin/env bash


###
 # Checks if docker container exists with provided name
 #
 # @param1 Docker container name to check
 # @returns bool
###
function isDockerContainerExists
{
    local containerName
    containerName=${1}

    local containerId
    containerId=$(docker/env ${DOKMAN_ENV} ps -q ${containerName})

    if [ "${containerId}" != "" ]; then
        return
    fi

    false
}

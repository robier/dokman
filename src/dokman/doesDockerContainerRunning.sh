#!/usr/bin/env bash


###
 # Checks if docker container exists with provided name
 #
 # @param1 Docker container name to check
 # @returns bool
###
function doesDockerContainerRunning
{
    local dockerName=${1}

    if [ "$(docker ps --no-trunc --filter name=^/"${dockerName}"$ -q)" ]; then
        return
    fi

    false
}

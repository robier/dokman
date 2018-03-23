#!/usr/bin/env bash


###
 # Checks if docker container exists with provided name
 #
 # @param1 Docker container name to check
 # @returns bool
###
function doesDockerContainerExists
{
    local dockerName=${1}

    if [ "$(docker ps --no-trunc --filter name=^/"${dockerName}"$ -q -a)" ]; then
        return
    fi

    false
}

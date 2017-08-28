#!/usr/bin/env bash


###
 # Checks if docker container exists with provided name
 #
 # @param1 Docker container name to check
 # @returns boolean
###
function doesDockerContainerExists
{
    local dockerName=${1}

    { if [ -z $(docker ps --no-trunc --filter name=^/${dockerName}$ -q) ]; then
        return 1
    fi }
    return 0
}
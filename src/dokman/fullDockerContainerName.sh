#!/usr/bin/env bash


###
 # Finds container name by trying to match it with project name
 #
 # @param1 Docker container name
 # @prints Docker name if found
 # @exits If docker name cold not be found it exits with error message
###
function fullDockerContainerName
{
    echo "${COMPOSE_PROJECT_NAME}-${1}"
}

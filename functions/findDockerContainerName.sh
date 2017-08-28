#!/usr/bin/env bash


###
 # Finds container name by trying to match it with project name
 #
 # @param1 Docker container name
 # @prints Docker name if found
 # @exits If docker name cold not be found it exits with error message
###
function findDockerContainerName
{
    local name=${1}
    local containerName="${COMPOSE_PROJECT_NAME}-${name}"

    { if doesDockerContainerExists ${containerName}; then
        echo ${containerName}
        return 0
    fi }

    { if doesDockerContainerExists ${name}; then
        echo ${name}
        return 0
    fi }

    writeError "Could not find docker container with name ${containerName} nor ${name}"
}
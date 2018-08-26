#!/usr/bin/env bash

###
 # Checks if container is in provided health status
 #
 # @param1 string Container name
 # @param2 string Health status
###
function isContainerHealthStatus
{
    local containerName
    containerName=${1}

    local status
    status=${2}

    local containerId
    containerId=$(docker/env ${DOKMAN_ENV} ps -q ${containerName})

    if [ "${containerId}" == "" ]; then
        warning "Undefined container ${containerName}."
        return
    fi

    local healthPayload
    healthPayload=$(docker inspect --format="{{json .State.Health}}" ${containerId})

    if [ "${healthPayload}" == "null" ]; then
        warning "Container ${containerName} does not have health check configured."
        return
    fi

    local healthStatus=$(docker inspect --format="{{json .State.Health.Status}}" ${containerId})
    if [ "${healthStatus}" == "\"${status}\"" ]; then
        return
    fi

    false
}

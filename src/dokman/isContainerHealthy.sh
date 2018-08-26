#!/usr/bin/env bash


###
 # Checks if given container is healthy
 #
 # @param1 string Container name
###
function isContainerHealthy
{
    isContainerHealthStatus ${1} 'healthy'
}

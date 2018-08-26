#!/usr/bin/env bash


###
 # Checks if given container is unhealthy
 #
 # @param1 string Container name
###
function isContainerUnhealthy
{
    isContainerHealthStatus ${1} 'unhealthy'
}

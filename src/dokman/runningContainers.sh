#!/usr/bin/env bash


###
 # Gets count of currently running containers in provided environment
 #
 # @param1 string Path to docker folder
 # @param2 string Environment file name to load
 # @prints number Number of currently running containers
###
function runningContainers
{
    local path=${1}
    local env=${2}

    local containers=($("${path}"/env "${env}" ps -q))

    echo "${#containers[@]}"
}

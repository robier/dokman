#!/usr/bin/env bash

###
 # Build docker exec command with provided params
 #
 # @param1 Type of terminal ie. "sh" or "bash"
 # @param2 Docker container name
###
function buildDockerExecCommand
{
    local type=${1}
    local dockerContainerName=${2}
    local param="i"

    { if [ -t 2 ]; then
        param="it"
    fi }

    command="docker exec -${param} '${dockerContainerName}' env TERM=xterm ${type} -l"

    { if [ "$#" -ge 3 ]; then
        command+=" -c '${*:3}'"
    fi }

    echo ${command}
}
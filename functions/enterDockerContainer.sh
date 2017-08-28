#!/usr/bin/env bash


###
 # Enter docker container with provided parameters
 #
 # @param1 Path to docker folder
 # @param2 Type of terminal env "sh" or "bash" for example
 # @param3 Container name
 # @param4... Rest of the param are simply passed to "buildDockerExec" function
###
function enterDockerContainer
{
    local path=${1}
    local type=${2}
    local containerName=${3}

    # import .defaults and .env files
    importConfigs ${path}

    # if project name file does not exit create one
    # if file is created import project name from newly created file
    local projectNamePath="${path}/.projectName"
    { if handleProjectName "${projectNamePath}" ; then
        importProjectName "${projectNamePath}"
    fi }

    containerName=$(findDockerContainerName ${containerName})

    writeInfo "Entering docker ${containerName}"

    eval $(buildDockerExecCommand ${type} ${containerName} ${@:4})
}
#!/usr/bin/env bash

###
 # Handles project name and updates file if needed
 #
 # @param1 File name that needs to be checked and updated if needed
 # @returns boolean
###
function handleProjectName
{
    local fileName=${1}
    local projectName=${COMPOSE_PROJECT_NAME}
    local currentProjectName

    { if [ -f ${fileName} ]; then
        currentProjectName=$(cat ${fileName})
    fi }

    { if [ "${currentProjectName}" == "${projectName}" ] && [ "${projectName}" != "" ]; then
        writeInfo "Project name read from .projectName file"
        return 0
    fi }

    { if [ -n projectName ]; then
        writeInfo "Project name read from .env file, updated .projectName"
        writeFile ${fileName} ${projectName}
        return 0
    fi }

    projectName="docker-project-${RANDOM}"

    { if [ ! -f ${fileName} ]; then
        writeInfo "No .projectName file, creating arbitrary one, please change!"
        writeFile ${fileName} ${projectName}
    fi }

    return 1
}
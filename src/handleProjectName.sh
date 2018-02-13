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
        info "Project name read from .projectName file"
        return
    fi }

    { if [ -n projectName ]; then
        info "Project name read from .env file, updated .projectName"
        createFile ${fileName} ${projectName}
        return
    fi }

    projectName="docker-project-${RANDOM}"

    { if [ ! -f ${fileName} ]; then
        info "No .projectName file, creating arbitrary one, please change!"
        createFile ${fileName} ${projectName}
        return
    fi }

    false
}

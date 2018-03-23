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

    if [ -f "${fileName}" ]; then
        currentProjectName=$(cat "${fileName}")
    fi

    if [ "${currentProjectName}" == "${projectName}" ] && [ "${projectName}" != "" ]; then
        return
    fi

    if [ -n "${projectName}" ]; then
        createFile "${fileName}" "${projectName}"
        return
    fi

    projectName="docker-project-${RANDOM}"

    if [ ! -f "${fileName}" ]; then
        info "Variable $(foregroundColor "COMPOSE_PROJECT_NAME" "yellow") empty or not defined, creating arbitrary project name $(foregorundColor "${projectName}" "yellow"), please change!"
        createFile "${fileName}" "${projectName}"
        return
    fi

    false
}

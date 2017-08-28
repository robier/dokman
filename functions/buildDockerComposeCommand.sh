#!/usr/bin/env bash

###
 # Builds docker compose command from config file
 #
 # @param1 Path to env file
 # @param2 Path to compose files
 # @param3... Arguments that are passed to docker-compose command
###
function buildDockerComposeCommand
{
    local configFile=${1}
    local path=${2}
    local arguments=${*:3}

    local command='docker-compose'

    if [[ ! -f ${configFile} ]]; then
        writeError "Config file ${configFile} not found. Aborting!"
    fi

    while read line || [ -n "${line}" ]
    do
        # if empty line or commented out, skipp
        # @todo add possibility to add new lines in file (not possible at the moment because of [ -n "${line}" ] in while)
        if [ "${line:0:1}" == '#' ]; then
            continue
        fi

        local pathToYml=${path}${line}
        if [ -r ${pathToYml} ]; then
            command="${command} -f \"${pathToYml}\""
        fi
    done < ${configFile}

    echo "${command} ${arguments}"
}

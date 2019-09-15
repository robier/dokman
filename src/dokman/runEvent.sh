#!/usr/bin/env bash

###
 # Sources event script if script exists
 #
 # @param1... string Event name
###
function runEvent
{
    local events=${@}

    for event in "${events[@]}"; do
        runEventScript "$(environmentFilePath "${DOKMAN_SCRIPT_DIR}" "${DOKMAN_ENV}")" "${event}"
        runEventScript "${DOKMAN_SCRIPT_DIR}" "${event}"
    done
}

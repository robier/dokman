#!/usr/bin/env bash

###
 # Forces user to give non-empty response
 #
 # @param1 string Question to be asked
 # @param2 string Error that will be printed if user provided empty response
 # @echo Echoes user answer
###
function questionForceNotEmptyResponse
{
    local answer=""
    while true ; do
        answer=$(question "${1}")
        if [ -n "${answer}" ]; then
            break
        fi
        error "${2}"
    done

    echo ${answer}
}



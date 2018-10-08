#!/usr/bin/env bash

###
 # Autoload folder with functions, will not autoload functions that are inside sub folder.
 #
 # @param1 string Path to folder containing bash functions
 # @prints Error message if provided path does not exist
 # @exits If folder provided does not exist
###
function autoload
{
    local path=${1}

    if [ ! -d "${path}" ]; then
        error "Folder provided ${path} does not exist. Aborting!";
        exit 1
    fi

    for file in "${path}"/*.sh
    do
        if [[ -f "${file}" ]]; then
            source "${file}"
        fi
    done
}

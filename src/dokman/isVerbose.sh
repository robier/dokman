#!/usr/bin/env bash

###
 # Check if dokman is started in verbose mode
 #
###
function isVerbose
{
    if [ -z "${DOKMAN_VERBOSE}" ] || [ "${DOKMAN_VERBOSE}" = false ]; then
        false
        return
    fi
}

#!/usr/bin/env bash

###
 # Check if dokman is started in force color mode
###
function isColorForced
{
    if [ -z "${DOKMAN_FORCE_COLORS}" ] || [ "${DOKMAN_FORCE_COLORS}" = false ]; then
        false
        return
    fi
}

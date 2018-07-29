#!/usr/bin/env bash


###
 # Prints out formatted seconds to human readable format
 #
 # @param1 string seconds
###
function formatSeconds
{
    local seconds="${1}"

    local minute=60 # seconds in 1 minute
    local hour=3600 # minute * 60
    local day=86400 # hour * 24

    if [ "${seconds}" -lt "${minute}" ]; then
        echo "${seconds}s"
        return
    fi

    if [ "${seconds}" -lt "${hour}" ]; then
        local minutes=$((seconds / minute))
        local seconds=$((seconds % minute))
        echo "${minutes}m ${seconds}s"
        return
    fi

    if [ "${seconds}" -lt "${day}" ]; then
        local hours=$((seconds / hour))
        local minutes=$((seconds % hour / minute))
        local seconds=$((seconds % minute))

        echo "${hours}h ${minutes}m ${seconds}s"
        return
    fi

    if [ "${seconds}" -gt "${day}" ]; then
        local days=$((seconds / day))
        local hours=$((seconds % day / hour))
        local minutes=$((seconds % hour / minute))
        local seconds=$((seconds % minute))

        echo "${days}d ${hours}h ${minutes}m ${seconds}s"
        return
    fi
}

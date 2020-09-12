#!/usr/bin/env bash

###
 # Check if the current platform is Docker Desktop based.
 # Known platforms that use Docker Desktop as a backend are Mac OS and Windows.
 #
 # @return bool
###
function isDockerDesktop
{
    local operatingSystem="$(docker info --format '{{ .OperatingSystem }}')"

    if [ "${operatingSystem}" == "Docker Desktop" ]; then
        return
    fi

    false
}

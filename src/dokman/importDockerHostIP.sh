#!/usr/bin/env bash

###
 # Creates and exports variable DOKMAN_HOST_IP
 #
 # @exports DOKMAN_HOST_IP
###
function importDockerHostIP
{
    local hostIp
    hostIp=""

    if isLinux; then
        hostIp=$(ip -4 addr show docker0 | grep -Po 'inet \K([0-9]{1,3}\.){3}[0-9]{1,3}' --color=never)
    fi

    export DOKMAN_HOST_IP="${hostIp}"
}

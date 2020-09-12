#!/usr/bin/env bash

###
 # Creates and exports variable DOKMAN_HOST_IP
 #
 # @exports DOKMAN_HOST_IP
###
function importDockerHostIP
{
    local defaultGatewayIp

    # Platforms which use Docker Desktop for container management don't have a dedicated gateway network interface.
    # Instead, it's possible to use the magic "host.docker.internal" DNS entry to find out the host's IP address.
    if ! isDockerDesktop ; then
        defaultGatewayIp="$(docker network inspect bridge --format '{{ (index .IPAM.Config 0).Gateway }}')"
    fi

    export DOKMAN_HOST_IP="${defaultGatewayIp}"
}

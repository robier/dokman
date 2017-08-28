#!/usr/bin/env bash

###
 # Exports ip from host that is running docker
###
function setDockerHostVariable
{
    export DOKMAN_HOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
}


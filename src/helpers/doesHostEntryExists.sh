#!/usr/bin/env bash


###
 # Checks if given entry exists in /etc/hosts file
 #
 # @param1 string Host name
 # @param2 string Ip (optional, default value 127.0.0.1)
###
function doesHostEntryExists
{
    local host=${1}
    local ip=${2:-127.0.0.1}

    if grep "^[^#]" /etc/hosts | grep "${ip}" | grep "\s${host}" -q ; then
        return
    fi

    false
}

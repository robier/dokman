#!/usr/bin/env bash

###
 # Creates and exports variables DOKMAN_HOST_USER_ID and DOKAMN_HOST_GROUP_ID containing current user and group
 #
 # @exports DOKMAN_HOST_USER_ID DOKMAN_HOST_GROUP_ID
###
function importCurrentUserGroup
{
    local userID
    local groupID

    if isOsX ; then
        # Docker is running inside of VirtualBox on a Mac...
        userID=1000
        groupID=1000
    else
        userID=$(id -u ${USER})
        groupID=$(id -g ${USER})
    fi

    export DOKMAN_HOST_USER_ID=${userID}
    export DOKMAN_HOST_GROUP_ID=${groupID}
}

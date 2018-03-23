#!/usr/bin/env bash


###
 # Checks if current stdout and stderr is a terminal
 #
 # @return bool
###
function isTty()
{
    if [ -t 1 ] || [ -t 2 ] ; then
        return
    fi

    false
}

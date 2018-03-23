#!/usr/bin/env bash

###
 # Writes info message to stdout
 #
 # @param1 string Message to be written
###
function info
{
    local icon
    icon=$(foregroundColor "i" "yellow")

    write "[${icon}] ${1}"
}

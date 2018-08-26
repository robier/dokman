#!/usr/bin/env bash


###
 # Writes error to stderr
 #
 # @param1 string Message to be written to stderr
###
function warning
{
    local icon
    icon=$(foregroundColor "!" "yellow")

    write "[${icon}] ${1}"
}

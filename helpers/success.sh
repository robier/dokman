#!/usr/bin/env bash


###
 # Writes success message to stdout
 #
 # @param1 string Success message
###
function success
{
    local icon=$(foregroundColor "+" "green")

    write "[${icon}] ${1}"
}

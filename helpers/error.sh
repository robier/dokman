#!/usr/bin/env bash


###
 # Writes error to stderr
 #
 # @param1 string Message to be written to stderr
###
function error
{
    local icon=$(foregroundColor "x" "red")

    write "[${icon}] ${1}" >&2
}

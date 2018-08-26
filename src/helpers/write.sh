#!/usr/bin/env bash

###
 # Writes line of text
 #
 # @param1 string Message to be written to stdout
###
function write
{
    echo -e "${1}" >&2
}

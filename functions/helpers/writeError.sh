#!/usr/bin/env bash

###
 # Write error in stderr
 #
 # @param1 Error to be written
 # @exits
###
function writeError
{
    >&2 echo "[E] ${1}";
    exit 1
}

export -f writeError
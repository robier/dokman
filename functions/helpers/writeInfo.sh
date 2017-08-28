#!/usr/bin/env bash

###
 # Writes info line to stdout
 #
 # @param1 Info to be written
 # @prints Provided param
###
function writeInfo
{
    echo "[I] ${1}";
}

export -f writeInfo
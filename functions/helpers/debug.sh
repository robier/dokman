#!/usr/bin/env bash


###
 # Function for easier debugging of bash scripts
 # Takes all provided arguments, prints it out in stdout end exits from script
 #
 # @params...
 # @prints All provided params
 # @exits
###
function debug
{
    set -e
    echo "[debug] ${*:1}"
    exit 1
}

export -f debug
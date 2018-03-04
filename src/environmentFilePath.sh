#!/usr/bin/env bash




###
 # Prints out full environment path
 #
 # @param1 string Dokman path
 # @param2 string Environment name
 # @prints Cached Environment path
###
function environmentFilePath
{
    echo "${1}/environments/${2}"
}

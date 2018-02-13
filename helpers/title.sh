#!/usr/bin/env bash


###
 # Prints out title
 #
 # @param1 string Title text
 # @prints Prints out styled text to stdout
###
function title
{
    write ""
    write "$(backgroundColor "${1}" "blue")"
}

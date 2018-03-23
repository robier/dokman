#!/usr/bin/env bash


###
 # Gets cached file path
 #
 # @param1 string Path to environments folder
 # @param2 string Name of cached file
 # @prints Full path to cached files
###
function cacheFilePath
{
    local dokmanPath=${1}
    local fileName=${2}

    echo "${dokmanPath}/cache/${fileName}"
}

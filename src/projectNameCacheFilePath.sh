#!/usr/bin/env bash




###
 # Prints out full path to projectName cached file
 #
 # @param1 string Dokman path
 # @prints Cached projectName file path
###
function projectNameCacheFilePath
{
    echo $(cacheFilePath ${1} "projectName")
}

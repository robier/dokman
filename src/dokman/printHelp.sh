#!/usr/bin/env bash


###
 # Prints provided file from help directory
 #
 # @param1 Path to dokman
 # @param2 Help name
 # @prints Help content
 # @exits
###
function printHelp
{
    local dokmanDir="${1}"
    local helpName="${2}"

    local currentCommitHash=$(git -C "${dokmanDir}" rev-parse HEAD)

    helpContent=$(cat "${dokmanDir}/help/${helpName}")
    helpContent="${helpContent//:version:/$currentCommitHash}"
    helpContent="${helpContent//:dokmanPath:/$dokmanDir}"

    echo "${helpContent}"
    exit 0
}

#!/usr/bin/env bash

###
 # Writes content to provided location
 #
 # @param1 Path to file with file name
 # @param2 Content to be written to file
###
function writeFile
{
    local path=${1}
    local content=${2}

    cat << EOF > ${path}
${content}
EOF

    return 0
}

export -f writeFile
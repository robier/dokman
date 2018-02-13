#!/usr/bin/env bash


###
 # Prints out colored text if rich text is supported by current output
 #
 # @param1 string Message
 # @param2 string Color name
###
function foregroundColor
{
    local message="${1}"

    if ! isRichTextSupported ; then
        echo -en "${message}"
        return
    fi

    local COLOR_black='\033[97;30m'
    local COLOR_red='\033[97;31m'
    local COLOR_green='\033[97;32m'
    local COLOR_yellow='\033[97;33m'
    local COLOR_blue='\033[97;34m'
    local COLOR_magenta='\033[97;35m'
    local COLOR_cyan='\033[96;36m'
    local COLOR_white='\033[96;97m'

    local DEFAULT_COLOR='\033[39m'

    eval "local color=\${COLOR_${2}}"

    echo -en "${color}${message}${DEFAULT_COLOR}"
}

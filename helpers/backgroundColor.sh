#!/usr/bin/env bash



###
 # Prints out colored background if rich text is supported by current output
 #
 # @param1 string Message
 # @param2 string Color name
###
function backgroundColor
{
    local message="${1}"

    if ! isRichTextSupported ; then
        echo -en "${message}"
        return
    fi

    local COLOR_black='\033[97;40m'
    local COLOR_red='\033[97;41m'
    local COLOR_green='\033[97;42m'
    local COLOR_yellow='\033[97;43m'
    local COLOR_blue='\033[97;44m'
    local COLOR_magenta='\033[97;45m'
    local COLOR_cyan='\033[96;46m'
    local COLOR_white='\033[96;107m'

    local DEFAULT_COLOR='\033[49m'

    eval "local color=\${COLOR_${2}}"

    echo -en "${color}${message}${DEFAULT_COLOR}"
}

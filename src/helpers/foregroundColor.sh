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

    if ! isRichTextSupported && ! isColorForced ; then
        echo -en "${message}"
        return
    fi

    # shellcheck disable=SC2034
    local COLOR_black='\033[97;30m'
    # shellcheck disable=SC2034
    local COLOR_red='\033[97;31m'
    # shellcheck disable=SC2034
    local COLOR_green='\033[97;32m'
    # shellcheck disable=SC2034
    local COLOR_yellow='\033[97;33m'
    # shellcheck disable=SC2034
    local COLOR_blue='\033[97;34m'
    # shellcheck disable=SC2034
    local COLOR_magenta='\033[97;35m'
    # shellcheck disable=SC2034
    local COLOR_cyan='\033[96;36m'
    # shellcheck disable=SC2034
    local COLOR_white='\033[96;97m'

    local DEFAULT_COLOR='\033[39m'

    local color

    eval "color=\${COLOR_${2}}"

    echo -en "${color}${message}${DEFAULT_COLOR}"
}

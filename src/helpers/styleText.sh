#!/usr/bin/env bash



###
 # Style given text
 #
 # @param1 string Message
 # @param2... string Style
###
function styleText
{
    local message="${1}"

    if ! isRichText ; then
        echo -en "${message}"
        return
    fi

    local STYLE_bold='\033[97;1m'
    local STYLE_dim='\033[97;2m'
    local STYLE_underlined='\033[97;4m'
    local STYLE_blink='\033[97;5m'
    local STYLE_inverted='\033[97;7m'
    local STYLE_hidden='\033[97;8m'

    local RESET_bold='\033[97;21m'
    local RESET_dim='\033[97;22m'
    local RESET_underlined='\033[97;24m'
    local RESET_blink='\033[97;25m'
    local RESET_reverse='\033[97;27m'
    local RESET_hidden='\033[97;28m'

    local start=''
    local reset=''

    for style in "${@:1}"
    do
        eval "start+=\${STYLE_${style}"
        eval "end+=\${RESET_${style}"
    done

    eval "local start=\${STYLE_${2}}"
    eval "local end=\${RESET_${2}}"

    echo -en "${start}${message}${end}"
}

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

    # shellcheck disable=SC2034
    local STYLE_bold='\033[97;1m'
    # shellcheck disable=SC2034
    local STYLE_dim='\033[97;2m'
    # shellcheck disable=SC2034
    local STYLE_underlined='\033[97;4m'
    # shellcheck disable=SC2034
    local STYLE_blink='\033[97;5m'
    # shellcheck disable=SC2034
    local STYLE_inverted='\033[97;7m'
    # shellcheck disable=SC2034
    local STYLE_hidden='\033[97;8m'

    # shellcheck disable=SC2034
    local RESET_bold='\033[97;21m'
    # shellcheck disable=SC2034
    local RESET_dim='\033[97;22m'
    # shellcheck disable=SC2034
    local RESET_underlined='\033[97;24m'
    # shellcheck disable=SC2034
    local RESET_blink='\033[97;25m'
    # shellcheck disable=SC2034
    local RESET_reverse='\033[97;27m'
    # shellcheck disable=SC2034
    local RESET_hidden='\033[97;28m'

    local start
    local reset

    for style in "${@:1}"
    do
        eval "start+=\${STYLE_${style}"
        eval "reset+=\${RESET_${style}"
    done

    echo -en "${start}${message}${reset}"
}

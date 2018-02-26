#!/usr/bin/env bash


###
 # Ask a question from user and echoes results
 #
 # @param1 string Question to be asked
###
function question
{
    local icon=$(foregroundColor "?" "cyan")

    local answer
    read -p $"[${icon}] ${1}: " answer
    echo ${answer}
}

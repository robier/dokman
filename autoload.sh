#!/usr/bin/env bash

set -e

function loadFiles
{
    local path
    path=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

    # source autoload function
    source "${path}/src/helpers/autoload.sh"

    # autoload all functions in directories
    autoload "${path}/src/dokman"
    autoload "${path}/src/helpers"
}

loadFiles

unset -f loadFiles

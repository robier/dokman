#!/usr/bin/env bash

set -e

function loadFiles
{
    local path=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

    # source autoload function
    source "${path}/helpers/autoload.sh"

    # autoload all functions in directories
    autoload "${path}/src"
    autoload "${path}/helpers"
}

loadFiles

unset -f loadFiles

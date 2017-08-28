#!/usr/bin/env bash

set -e

function loadFiles
{
    local path=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

    # source autoload function
    source "${path}/functions/helpers/autoload.sh"

    # autoload all functions in directories
    autoload "${path}/functions/helpers"
    autoload "${path}/functions"
}

loadFiles

unset -f loadFiles

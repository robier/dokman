#!/usr/bin/env bash


###
 # Creates symlink if target files does not exist
 #
 # @param target
 # @param source Relative to target
###
function createSymlink
{
    local target="${1}"
    local source="${2}"

    if [ -a "${target}" ]; then
        info "File ${target} already exist, skipping creating symlink"
    else
        runCommand "ln -s ${source} ${target}" "Creating symlink for ${target} file..."
    fi
}


#!/usr/bin/env bash


###
 # Removes provided files if they are actually a symlink
###
function removeSymlinks
{
    local symlinks=("${@}")

    for item in "${symlinks[@]}"
    do
        if [ -L "${item}" ]; then
            runCommand "rm -f ${item}" "Removing ${item} file"
        else
            info "File ${item} is not symlink so it's not removed"
        fi
    done
}

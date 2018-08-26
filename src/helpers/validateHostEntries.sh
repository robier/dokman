#!/usr/bin/env bash


function validateHostEntries
{
    for host in "$@"
    do
        if ! doesHostEntryExists "${host}" ; then
            error "Domain ${host} is missing!"
        else
            success "Domain ${host} is set properly!"
        fi
    done
}

#!/usr/bin/env bash

name=""

dokmanValueOption '--name' 'name=${2}'

function dokmanInstall
{
    dokmanRunCommand 'info "Hello ${name}"' "First command"
}

#!/usr/bin/env bash

###
 # Wrapper for "docker compose run" command
 #
 # @param1 Path to docker folder including it
 # @param2 Environment file name to load
 # @param3... Arguments that are passed to "buildDockerComposeCommand"
###
function runDockerContainer
{
    local scriptDir="${1}"
    local arguments=("${@:2}")
    local dockerComposeOptions=()
    local commands=()
    local container=""
    local env=""

    # iterate all arguments and decide witch ones belong to docker-compose and witch ones belongs to container

    while [ "${#arguments[@]}" -ne 0 ] ; do

        parts=(${arguments[0]//:/ })
        if [ "${#parts[@]}" -eq 2 ] && hasEnv "${scriptDir}" "${parts[0]}" ; then
            env="${parts[0]}"
            container="${parts[1]}"
            arguments=("${arguments[@]:1}")
            break
        fi

        dockerComposeOptions+=("${arguments[0]}")
        arguments=("${arguments[@]:1}")
    done

    if [ -z "${container}" ]; then
        error "You did not provide valid container name"
        exit 1
    fi

    if [ -n "${arguments[*]}" ]; then
        commands=("${arguments[@]}")
    fi

    # handle special flags
    if inArray "--deps" "${dockerComposeOptions[@]}"; then
        dockerComposeOptions=("$(removeArrayItem "--deps" "${dockerComposeOptions[@]}")")
    else
        dockerComposeOptions+=("--no-deps")
    fi

    if inArray "--no-rm" "${dockerComposeOptions[@]}"; then
        dockerComposeOptions=("$(removeArrayItem "--no-rm" "${dockerComposeOptions[@]}")")
    else
        dockerComposeOptions+=("--rm")
    fi

    if [ "${#commands[@]}" -eq 0 ]; then # no commands provided
        commands=("sh")
    fi

    if [ "${#commands[@]}" -eq 1 ]; then
        info "Entering fresh $(foregroundColor "${container}" "yellow") container"
    else
        info "Running $(foregroundColor "${commands[*]}" "yellow") on fresh $(foregroundColor "${container}" "yellow") container"
    fi

    if inArray "${commands[0]}" "sh" "bash"; then
        commands[0]="/bin/${commands[0]} -l"
    fi

    eval "${scriptDir}/env ${env} run ${dockerComposeOptions[*]} ${container} ${commands[*]}"
}

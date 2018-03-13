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
    local arguments=(${@:2})
    local dockerCommands=()
    local runCommands=()
    local container=""
    local env=""

    # iterate all arguments and decide witch ones belong to docker-compose and witch ones belongs to container

    local flags=(
        -d
        --deps
        --no-rm
        -T
        --service-ports
    )

    local flagsWithValues=(
        --name
        --entrypoint
        -e
        -l
        --label
        -u
        --user
        -p
        --publish
        -v
        --volume
        -w
        --workdir
    )

    while [ ${#arguments[@]} ] ; do

        if inArray "${arguments[0]}" "${flags[@]}" ; then
            dockerCommands+=("${arguments[0]}")
            arguments=("${arguments[@]:1}")
            continue
        fi

        if inArray "${arguments[0]}" "${flagsWithValues[@]}" ; then
            dockerCommands+=("${arguments[0]}")
            dockerCommands+=("${arguments[1]}")
            arguments=("${arguments[@]:2}")
            continue
        fi

        parts=(${arguments[0]//:/ })
        if [ "${#parts[@]}" -eq 2 ] && hasEnv "${scriptDir}" "${parts[0]}" ; then
            env="${parts[0]}"
            container="${parts[1]}"
            arguments=("${arguments[@]:1}")
            break
        fi

        error "Parameter $(foregroundColor "${arguments[0]}" "yellow") not supported"
        exit 1
    done

    if [ -z "${container}" ]; then
        error "You did not provide valid container name"
        exit 1
    fi

    if [ -n "${arguments}" ]; then
        runCommands="${arguments[@]}"
    fi

    # handle special flags

    if inArray "--deps" "${dockerCommands[@]}"; then
        dockerCommands=($(removeArrayItem "--deps" "${dockerCommands[@]}"))
    else
        dockerCommands+=("--no-deps")
    fi

    if inArray "--no-rm" "${dockerCommands[@]}"; then
        dockerCommands=($(removeArrayItem "--no-rm" "${dockerCommands[@]}"))
    else
        dockerCommands+=("--rm")
    fi

    if [ -z "${runCommands[@]}" ]; then
        info "Entering fresh $(foregroundColor "${container}" "yellow") container"
        runCommands+=("/bin/sh -l")
    else
        info "Running $(foregroundColor "${runCommands[@]}" "yellow") on $(foregroundColor "${container}" "yellow") container"
    fi

    if inArray ${runCommands[0]} "sh" "bash"; then
        runCommands[0]="/bin/${runCommands[0]} -l"
    fi

    eval "${scriptDir}/env ${env} run ${dockerCommands[@]} ${container} ${runCommands[@]}"
}

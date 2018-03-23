#!/usr/bin/env bash


###
 # Wrapper for "docker-compose exec" command
 #
 # @param1 Path to docker folder including it
 # @param2 Environment file name to load
 # @param3... Arguments that are passed to "buildDockerComposeCommand"
###
function enterDockerContainer
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

    if [ "${#commands[@]}" -eq 0 ]; then # no commands provided
        commands=("sh")
    fi

    if [ "${#commands[@]}" -eq 1 ]; then
        info "Entering existing $(foregroundColor "${container}" "yellow") container"
    else
        info "Running $(foregroundColor "${commands[*]}" "yellow") on existing $(foregroundColor "${container}" "yellow") container"
        if ! inArray "-T" "${dockerComposeOptions[@]}"; then
            # do not allocate tty if we are not entering the container
            dockerComposeOptions+=("-T")
        fi
    fi

    if inArray "${commands[0]}" "sh" "bash"; then
        commands[0]="/bin/${commands[0]} -l"
    fi

    eval "${scriptDir}/env ${env} exec ${dockerComposeOptions[*]} ${container} ${commands[*]}"
}

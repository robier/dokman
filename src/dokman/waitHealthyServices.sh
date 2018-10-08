#!/usr/bin/env bash

###
 # Waits 300 seconds for all listed services to become healthy.
###
function waitHealthyServices
{
    # try every second for duration of 300 seconds
    local seconds=1
    local maxTries=300 # this is Sparta!
    local maxSeconds=$((seconds*maxTries))

    local allServices=("$@")
    local waitServices=("$@")
    local healthyServices=()

    local try=0

    info "Waiting services [${allServices[*]}] for max of ${maxSeconds} seconds"

    while :
    do
        healthyServices=()

        for service in "${waitServices[@]}"; do
            if isContainerHealthy "${service}"; then
                healthyServices+=("${service}")
            elif isContainerUnhealthy "${service}"; then
                error "Service ${service} is unhealthy. Aborting!"
                exit 1
            fi
        done

        for service in "${healthyServices[@]}"; do
            # remove healthy service from wait services
            waitServices=($(removeArrayItem "${service}" "${waitServices[@]}"))
        done

        if [ ${#waitServices[@]} -eq 0 ]; then
            # no more waiting services
            success "All services [${allServices[*]}] become healthy after try No ${try}"
            break
        fi

        if [ ${#healthyServices[@]} -gt 0 ]; then
            info "Services [${healthyServices[*]}] become healthy after try No ${try}"
        fi

        if [ ${try} -ge ${maxTries} ]; then
            error "Services [${waitServices[*]}] did not become healthy inside ${maxTries} tries. Aborting!"
            exit 1
        fi

        if isVerbose; then
            info "Try No ${try} and still waiting services [${waitServices[*]}] to become healthy"
        fi

        sleep ${seconds}
        try=$((try+1))
    done
}

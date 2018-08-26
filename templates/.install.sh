#!/usr/bin/env bash

readonly hosts=(
    test.loc
)

function dokmanInstall
{
    validateHostEntries "${hosts[@]}"

    # setup configuration files

    title 'Docker...'
    runCommand "docker/env ${DOKMAN_ENV} on" "Building and upping docker containers..."

    title 'Wait services...'
    waitHealthyServices mysql elasticsearch logstash redis

    # populate database or something like that
}

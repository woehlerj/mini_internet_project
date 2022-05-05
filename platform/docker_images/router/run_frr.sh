#!/bin/bash

set -e

command=/usr/lib/frr/frrinit.sh

function stop() {
    $command stop
    exit 0
}

function reload() {
    $command reload
}

trap "stop" SIGINT SIGTERM
trap "reload" SIGHUP

# Launch frr daemons
$command start
sleep 2

# Loop while the daemons are alive.
# status returns exit code 0 only if all daemons are are running.
while $command status > /dev/null ; do
    sleep 0.5
done

$command status

exit 1 # exit unexpected

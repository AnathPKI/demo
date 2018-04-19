#!/bin/bash
#
# Smoke tests.

set -eu

trap '{ docker-compose --project-name smoke-test -f docker-compose.yml down ; }' EXIT

docker-compose --project-name smoke-test -f docker-compose.yml up -d

echo "Wait for healthy anath container..."

for i in {1..8}
do
    sleep 15
    echo "#$i: Test health of anath container"
    if docker ps -f name=smoke-test_anath-server_1 --format '{{ .Status }}' | grep 'healthy' >/dev/null 2>&1
    then
	echo "Anath container is in healthy state"
	exit 0
    fi

done
echo "Current state"
docker ps -a

echo "Anath container is not in healthy state after 120secs" >&2
exit 1

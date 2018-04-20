#!/bin/bash
#
# Anath docker image smoke test.
#
# This script expects the CWD to be the repository root.
#
# Provide the docker compose file and overrides as arguments to the script, e.g.
#
#  smoke.sh docker-compose.yml docker-compose-other.yml
#
# When no docker compose file is specified, the default is taken by docker-compose.

set -eu

# Transform the values in "$@" to
#   "-f $1 ... -f $N"
function get_docker_compose_file_arguments() {
    local args=""
    
    for f in "$@"
    do
	args="${args} -f $f"
    done

    echo $args
}

SLEEP=${SLEEP:-15}
TRIES=${TRIES:-8}
PROJECT_NAME=${PROJECT_NAME:-smoke-test}
ANATH_SERVER_NAME=${ANATH_SERVER_NAME:-anath-server}
DOCKER_FILE_ARGS=`get_docker_compose_file_arguments "$@"`

trap "{ docker-compose --project-name \"${PROJECT_NAME}\" ${DOCKER_FILE_ARGS} down ; }" EXIT

docker-compose --project-name "${PROJECT_NAME}" ${DOCKER_FILE_ARGS} up -d

echo "Wait for healthy anath container..."

for i in `seq 1 ${TRIES}`
do
    sleep 15
    echo "#$i: Is anath container healthy?"
    if docker ps -f name="${PROJECT_NAME}_${ANATH_SERVER_NAME}_1" --format '{{ .Status }}' | grep 'healthy' >/dev/null 2>&1
    then
	echo "Anath container is in healthy state"
	exit 0
    fi

done
echo "Current state"
docker ps -a

echo "Anath container is not in healthy state after $((SLEEP * TRIES))secs" >&2
exit 1

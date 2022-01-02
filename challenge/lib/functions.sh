#!/bin/bash

IMAGE_PHP="owendavies-coding-challenge-php-8:0.0.1"
IMAGE_CPP="owendavies-coding-challenge-cpp-cpp11:0.0.1"
IMAGE_JAVA="owendavies-coding-challenge-java-17:0.0.1"
IMAGE_PYTHON="owendavies-coding-challenge-python-3:0.0.1"

function run_container {
	ID="$(docker container create --workdir '//data' --entrypoint 'bash' "${@}" 2>/dev/null)"
	docker cp . "$ID":/data || { echo "Failed to copy files to container."; }
	docker container start -i -a "$ID" || { echo "Failed to start container."; }
	docker container wait "$ID" &> /dev/null
	docker container rm "$ID" &> /dev/null || { echo "Failed to cleanup container"; }
}

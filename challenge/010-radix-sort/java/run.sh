#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$DIR/../../lib/functions.sh"

{
	cd "$DIR"
	run_container "$IMAGE_JAVA" entrypoint.sh "$@"
}

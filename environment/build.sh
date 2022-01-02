#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

{
cd "$DIR/containers"

# Build base image first
./base/build.sh || { echo "Failed to build base image. Aborting."; exit 1; }

# Builld other images (no order required)
FILES=$(find . -type f -name "Dockerfile" | grep -vE "^\./base/Dockerfile$|^\./lib/Dockerfile$")
while IFS= read -r FILE; do
	$(dirname "$FILE")/build.sh || { echo "Failed to build $FILE. Aborting."; exit 1; }
done <<< "$FILES"
}

echo "Success!"

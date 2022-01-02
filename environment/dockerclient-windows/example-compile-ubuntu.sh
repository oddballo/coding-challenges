#!/bin/bash
if ! command -v unzip &> /dev/null; then
	sudo apt update \
		&& sudo apt install unzip -y \
		|| { echo "Failed to install unzip. Aborting."; exit 1; }
fi

if ! command -v docker &> /dev/null; then
	echo "Missing Docker. \
		Please install and configure docker first. \
		Aborting."
	exit 1
fi

if [ ! -f 'v20.10.12.zip' ]; then 
	wget https://github.com/docker/cli/archive/refs/tags/v20.10.12.zip \
		|| { echo "Failed to download v20.12.12.zip. Aborting."; \
			exit 1; }
fi

if [ -d 'cli-20.10.12' ]; then
	rm -Rf cli-20.10.12
fi

unzip v20.10.12.zip \
	&& cd cli-20.10.12 \
	&& docker buildx bake --set binary.platform=windows/amd64 \
	|| { echo "There was a problem trying to build the docker command line executable for windows. Aborting."; exit 1; }

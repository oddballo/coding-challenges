#!/bin/bash

docker image build . \
	--build-arg IMAGE_PARENT="$IMAGE_PARENT" \
	--tag "$NAME:$TAG" \
	--tag "$NAME:latest"

#!/bin/bash

NAME="owendavies-coding-challenge-cpp-cpp11"
TAG="0.0.1"
IMAGE_PARENT="owendavies-coding-challenge-base:0.0.1"
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
{
cd "$DIR"
. "$DIR/../../lib/build.sh"
}


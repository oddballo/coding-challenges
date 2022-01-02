#!/bin/bash

NAME="owendavies-coding-challenge-base"
TAG="0.0.1"
IMAGE_PARENT="ubuntu:focal-20211006"
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
{
cd "$DIR"
. "$DIR/../../lib/build.sh"
}

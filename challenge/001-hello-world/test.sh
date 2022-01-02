#!/bin/bash

OUTPUT=$(</dev/stdin)
if [[ "$OUTPUT" != "Hello World" ]]; then
	exit 1
fi

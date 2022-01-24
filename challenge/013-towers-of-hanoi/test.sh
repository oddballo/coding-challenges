#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./test.sh N"
	exit 1
fi

OUTPUT="$(</dev/stdin)"

ANSWER_1="$(<result1.txt)"
ANSWER_2="$(<result2.txt)"
ANSWER_3="$(<result3.txt)"
VARNAME="ANSWER_$1"
if [ -z ${!VARNAME+x} ]; then
	echo "Undefined ANSWER_$1. Aborting."
	exit 1
fi

if [[ "$OUTPUT" == "${!VARNAME}" ]]; then
	exit 0
else
	printf "Expected: \n\n<<<${!VARNAME}>>>\n\n"
	echo 
	printf "Output: \n\n<<<${OUTPUT}>>>\n\n" 
	exit 1
fi

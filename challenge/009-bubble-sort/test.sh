#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./test.sh N"
	exit 1
fi

OUTPUT=$(</dev/stdin)

IFS= read -r -d '' ANSWER_1 <<"EOF"
1,2,4,6,7,10
EOF
VARNAME="ANSWER_$1"
if [ -z ${!VARNAME+x} ]; then
	echo "Undefined ANSWER_$1. Aborting."
	exit 1
fi

# Add trailing new line to output
IFS= read -r -d '' OUTPUT <<EOF
$OUTPUT
EOF

if [[ "$OUTPUT" == "${!VARNAME}" ]]; then
	exit 0
else
	printf "Expected: \n\n<<<${!VARNAME}>>>\n\n"
	echo 
	printf "Output: \n\n<<<${OUTPUT}>>>\n\n" 
	exit 1
fi

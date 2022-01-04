#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./test.sh N"
	exit 1
fi

OUTPUT=$(</dev/stdin)

IFS= read -r -d '' ANSWER_20 <<"EOF"
Invalid
EOF
IFS= read -r -d '' ANSWER_19 <<"EOF"
     0  0  0 

   0  0  0  0 

  0  0  0  0  0 

   0  0  0  0 

     0  0  0 
EOF
IFS= read -r -d '' ANSWER_7 <<"EOF"
   0  0 

  0  0  0 

   0  0 
EOF
IFS= read -r -d '' ANSWER_1 <<"EOF"
  0 
EOF
IFS= read -r -d '' ANSWER_37 <<"EOF"
      0  0  0  0 

     0  0  0  0  0 

   0  0  0  0  0  0 

  0  0  0  0  0  0  0 

   0  0  0  0  0  0 

     0  0  0  0  0 

      0  0  0  0 
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

if [[ "${OUTPUT}" == "${!VARNAME}" ]]; then
	exit 0
else
	exit 1
fi

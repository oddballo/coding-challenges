#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
{
cd "$DIR"
FILES=$(find . -name "run.sh" -type f)
FAILURE=0

while IFS= read -r FILE; do
	printf "%20s: \n" "$FILE"
	printf "%20s Test Scenario '1': " "" \
		&& "$FILE" "1110111000111010000100010101000100111011100011101111000001010001010111101110001110111" \
		| bash test.sh 1 && echo "Success!" || { echo "Failure"; FAILURE=1; }
	printf "%20s Test Scenario '2': " "" \
		&& "$FILE" "0100111000101011111001010101010101010011100011101110100001010001010111100010000010111" \
		| bash test.sh 2 && echo "Success!" || { echo "Failure"; FAILURE=1; }
done <<< "$FILES"
exit $FAILURE
}

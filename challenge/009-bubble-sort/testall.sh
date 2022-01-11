#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
{
cd "$DIR"
FILES=$(find . -name "run.sh" -type f)
FAILURE=0

while IFS= read -r FILE; do
	printf "%20s: \n" "$FILE"
	printf "%20s Test Scenario '1': " "" \
		&& "$FILE" "7,6,2,10,1,4" \
		| bash test.sh 1 && echo "Success!" || { echo "Failure"; FAILURE=1; }
done <<< "$FILES"
exit $FAILURE
}

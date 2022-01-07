#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
{
cd "$DIR"
FILES=$(find . -name "run.sh" -type f)
FAILURE=0

while IFS= read -r FILE; do
	printf "%20s: \n" "$FILE"
	printf "%20s Test Scenario '1': " "" && "$FILE" "A1,C1,B2,B3,D2,E2,E4,E5,A5" 9 "A1,B2,C3,D4,E5,E4" 6 \
		| bash test.sh 1 && echo "Success!" || { echo "Failure"; FAILURE=1; }
done <<< "$FILES"
exit $FAILURE
}

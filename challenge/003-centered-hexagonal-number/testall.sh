#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
{
cd "$DIR"
FILES=$(find . -name "run.sh" -type f)
FAILURE=0

while IFS= read -r FILE; do
	printf "%20s: \n" "$FILE"
	printf "%20s Argument '1': " "" && "$FILE" 1 | bash test.sh 1 && echo "Success!" || { echo "Failure"; FAILURE=1; }
	printf "%20s Argument '7': " "" && "$FILE" 7 | bash test.sh 7 && echo "Success!" || { echo "Failure"; FAILURE=1; }
	printf "%20s Argument '19': " "" && "$FILE" 19 | bash test.sh 19 && echo "Success!" || { echo "Failure"; FAILURE=1; }
	printf "%20s Argument '20': " "" && "$FILE" 20 | bash test.sh 20 && echo "Success!" || { echo "Failure"; FAILURE=1; }
	printf "%20s Argument '37': " "" && "$FILE" 37 | bash test.sh 37 && echo "Success!" || { echo "Failure"; FAILURE=1; }

done <<< "$FILES"
exit $FAILURE
}

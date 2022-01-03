#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TESTS=(
"0-[0, 0, 0, 1, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0, 0, 0],[0, 1, 0, 0, 0, 1, 0, 0],[0, 0, 0, 0, 1, 0, 1, 0],[0, 1, 0, 0, 0, 1, 0, 0],[0, 0, 0, 0, 0, 0, 0, 0],[0, 1, 0, 0, 0, 0, 0, 1],[0, 0, 0, 0, 1, 0, 0, 0]"
"1-[1, 0, 1, 0, 1, 0, 1, 0],[0, 1, 0, 1, 0, 1, 0, 1],[0, 0, 0, 0, 1, 0, 1, 0],[0, 0, 1, 0, 0, 1, 0, 1],[1, 0, 0, 0, 1, 0, 1, 0],[0, 0, 0, 0, 0, 1, 0, 1],[1, 0, 0, 0, 1, 0, 1, 0],[0, 0, 0, 1, 0, 1, 0, 1]"
"1-[0, 0, 0, 0, 1, 0, 0, 0],[0, 0, 0, 0, 0, 1, 0, 0],[0, 0, 0, 1, 0, 0, 0, 0],[1, 0, 0, 0, 0, 0, 0, 0],[0, 0, 0, 0, 1, 0, 0, 0],[0, 0, 0, 0, 0, 1, 0, 0],[0, 0, 0, 0, 0, 1, 0, 0],[1, 0, 0, 0, 0, 0, 0, 0]"
)

{
cd "$DIR"
FILES=$(find . -name "run.sh" -type f)
FAILURE=0
while IFS= read -r FILE; do
	printf "%20s: \n" "$FILE"
	for INDEX in ${!TESTS[@]}; do
		TEST="${TESTS[$INDEX]}"
		EXPECTED=$(echo "$TEST" | cut -f 1 -d"-")
		INPUTDATA=$(echo "$TEST" | cut -f 2 -d"-")
		"$FILE" "$TEST"
		RESULT="$?"
		printf "%20s\tTest %d: " " " "$INDEX"
		if [[ "$RESULT" == "$EXPECTED" ]]; then
			echo "Success!"
		else
			echo "Failure"
			FAILURE=1
		fi
	done
done <<< "$FILES"
exit $FAILURE
}

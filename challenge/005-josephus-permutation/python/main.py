#!/usr/bin/python

import sys

if len(sys.argv) != 3:
    print("Usage: ./main.py <prisonerCount> <step>")
    exit(1)

prisonerCount = int(sys.argv[1])
step = int(sys.argv[2])
prisoners = [i for i in range(prisonerCount)]

index = 0;
while len(prisoners) > 1:
    index = (index - 1 + step) % len(prisoners);
    del prisoners[index]

print(prisoners[0])
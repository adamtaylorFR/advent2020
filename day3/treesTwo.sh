#!/bin/bash
input="day3/input"
width=31
sideStep=1
side=1
downStep=1
downs=0
opens=0
trees=0
skip=0
# ......##.###..##.#.###......#.#
while IFS= read -r line
do
  echo "$line"
  echo "$square and $downs, $side "
  if [ $skip -eq 0 ]; then
    skip=1
    side=$(( (1 + $sideStep * $downs) % $width))
    square="${line:$(("$side" - 1)):1}"
    downs=$((downs + $downStep))
    if [[ $square == "#" ]];then
      trees=$(($trees + 1))
    else
      opens=$(($opens + 1))
    fi
  else
    skip=0
  fi


done < "$input"

echo "$trees trees and $opens opens"

# Right 1, down 1. 72
# Right 3, down 1. 207
# Right 5, down 1. 90
# Right 7, down 1. 60
# Right 1, down 2. 33

# 2655892800

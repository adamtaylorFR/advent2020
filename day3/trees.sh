#!/bin/bash
input="day3/input"
width=31
side=1
downs=0
opens=0
trees=0

# ......##.###..##.#.###......#.#
while IFS= read -r line
do
  echo "$line"
  side=$(( (1 + 3 * $downs) % $width))
  square="${line:$(("$side" - 1)):1}"
  downs=$((downs + 1))
  echo "$square and $downs, $side "
  if [[ $square == "#" ]];then
    trees=$(($trees + 1))
  else
    opens=$(($opens + 1))
  fi

done < "$input"

echo "$trees trees and $opens opens"

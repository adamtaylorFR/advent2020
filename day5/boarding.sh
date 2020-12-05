#!/bin/bash
input="day5/input"
high_seat=0
row_min=0
row_max=127
seat_min=0
seat_max=7
score_max=0
seat_map=""

a=0
while [[ "$a" -lt "$(( ("$row_max" + 1) * ("$seat_max" + 1) ))" ]]; do
  seat_map="$seat_map""_"
  a="$(("$a" + 1))"
done

while IFS= read -r line
do
  echo "$line"
  row_text="${line:0:7}"
  seat_text="${line:7:3}"

  a=0
  min="$row_min"
  max="$row_max"
  while [[ "$a" -lt "${#row_text}" ]]; do
    #echo "${row_text:$a:1} - $max $min"
    if [[ "${row_text:$a:1}" == "F" ]]; then
      max="$(( "$max" - (("$max" - "$min") / 2) - 1 ))"
    else
      min="$(( "$min" + (("$max" - "$min") / 2) + 1 ))"
    fi
    a="$(("$a" + 1))"
  done
  row="$(($min))"

  a=0
  min="$seat_min"
  max="$seat_max"
  while [[ "$a" -lt "${#seat_text}" ]]; do
    #echo "${seat_text:$a:1} - $max $min"
    if [[ "${seat_text:$a:1}" == "L" ]]; then
      max="$(( "$max" - (("$max" - "$min") / 2) - 1 ))"
    else
      min="$(( "$min" + (("$max" - "$min") / 2) + 1 ))"
    fi
    a="$(("$a" + 1))"
  done
  seat="$(($min))"
  calc=$(( $row * 8 + $seat ))
  if [[ "$score_max" -lt "$calc" ]]; then
    score_max="$calc"
  fi
  echo "$row, $seat, $calc "
  index=$(( "$row" * ("$seat_max" + 1) + "$seat" ))
  seat_map="${seat_map:0:index-1}X${seat_map:index}"
done < "$input"

empties=$(echo "$seat_map" | awk '{for(i=1;i<=length($0);i++) {if (substr($0,i,1)=="_") {print i}}}')
echo "$seat_map"
readarray -t empties <<<"$empties"
for item in "${empties[@]}"
do
  echo "id "$item" row $(( "$item" / ("$seat_max" + 1) ))  seat $(( "$item" % ("$seat_max" + 1) )) "
done

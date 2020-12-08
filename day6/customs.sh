#!/bin/bash
input="day6/input"
counts=()
total=0

buffer=""
while IFS= read -r line
do
  #echo "$line"

  if [[ -z "${line// }" ]]; then
    # a inter-group gap
    #echo "Pass - |$buffer|"
    buffer="$(echo -e "${buffer}" | tr -d '[:space:]')"
    for (( i=0 ; i < ${#buffer} ; i++ )) {
      # pack counts
        quest=${buffer:i:1}
        index=$(( "$(echo "$quest" | tr -d "\n" | od -An -t dC)" - 97 ))
        counts["$index"]=$(( counts["$index"] + 1 ))
    }
    for item in "${counts[@]}"
    do
      #sum unique
      #echo "$item"
      total=$(( "$total" + 1 ))
    done
    buffer=""
    counts=()
  fi
  buffer="$buffer $line"
done < "$input"

echo "$total is total"

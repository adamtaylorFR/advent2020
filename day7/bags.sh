#!/bin/bash
input="day7/input"
all_done=0
uncheckedBags=("shiny gold")
checkedBags=()
while [[ all_done -eq 0 ]]; do
  all_done=1
  for checkBag in "${uncheckedBags[@]}"
   do
    echo "Check $checkBag"
    rowsBlob=$(cat "$input" | grep "$checkBag")
    if [[ !(" ${checkedBags[@]} " =~ " ${checkBag} ") ]]; then
      #echo "save $checkBag"
      checkedBags+=("$checkBag")
    fi
    readarray -t rows <<<"$rowsBlob"
    toDelete=()
    for row in "${rows[@]}"
    do
      #go through bags this one fits in
      bag=$(echo "$row" | awk -F " bags" '{print $1}')
      if [[ !(" ${checkedBags[@]} " =~ " ${bag} ") ]]; then
        uncheckedBags+=("${bag}")
        #echo "new $bag"
        all_done=0
      fi
      toDelete+=( "$checkBag" )
    done
    #delete old ones
    for target in "${toDelete[@]}"; do
      for i in "${!uncheckedBags[@]}"; do
        if [[ ${uncheckedBags[i]} = $target ]]; then
          unset 'uncheckedBags[i]'
        fi
      done
    done
    echo "-------"
  done
done
echo "Can use $(( ${#checkedBags[@]} - 1 )) bags"
for checkBag in "${checkedBags[@]}"; do
  echo "$checkBag"
done

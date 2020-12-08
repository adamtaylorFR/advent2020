#!/bin/bash
input="day7/example"
all_done=0
uncheckedBags=("shiny gold")
checkedBags=()
while [[ all_done -eq 0 ]]; do
  all_done=1
  for checkBag in "${uncheckedBags[@]}"
   do
    echo "Check $checkBag"
    rowsBlob=$(cat "$input" | grep "^$checkBag")
    if [[ !(" ${checkedBags[@]} " =~ " ${checkBag} ") ]]; then
      echo "save $checkBag as $rowsBlob"
      checkedBags+=("$rowsBlob")
    fi
    rowsBlob=$( echo "$rowsBlob" | grep -oP '(?<=[[:digit:]]).*?(?=bag)')
    readarray -t rows <<<"$rowsBlob"
    toDelete=()
    for row in "${rows[@]}"
    do
      #go through bags this one holds
      if [[ !(" ${checkedBags[@]} " =~ " ${bag} ") ]]; then
        row="$(echo -e "${row}" | sed -e 's/^[[:space:]]*//')"
        uncheckedBags+=("${row}")
        all_done=0
        echo "add $row"
      fi
    done
    toDelete+=( "$checkBag" )
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


working on this plan make an outut of all the lines with bags gold -> olive, plumb
olive -> blue, black

maybe cheat

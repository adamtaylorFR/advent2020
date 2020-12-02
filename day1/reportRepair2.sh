#!/bin/bash
input="/home/adamtaylor/Documents/Code/adventCode/day1/input"
array=()

while IFS= read -r line
do
  #echo "$line"
  if [ "$line" -lt 2000 ]
  then
    array+=("$line")
  fi

done < "$input"
for oneVal in "${array[@]}"
do
     for twoVal in "${array[@]}"
      do
           for threeVal in "${array[@]}"
            do
                 total="$(("$threeVal" +"$twoVal" + "$oneVal"))"
                  if [ "$total" -eq 2020 ]
                  then
                    echo "$oneVal + $twoVal + $threeVal= 2020 * = $(("$threeVal" * "$twoVal" * "$oneVal"))"
                    exit
                  fi
            done
      done
done

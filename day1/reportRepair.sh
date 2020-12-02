#!/bin/bash
input="/home/adamtaylor/Documents/Code/adventCode/day1/input"
bigArray=()
littleArray=()
while IFS= read -r line
do
  #echo "$line"
  if [ "$line" -ge 1000 ]
  then
    bigArray+=("$line")
    else
    littleArray+=("$line")
  fi

done < "$input"
for bigValue in "${bigArray[@]}"
do
     for littleValue in "${littleArray[@]}"
      do
           total="$(("$littleValue" + "$bigValue"))"
            if [ "$total" -eq 2020 ]
            then
              echo "$bigValue + $littleValue = 2020 * = $(("$littleValue" * "$bigValue"))"
              exit
            fi
      done
done

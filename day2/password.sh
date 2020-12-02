#!/bin/bash
badPasswords=0
goodPasswords=0
input="/home/adamtaylor/Documents/Code/adventCode/day2/input"
while IFS= read -r line
do
  echo "$line"
  IFS=':' read -r -a array <<< "$line"
  password="${array[1]}"
  IFS=' ' read -r -a rules <<< "${array[0]}"
  total=$(awk -F"${rules[1]}" '{print NF-1}' <<< "${password}")
  IFS='-' read -r -a count <<< "${rules[0]}"
  echo "${count[0]} to ${count[1]} of ${rules[1]} in ${password} counts to $total"
  if  (( "${count[0]}" > "$total" )) || (( "${count[1]}" < "$total" ))
  then
    badPasswords="$(("$badPasswords" + 1))"
    else
    goodPasswords="$(("goodPasswords" + 1))"
  fi
done < "$input"

echo "Bad = $badPasswords, good = $goodPasswords"

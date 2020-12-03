#!/bin/bash
badPasswords=0
goodPasswords=0
input="/home/adamtaylor/Documents/Code/adventCode/day2/input"
while IFS= read -r line; do
  #echo "$line"
  IFS=':' read -r -a array <<<"$line"
  password="${array[1]}"
  IFS=' ' read -r -a rules <<<"${array[0]}"
  IFS='-' read -r -a count <<<"${rules[0]}"
  letterOne="${password:$(("${count[0]}")):1}"
  letterTwo="${password:$(("${count[1]}")):1}"
  if [[ "$letterOne" == "${rules[1]}" ]] || [[ "$letterTwo" == "${rules[1]}" ]]; then #at least one match
      if  [[ "$letterOne" != "$letterTwo"  ]]; then # only one match
        goodPasswords="$(("goodPasswords" + 1))"
      else
        badPasswords="$(("$badPasswords" + 1))"
      fi
  else
    badPasswords="$(("$badPasswords" + 1))"
  fi
done <"$input"

echo "Bad = $badPasswords, good = $goodPasswords"

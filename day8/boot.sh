#!/bin/bash
input="day8/example"
workingCopy="day8/working"
rm "$workingCopy"
cp "$input" "$workingCopy"
accumulate=0
lineNumber=1
while [[ all_done -eq 0 ]]; do
  #read instruction
  instruction=$(sed -n "$lineNumber"p "$workingCopy")
  sed -i "${lineNumber}s/$instruction/USED/g" "$workingCopy"
  #execute
  opperand=$(echo "$instruction" | awk -F' ' '{print $2}')
  #echo "$instruction - $opperand"
  if [[ "$instruction" == "nop"* ]]; then
    lineNumber=$(( "$lineNumber" + 1 ))
  elif [[ "$instruction" == "acc"*  ]]; then
    #echo "amount $opperand and $accumulate"
    accumulate=$(( "$accumulate" + "$opperand" ))
    #echo "$accumulate"
    lineNumber=$(( "$lineNumber" + 1 ))
  elif [[ "$instruction" == "jmp"*  ]]; then
    lineNumber=$(( "$lineNumber" + "$opperand" ))
  elif [[ "$instruction" == "USED"*  ]]; then
    all_done=1
  else
    echo "Unknown instruction $instruction"
  fi
  echo "----"
  echo "next line $lineNumber value $accumulate"
done

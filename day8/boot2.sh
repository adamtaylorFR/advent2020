#!/bin/bash
input="day8/input"
workingCopy="day8/working"
referenceCopy="day8/reference"
rm "$workingCopy"
rm "$referenceCopy"
cp "$input" "$workingCopy"
cp "$input" "$referenceCopy"
accumulate=0
lineNumber=1
maxLines=$(wc -l "$workingCopy" | awk '{ print $1 }')

flipFrom="jmp"
flipTo="nop"

while [[ all_done -eq 0 ]]; do
  #swap an instruction in refernce and get line
  flipLine=$(grep -n -m 1 "$flipFrom" "$referenceCopy" | sed  's/\([0-9]*\).*/\1/')
  sed -i "0,/$flipFrom/s//TESTED/" "$referenceCopy"
  #flip line in real workingCopy
  sed -i "${flipLine}s/$flipFrom/$flipTo/g" "$workingCopy"
  echo "flipped |$flipLine|"
  inner_done=0
  while [[ inner_done -eq 0 ]]; do
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
      echo "Not by flipping $flipLine"
      all_done=0
      inner_done=1
      #bad exit reset
      cp "$input" "$workingCopy"
      accumulate=0
      lineNumber=1
    elif [[ "$instruction" == "exit"*  ]]; then
      all_done=1
      inner_done=1
      echo "Safe exit"
      echo "next line $lineNumber value $accumulate"
    else
      echo "Unknown instruction $instruction"
    fi
  done
  if [[ -z "${flipLine// }" ]]; then
    echo "nothing left to flip"
    exit
  fi
done

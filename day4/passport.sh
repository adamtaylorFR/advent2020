#!/bin/bash
input="example"#"input"
north_poll=0
passport=0
bad=0


#byr (Birth Year)
#iyr (Issue Year)
#eyr (Expiration Year)
#hgt (Height)
#hcl (Hair Color)
#ecl (Eye Color)
#pid (Passport ID)
#cid (Country ID)
buffer=""
while IFS= read -r line
do
  #echo "$line"
  if [[ -z "${line// }" ]]; then
    # a inter-pass gap
    echo "Pass - |$buffer|"
    #validate
    if [[ $buffer == *"byr"* ]] && [[ $buffer == *"iyr"* ]] && [[ $buffer == *"eyr"* ]] && [[ $buffer == *"hgt"* ]] && [[ $buffer == *"hcl"* ]] && [[ $buffer == *"ecl"* ]] && [[ $buffer == *"pid"* ]] ; then
      echo "Is a pass or np"
      if [[ $buffer == *"cid"* ]]; then
        passport=$(("$passport" + 1 ))
      else
        north_poll=$(("$north_poll" + 1 ))
      fi
    else
      bad=$(("$bad" + 1 ))
    fi
    buffer=""
  else
    buffer="$buffer""$line"
  fi


done < "$input"

echo "$north_poll northpoll and $passport passport for $(($north_poll + $passport)) total"

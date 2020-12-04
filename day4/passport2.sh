#!/bin/bash
input="input"
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
  badvalid="good"
  #echo "$line"
  if [[ -z "${line// }" ]]; then
    # a inter-pass gap

    #validate
    if [[ $buffer == *"byr"* ]] && [[ $buffer == *"iyr"* ]] && [[ $buffer == *"eyr"* ]] && [[ $buffer == *"hgt"* ]] && [[ $buffer == *"hcl"* ]] && [[ $buffer == *"ecl"* ]] && [[ $buffer == *"pid"* ]] ; then
      echo "Pass - |$buffer|"
      # more validate
      byr=$(echo "$buffer" | awk  -F "byr:" '{print $2}' | awk  -F' ' '{print $1}')
      iyr=$(echo "$buffer" | awk  -F "iyr:" '{print $2}' | awk  -F' ' '{print $1}')
      eyr=$(echo "$buffer" | awk  -F "eyr:" '{print $2}' | awk  -F' ' '{print $1}')
      echo "byr $byr iyr $iyr eyr $eyr"
      if [ "$byr" -le 2002 ] && [ "$byr" -ge 1920 ] && [ "$iyr" -le 2020 ] && [ "$iyr" -ge 2010 ] && [ "$eyr" -le 2030 ] && [ "$eyr" -ge 2020 ]; then
        echo "years good"
      else
        badvalid="bad"
      fi
      hgt=$(echo "$buffer" | awk  -F "hgt:" '{print $2}' | awk  -F' ' '{print $1}')
      echo "hgt $hgt"
      if [[ $hgt == *"in" ]]; then
        hgt=$(echo "$hgt" | awk  -F "in" '{print $1}')
        if [ "$hgt" -le 76 ] && [ "$hgt" -ge 59 ]; then
          echo "hight in good"
        fi
      elif [[ $hgt == *"cm" ]]; then
        hgt=$(echo "$hgt" | awk  -F "cm" '{print $1}')
        if [ "$hgt" -le 193 ] && [ "$hgt" -ge 150 ]; then
          echo "hight cm good"
        fi
      else
         badvalid="bad"
      fi
      hcl=$(echo "$buffer" | awk  -F "hcl:" '{print $2}' | awk  -F' ' '{print $1}')
      echo "$hcl"
      if [[ "${hcl:0:1}" == "#" ]] && [[ "${hcl:1:7}" =~ ^[0-9A-Fa-f]{1,}$ ]] && [[ ${#hcl} -eq 7 ]]; then
         echo "hair good";
      else
         badvalid="bad"
      fi
      ecl=$(echo "$buffer" | awk  -F "ecl:" '{print $2}' | awk  -F' ' '{print $1}')
      echo "$ecl"
      if  [[ $ecl == *"amb"* ]] || [[ $ecl == *"gry"* ]] || [[ $ecl == *"blu"* ]] || [[ $ecl == *"brn"* ]] || [[ $ecl == *"grn"* ]] || [[ $ecl == *"hzl"* ]] | [[ $ecl == *"oth"* ]] && [[ ${#ecl} -eq 3 ]];then
         echo "eye good";
      else
         badvalid="bad"
      fi
      pid=$(echo "$buffer" | awk  -F "pid:" '{print $2}' | awk  -F' ' '{print $1}')
      echo "$pid"
      if [[ "$pid" =~ ^[0-9]{1,}$ ]] && [[ ${#pid} -eq 9 ]]; then
         echo "pass# good";
      else
         badvalid="bad"
      fi



      if [[ $badvalid == *"bad"* ]]; then
        bad=$(("$bad" + 1 ))
      elif [[ $buffer == *"cid"* ]]; then
        echo "pass good"
        passport=$(("$passport" + 1 ))
      else
        echo "north good"
        north_poll=$(("$north_poll" + 1 ))
      fi
    else
      bad=$(("$bad" + 1 ))
    fi
    buffer=""
  else
    buffer="$buffer"" ""$line"
  fi


done < "$input"

echo "$north_poll northpoll and $passport passport for $(($north_poll + $passport)) total"

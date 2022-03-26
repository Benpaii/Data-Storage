#!/bin/bash
# Create a loop that looks for'Hawaii'
states=('Nebraska' 'California' 'Texas' 'Hawaii' 'Washington')

for state in ${states[A]}
	do

	if [ $state == 'Hawaii' ];
	then
echo "Hawaii is the best!"
	else
echo "I'm not a fan of Hawaii."
	fi
done

# Create For Loops
# Create a loop that prints 3, 5, or 7
for num in ${nums[@]}
do
  if [ $num = 3 ] || [ $num = 5 ] || [ $num = 7 ]
  then
    echo $num
  fi
done


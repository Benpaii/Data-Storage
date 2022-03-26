#!/bin/bash

# Check for research directory. Create it if needed.
if [ ! -d $HOME/research ]
then
	mkdir $HOME/research
fi

# Check for output file. Clear it if needed.
if [ -f $output ]
then
	rm $output
fi



echo "A Quick System Audit Script" >> $output

date >> $output

echo "" >> $output

echo "Machine Type Info:" >> $output

echo -e "$MACHTYPE \n" >> $output

echo -e "Uname info: $(uname -a) \n" >> $output

echo -e "IP Info: $(ip addr | grep inet | head -9 | tail -1) \n" >> $output

echo "Hostname: $(hostname -s) " >> $output

# Paths of shadow and passwd files
files=('/etc/passwd' '/etc/shadow')

echo -e "\nThe permissions for sensitive /etc files: \n" >> $output
for file in ${files[@]}
do
ls -l $file >> $output
done

#Display CPU usage
echo -e "\nCPU Info:" >> $output
lscpu | grep CPU >> $output

# Display Disk usage
echo -e "\nDisk Usage:" >> $output
df -H | head -2 >> $output

#Display the current user
echo -e "\nCurrent user login information: \n $(who -a) \n" >> $output



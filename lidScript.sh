#!/bin/bash
#script to change behaviour when closing lid

FILE=/etc/systemd/logind.conf

printf "\033[1;37mWhat should I do when closing the lid: \n" 
printf "Current status :\033[1;31m "
sed -n '/HandleLidSwitch/p' $FILE #print line
printf "\033[1;33m1 - Suspend \n2 - Power Off \n3 - Nothing \n"
printf "\033[1;37mAnswer : "
read  input 

if [ $input == 1 ] 
then 
    sed -i '22s/.*/HandleLidSwitch=suspend/' $FILE #search for line and replace
    printf "Done \033[1;31m \n"
    sed -n '/HandleLidSwitch/p' $FILE #print line
    restart systemd-logind
    printf "\033[0m"
elif [ $input == 2 ]
then
    sed -i '22s/.*/HandleLidSwitch=poweroff/' $FILE #search for line and replace
    printf "Done \033[1;31m \n"
    sed -n '/HandleLidSwitch/p' $FILE #print line
    restart systemd-logind
    printf "\033[0m"
elif [ $input == 3 ]
then
    sed -i '22s/.*/HandleLidSwitch=ignore/' $FILE #search for line and replace
    printf "Done \033[1;31m \n"
    sed -n '/HandleLidSwitch/p' $FILE #print line
    restart systemd-logind
    printf "\033[0m"
else
    printf  "Wrong option \033[0m \n"
fi

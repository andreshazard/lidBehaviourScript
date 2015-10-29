#!/bin/bash
#script to change behaviour when closing lid

FILE=/etc/systemd/logind.conf
action=''

printf "\033[1;37mWhat should I do when closing the lid: \n" 
printf "Current status :\033[1;31m "
sed -n '/HandleLidSwitch/p' $FILE #print line
printf "\033[1;33m1 - Suspend \n2 - Power Off \n3 - Nothing \n4 - Ignore\n"
printf "\033[1;37mAnswer : "
read  input

case $input in 
    1)  
        action='suspend'
        ;;
    2) 
        action='poweroff'
        ;;
    
    3)  action='hibernate'
        ;; 
    
    4)  
        action='ignore'
        ;;
    *)
        printf  "Wrong option \033[0m \n"
        ;;
esac

if [ -n "$action" ]
then
sed -i "22s/.*/HandleLidSwitch=$action/" $FILE #search for line and replace
printf "Done \033[1;31m \n"
sed -n '/HandleLidSwitch/p' $FILE #print line
restart systemd-logind
printf "\033[0m"
fi

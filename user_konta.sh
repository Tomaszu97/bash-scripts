#!/bin/bash

function helpmessage
{
    echo "USAGE: ./user_konta.sh <first_username> <second_username> ..."
    echo "USAGE: creates usernames with temporary passwords"
}

#check if program is run as sudo - if not rerun script with sudo at beginning then exit
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

#iterate through all parameters
for username in $@
do
    #check input correctness
    if [[ $username =~ ^[A-Za-z0-9_]+$ ]]
    then
        #find username in /etc/passwd
        if grep -q "^$username" /etc/passwd
            then
                echo "ERROR: user $username already exists!" 1>&2
                helpmessage
                exit 1
            else
                #create user
                useradd -m $username > /dev/null
                echo "$username:$username" | chpasswd $username > /dev/null
                passwd -e $username > /dev/null
                echo "created user $username with folder and temporary password!"
        fi
    else
        echo "ERROR: incorrect input!" 1>&2
        helpmessage
        exit 1
    fi
done



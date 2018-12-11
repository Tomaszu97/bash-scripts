#!/bin/bash

function helpmessage
{
    echo "USAGE: ./prawa_dostepu.sh XXX <file_or_folder_1> <file_or_folder_2> ..."
    echo "USAGE: XXX is numeric permission representation (3 numbers 0 to 7)."
    echo "USAGE: this script sets permissions for given files"
}

#check number of parameters
if [[ $# -lt 2 ]]
then
    echo "ERROR: not enough parameters! must be 2 or more!" 1>&2
    helpmessage
    exit 1
else
    #check permission input correctness
    if [[ $1 =~ ^[0-7][0-7][0-7]$ ]]
    then
        echo "setting $1 file permissions ..."
        #iterate through next parameters
        for var in "${@:2}"
        do
            #check if file/directory exists
            if [[ -e "$var" ]]
            then
                #check if you're the owner of this file/directory  
                if [[ $(stat -c %U $var) == "$USER" ]]
                then
                    chmod "$1" "$var"
                    echo "$var now has $1 permission"
                else
                echo "ERROR: you are not the owner of $var!" 1>&2
                helpmessage
                exit 1
                fi
            else
                echo "ERROR: file $var does not exist!" 1>&2
                helpmessage
                exit 1
            fi

        done
        
    else
        echo "ERROR: incorrect permission format! use something like 567 or 666" 1>&2
        helpmessage
        exit 1
    fi
fi


#!/bin/bash

function helpmessage
{
    echo "USAGE: ./wyczysc_dowiazania.sh <folder_name>"
    echo "USAGE: removes all symlinks in specified folder"
}

#check if theres no arguments
if [[ $# == 0 ]]
then
    echo "ERROR: no folder specified!" 1>&2
    helpmessage
    exit 1
fi

#check if there are too many arguments
if [[ $# > 1 ]]
then
    echo "ERROR: too many arguments!" 1>&2
    helpmessage
    exit 1
fi

#check if folder exists
if [[ $(cd $1 2>&1 1>/dev/null) ]]
then
    echo "ERROR: no such folder!" 1>&2
    helpmessage
    exit 1
fi

#go to specified folder
cd $1
echo "removing all symlinks in $1 folder ..."

#iterate through all folder files and folders
for var in $(ls)
do

    #if it's a symlink
    if [[ -h $var ]]
    then
        
        echo "delete $var? (y)es or (n)o"
        read -n 1 input
        
        if [[ $input == "y" ]]
        then
            echo
            rm $var
            echo "$var removed"
        else
            echo
        fi
    
    fi

done
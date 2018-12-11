#!/bin/bash

function helpmessage
{
    echo "USAGE: ./polacz_pliki <plik1> <plik2> <plik3> ..."
    echo "USAGE: this script merges two or more files by appending \"pliki\" file"
}

#check number of parameters
if [[ $# -lt 2 ]]
then
    echo "ERROR: not enough parameters! must be 2 or more!" 1>&2
    helpmessage
    exit 1
else
    #crate empty file
    > pliki

    #iterate through parameters
    for var in $@
    do
        #if file exists and is not empty nor a directory nor a symlink
        if [[ -s $var && ! -d $var && ! -h $var ]]
        then
            #check if you have read and write permissions
            if [[ -r $var && -w $var ]]
            then
                echo "appending $var to pliki"
                cat $var >> pliki
            else
                echo "ERROR: you have no read and/or write permission for $var!" 1>&2
                helpmessage
                exit 1
            fi

        elif [[ -d $var ]]
        then
            echo "ERROR: $var is a directory!" 1>&2
            helpmessage
            exit 1

        elif [[ -h $var ]]
        then
            echo "ERROR: $var is a symlink!" 1>&2
            helpmessage
            exit 1

        elif [[ ! -e $var ]]
        then
            echo "ERROR: $var does not exist!" 1>&2
            helpmessage
            exit 1

        elif [[ ! -s $var ]]
        then
            echo "ERROR: $var exists but is empty!" 1>&2
            helpmessage
            exit 1
        else
            echo "ERROR: unknown error! shouldn't end up here!" 1>&2
            helpmessage
            exit 1
        fi

    done
fi
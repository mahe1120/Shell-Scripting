#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCEDIR="var\log\expense-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)


CHECK_ROOT()
{
    if [ $USERID -ne 0 ]
    then
        echo "ERROR::User needs sudo access to execute the script"
        exit 1
    fi
}

echo "Script started executing at :: $TIMESTAMP"

FILES_TO_DELETE=$(find $SOURCEDIR -name "*.log" -mtime +14)
echo "Files to be deleted : $FILES_TO_DELETE"

while read -r filepath
do 
    echo "Deleting the old files :: $filepath"
    rm -rf $filepath
    echo "Deleted the files: $filepath"
done <<< $FILES_TO_DELETE


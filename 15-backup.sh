#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
SOURCEDIR=$1
DEST_DIR=$2
DAYS=${3: -14} # If user did not provide no. of days then script will take 14 days as default.

CHECK_ROOT()
{
if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR $N::User doesnt have sudo access to execute the script"
    exit 1
fi
}

USAGE()
{
    #echo -e "$R USAGE:: $N sh 15-backup.sh <source-dir> <destination-dir> <days(optional)>"    
    echo -e "$R USAGE:: $N backup <source-dir> <destination-dir> <days(optional)>" 
    exit 1
}

if [ $# -lt 2 ]
then 
    USAGE
fi

if [ ! -d "$SOURCEDIR" ] # -d --> To check if directory exists.
then
    echo "$SOURCEDIR does not exists.. Please check"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]
then
    echo "$DEST_DIR does not exists.. Please check"
    exit 1
fi

echo "Script started executing at the timestamp :: $TIMESTAMP"

FILES=$(find $SOURCEDIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ] # -n --> true if there are files to zip.
then
    echo "Files are : $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCEDIR -name "*.log" -mtime +$DAYS | zip @ "$ZIP_FILE"
    if [ -f $ZIP_FILE ] # -f --> To check if file exists
    then 
        echo -e "Successflly created zip file for older files"
        while read -r filepath
        do
          echo "Deleting the files:: $filepath"
          rm -rf $filepath
          echo "Deleted the files: $filepath"
        done <<< $FILES
    else
        echo -e "$R ERROR :: $N Failed to create zip file"
        exit 1
    fi
else
    echo "No files found older than $DAYS"
fi







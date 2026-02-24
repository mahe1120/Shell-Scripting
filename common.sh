#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

LOGS_FOLDER="/var/log/expense-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE=$(echo $0 | cut -d "." -f1)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

mkdir -p $LOGS_FOLDER

CHECK_ROOT()
{
if [ $USERID -ne 0 ]
then
    echo "ERROR::User does not have sudo access"
    exit 1
fi
}

VALIDATE()
{
if [ $1 -ne 0 ]
    then
        echo -e "$2.. $R Failed $N"
        exit 1
else
        echo -e "$2.. $G SUCCESS $N"
fi
}
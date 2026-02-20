#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

LOGS_FOLDER="/var/log/expense-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE=$(echo $0 | cut -d "." -f1)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

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
}

CHECK_ROOT

echo "script started executing at :: $TIMESTAMP"

dnf list installed mysql # To Check if mysql is installed or not
if [ $? -ne 0 ]
then
    echo "MySQL is not installed."
    dnf install mysql
    VALIDATE $? "Installing MYSQL"
fi







#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

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

CHECK_ROOT

dnf list installed mysql # To Check if mysql is installed or not
if [ $? -ne 0 ]
then
    echo "MySQL is not installed."
    dnf install mysql -y
    VALIDATE $? "Installing MYSQL"
fi







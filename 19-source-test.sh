#!/bin/bash

source ./common.sh

CHECK_ROOT

echo "script started executing at :: $TIMESTAMP"

dnf list installed mysql &>>$LOG_FILE_NAME   # To Check if mysql is installed or not
if [ $? -ne 0 ]
then
    echo "MySQL is not installed."
    dnf install mysql -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing MYSQL"
fi
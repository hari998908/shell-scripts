#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F:%H:%M:%S)
SCRIPTNAME=$(echo $0 | cut -d "." f1)
LOGFILE=/tmp/$($SCRIPTNAME-$TIMESTAMP).log

echo "Script is Executing $TIMESTAMP"

if [$USERID -ne 0]
then
    echo "Please run the script with Root Access"
    exit 1
else
    echo "You are Super User"
fi

dnf install git -y &>>$LOGFILE

if [$? -ne 0]
then
    echo "GIT not installed"
    exit 1
else
    echo "GIT Successfully installed"
fi

if [$? -ne 0]

dnf install nginx -y &>>$LOGFILE
then 
    echo "ngnix insatllation Failed"
else
    echo "Nginish successfully installed"
fi


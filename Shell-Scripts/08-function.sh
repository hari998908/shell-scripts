#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

VALIDATE(){
    if [$1 -ne 0]
    then
        echo "$2...FAILURE"
        exit 1
    else
        echo "$2...SUCCESS"
    fi    
}

if [$USERID -ne 0]
them
    echo "Please run the script with root access"
    exit 1
else 
    echo "You are super user"
fi

dnf install mysql -y &>>LOGFILE
VALIDATE $? "Instaling SQL"

dnf install git -y &>>LOGFILE
VALIDATE $? "Installing Git"

dnf install docker -y &>>LOGFILE
VALIDATE $? "Installing Docker"



#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

echo "Script Started Executing at: $TIMESTAMP"

VALIDATE (){
    if [ $1 -ne 0 ]
    then
        echo -e "$2...$R Failure $N"
        exit 1
    else 
        echo -e "$2...$G Success $N"
    fi
}


if [ $USERID -ne 0 ]
then
    echo "Please run this script with Super User"
    exit 1
else
    echo "Ypou are super user"
fi

dnf install mysql -y &>>LOGFILE
VALIDATE $? "Installing MY SQL"

dnf install git -y &>>LOGFILE
VALIDATE $? "Installing GIT"

dnf install docker -y &>>LOGFILE
VALIDATE $? "Installing Docker"



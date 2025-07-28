#!/bin/bash

USERID=$(id -u)
DATE=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

read -s mysql_root_password
echo "This Script id Started at: $DATE"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2...$R FAILED $N"
        exit 1
    else
        echo -e "$2...$G SUCCESSFUL $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please login with Root User"
    exit 1
else
    echo "You are the Root User"
fi

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "MY SQL is Installing"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling MySQL Server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting MySQL Server"

mysql -h 172.31.20.24 -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
VALIDATE $? "Setting up root Password"
else
    echo -e "MySQL root password already set $Y SKIPPING...$N"
fi





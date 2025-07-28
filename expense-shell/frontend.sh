#!/bin/bash

USERID=$(id -u)
DATE=$(date +%F:%H:%M:%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$DATE.log

R="\e[31"
G="\e[32"
Y="\e[33"
N="\e[0"

echo "Script is started at: $DATE"

VALIDATE(){
    if [ $1 ne 0 ]
    then
        echo -e "$2..$R FAILED $N"
        exit 1
    else
        echo -e "$2..$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please login with the Root User"
    exit 1
else
    echo "You are the Root User"
fi

dnf install nginx -y &>>$LOGFILE
VALIDATE $? "Installing Nginx Server"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "Enabling Nginix"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "Starting Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing existing content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading frontend code"

cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Extracting frontend code"

cp /home/ec2-user/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copied expense conf"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting nginx"

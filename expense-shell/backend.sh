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
read -s mysql_root_password

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2...$R FAILED $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please login with the Root User"
    exit 1
else
    echo "You are the Root User"
fi

dnf module disable Nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling Node JS Module"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "Enabling NodeJS version:20"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "Installning Node JS"

id expense
if [ $? -ne 0 ]
then
useradd expense &>>$LOGFILE
VALIDATE $? "Creating Expense User"
exit 1
else 
    echo -e "Expense Usr is already created...$Y SKIPPING $N"
fi

mkdir -p /app &>>$LOGFILE
VALIDATE "Creating App Directry"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading backend code"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Extracting Back-End Code"

npm install &>>$LOGFILE
VALIDATE $? "Installing Node JS Dependencies"

cp /home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copied Backend Services"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Daemon Reload"

systemctl start backend &>>$LOGFILE
VALIDATE $? "Starting BackEnd"

systemctl enable backend &>>$LOGFILE
VALIDATE $? "Enabling BackEnd"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Installing MYSQL Client"

mysql -h db.daws78s.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting Back-End Service"




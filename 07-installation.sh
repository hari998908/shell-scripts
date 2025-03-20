#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

dnf remove mysql -y

if [ $? -ne 0 ]
then
    echo "Un Installation of mysql...FAILURE"
    exit 1
else
    echo "Un Installation of mysql...SUCCESS"
fi

dnf remove git -y

if [ $? -ne 0 ]
then
    echo "UnInstallation of git...FAILURE"
    exit 1
else
    echo "UnInstallation of Git...SUCCESS"
fi

echo "is script proceeding?"

#!/bin/bash

USERID=$(id -u)

if [$USERID -ne 0]
  then 
     echo "Run the script using Root Users"
  else
     echo "Youbare the root User" 
     exit 1
fi

dnf install mysql -y

if [$? -ne 0]
  then
    echo "My SQL installation...FAILED"
  else
    echo "MY SQL installation....SUCCESSFUL"
fi

dnf install git -y

if [$? -ne 0]
  then
    echo "Git installation ...FAILED"
  else
    echo "Git Installation....SUCCESSFUL"
 fi   
    
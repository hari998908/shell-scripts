#!/bin/bash

number=$1

if [$number -gte 10]
then 
    echo "Given number $number is greater than or equal to 10"
else
    echo "Given number $number is less than 10"
fi

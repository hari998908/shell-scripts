#!/bin/bash

names=("Hari" "Mamatha" "Chetahan" "Nivedha")

echo "Print My Name : ${names[0]}" #prints first index
echo "Print My Wife Name : ${names[1]}" #prints second index
echo "Print Kids Names : ${names[*]:2:3}" #prints range of indexes
echo "Print all Names: ${names[@]}" #Prints all the indexes


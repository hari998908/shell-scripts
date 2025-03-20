#!/bin/bash

names=("Hari" "Mamatha" "Chetahan" "Nivedha")

echo "Print First Name : ${names[0]}" #prints first index
echo "Print Second Name : ${names[1]}" #prints second index
echo "Print Kids Names : ${names[*]2:3}" #prints range of indexes
echo "Print all Name ${names[@]}" #Prints all the indexes

${arr[*]:2}

#!/bin/bash

echo "All varialble:$@"
echo "Number of variables passed: $#"
echo "Script Name: $0"
echo "Current working Directory: $PWD"
echo "Home Directory for current Usres: $Home"
echo "Which user is running this script : $Users"
echo "Process ID of the current shell script : $$"
sleep 60 &  #Back ground Command
echo "Process ID of last back ground command : $!"




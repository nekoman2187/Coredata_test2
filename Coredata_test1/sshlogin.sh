#!/bin/sh
expect -c "
set timeout 30
spawn ssh  -l nekoman 192.168.11.2
expect \"Password:\"
send \"m582187\n\"
expect \"%\"
send \"ls\n\"
interact
"
 

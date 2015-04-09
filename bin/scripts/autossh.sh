#!/usr/bin/expect -f
set password xxxxxxxxx
spawn ssh root@www.bukuta.com
set timeout 800
expect "root@www.bukuta.com's password:"
set timeout 300
send "$password\r"
interact

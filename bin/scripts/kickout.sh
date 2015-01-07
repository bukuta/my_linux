#!/bin/sh
CUR=`tty`
echo ${CUR:5}
ALL=`who -u`
echo $ALL
for u in $(who -u)
do
  echo $u
done


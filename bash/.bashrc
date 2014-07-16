#! /bin/bash
#echo "#########"
wherentpdate=`whereis ntpdate` 
#echo "#########"
#echo $wherentpdate
#echo ${wherentpdate##*:}
if [ ! "${wherentpdate##*:}" ]
then
  echo "yum install ntpdate"
  yum install ntpdate
  #echo "installed"
fi
ntpdate asia.pool.ntp.org

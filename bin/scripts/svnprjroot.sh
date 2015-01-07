#! /bin/sh
_cur=`pwd`
echo $_cur
function has_svn(){
  echo $1
  cur=$1
  echo `dirname $cur`
  if [ -d "$cur" ];
  then
    echo "-d"
    svnpath="$cur/.svn"
    echo $svnpath
    if [ -d "$svnpath" ];
    then
      echo "has .svn $svnpath"
      svninfo=`svn info --xml`
      echo "---------------"
      echo $svninfo
      echo "---------------"
      url=$(sub_str_from_xml "$svninfo" "url")
      echo url
      echo "---------------"
    fi
  else
    echo "no -d"
  fi
}
function sub_str_from_xml(){
  #echo "************************"
  _str="$1";
  _tag="<$2>"
  _tag_end="</$2>"
  #echo $1
  #echo $_tag;
  rr=${_str#*$_tag}
  rt=${rr%$_tag_end*}
  echo "$rt";
  return 0
  awkscript="{start=index($0,"$_tag")+length("$_tag");end=index(\$0,"$_tag_end");print substr($0,start,end-start)}"
  echo $awkscript
  echo "-----------------------------"
  rr=`echo $1|awk '"${awkscript}"' `
  echo $rr
  echo "-----------------------------"
  echo "************************"
   
}
has_svn $_cur

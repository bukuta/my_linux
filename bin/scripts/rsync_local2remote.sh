#! /bin/sh

rsync -rltouIzvc --exclude=".svn" --exclude="*.swp" ~/devspace/web/ user@server:~/php
rsync -rltouIzvc --exclude=".svn" --exclude="*.swp" ~/devspace/javascript/ user@server:~/js
exit 0;
function get_project_root(){
  #从当前目录开始向上,查找当前目录下的.svn,直到没有.
  echo $@,$#;
  _current=`pwd`
}
_current=`pwd`
echo $_current;
r=get_project_root "$_current"
echo $r;

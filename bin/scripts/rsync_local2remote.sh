#! /bin/sh

rsync -rltouIzvc --exclude=".svn" --exclude="*.swp" ~/devspace/web/ yuanbo7@10.1.169.16:~/wdds/trunk/php/ffan/web/
rsync -rltouIzvc --exclude=".svn" --exclude="*.swp" ~/devspace/javascript/ yuanbo7@10.1.169.16:~/wdds/trunk/javascript/
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

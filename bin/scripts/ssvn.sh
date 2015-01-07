#! /bin/sh
function remotecommand(){
  echo "-----------------------------"
  echo $@;
  ssh yuanbo7@10.1.169.16 "$@"
  echo "-----------------------------"
}

#remotecommand "cd ~/wdds/trunk/php/ffan/web; svn up"
function ssvn(){
  echo "================"
  echo $@
  _command=" svn $@"
  _command="cd ~/wdds/trunk/php/ffan/web; $_command"
  echo $_command
  remotecommand "$_command"
  echo "================"
}

ssvn $@

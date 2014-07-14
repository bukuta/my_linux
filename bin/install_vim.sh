if [ -e ~/.vim/bundle/vundle ]
then
  if [ -d ~/.vim/bundle/vundle ]
  then
    echo 'vundle.git '
  fi
else
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  if [ ! -d ~/git.base/my_linux ]
  then
    git clone https://github.com/bukuta/my_linux.git ~/git.base/my_linux
  fi
  mv ~/.vimrc ~/.bak/.vimrc
  cp ~/git.base/my_linux/vim/.vimrc ~/.vimrc
  vim +VundleInstall
  #检测别名是否存在
  sed 's/\(g:NERDTreeDirArrows.*\)\(s:running_windows\)/\1!\2/' ~/.vim/bundle/The-NERD-tree/plugin/NERD_tree.vim >tmp
  mv -f tmp ~/.vim/bundle/The-NERD-tree/plugin/NERD_tree.vim

  echo "alias vj='vim +NERDTree'" >>~/.bashrc
  source .bashrc
fi

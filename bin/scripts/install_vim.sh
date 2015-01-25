vundle_installed=0
if [ -d ~/.vim/bundle/vundle ]
then
  vundle_installed=1 
  echo 'vundle.installed '
else
  echo 'vundle.uninstalled'
fi

echo $vundle_installed;

if [ $vundle_installed  -eq 0 ]
then
  echo "git clone vundle"
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
else
  echo "skip git clone vundle"
fi

if [ -d ~/.bak ]
then
  echo "~/.bak exists"
else
  echo "~/.bak unexists"
  mkdir ~/.bak
fi

if [ -r ~/.vimrc ]
then
	echo "mv ~/.vimrc ~/.bak/.vimrc"
	mv ~/.vimrc ~/.bak/.vimrc
fi
echo "cp ../vim/.vimrc ~/.vimrc"
cp ./vim/.vimrc ~/.vimrc

vim +VundleInstall
#检测别名是否存在
sed 's/\(g:NERDTreeDirArrows.*\)\(s:running_windows\)/\1!\2/' ~/.vim/bundle/The-NERD-tree/plugin/NERD_tree.vim >tmp
mv -f tmp ~/.vim/bundle/The-NERD-tree/plugin/NERD_tree.vim

echo "alias vj='vim +NERDTree'" >>~/.bashrc
source ~/.bashrc

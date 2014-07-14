if[ ! -d ~/.vim/bundle/vundle ]
then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
if[ ! -d ~/git.base/my_linux ]
then
  git clone https://github.com/bukuta/my_linux.git ~/git.base/my_linux
fi
cp ~/git.base/my_linux/vim/.vimrc ~/.vimrc
vim +VundleInstall


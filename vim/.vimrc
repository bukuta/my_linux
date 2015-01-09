set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set nu
set autoindent
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
set foldmethod=syntax
set foldmethod=indent

setlocal foldlevel=1
setlocal foldlevel=1
syntax on
let b:javascript_fold=1
let javascript_enable_domhtmlcss=1

"set nocompatible               " be iMproved
filetype on                   " required!
filetype indent on
filetype plugin indent on     " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'L9'
Bundle 'The-NERD-tree'
Bundle 'FuzzyFinder'
Bundle 'auto_mkdir'
Bundle 'jsbeautify'
Bundle 'The-NERD-Commenter'
Bundle 'taglist.vim'
Bundle 'taglist-plus'
Bundle 'sessionman.vim'
Bundle 'bufexplorer.zip'
Bundle 'leshill/vim-json'

Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
"Bundle 'drmingdrmer/xptemplate'
Bundle 'msanders/snipmate.vim'
Bundle 'mattn/emmet-vim'

filetype plugin indent on     " required!
"
" Brief help  -- 此处后面都是vundle的使用命令
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"set cindent
"set tabstop=2
"set autoindent
"set nu

let NERDTreeShowBookmarks=1

let mapleader='\'
"map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
map <leader>be :BufExplorer<CR>
map <F2> :Flisttoggle<CR>
nmap <F8> :TagbarToggle<CR>
map <leader>sf :NERDTreeFind<CR>
map <F8> :!mrsync<CR>
map <leader>sw :cw<cr>
map <leader>sn :cn<cr>
map <leader>sp :cp<cr>
map <leader>ff :call VGrep()<cr>
function VGrep()
  let word=expand("<cword>")
  echom word
  :execute 'vimgrep /'.word.'/ **/*'
  :cw
endfunction
function ToggleQuickfix()
  
endfunction

function GetFiletype()
  let type = &filetype
  echom "filetype:".type
  return type
endfunction




function GetWord()
  let word = expand('<cword>')
  call GetFiletype()
  "取得文件类型，不同的语言取得的变量不同
  "php:$abcde
  "php:$abcde["aaa"]
  "php:$abc->abc
  "php:$abd[$abc]
  "js:abc
  "js:abc.aaa
  "js:abc["abc"]
  "js:abc[d]
  "js:abc[a()]
  "js:abc[a()[1]]
  "
  return word
endfunction

function GenDebug()
  let word = GetWord()
  "取得文件类型
  "更新文件类型生成不同的调试信息
  let filetype=GetFiletype()
  echom "filetype:".filetype
  if filetype == "php"
    let debugstr = "var_dump($".word.",__LINE__,__FILE__);"
  elseif filetype == "javascript"
    let debugstr = "console.log(".word.");"
  endif 
  return debugstr
endfunction

function InsertStrNextLine(debuginfo)
  "getpos() 暂存待恢复
  let oldpos = getpos(".")
  "getline 取得当前行
  "改用line('.') getline是从缓冲区中取一行
  let curline = line(".")
  let newline = curline + 1
  "echom "curline:".curline
  "echom "newline:".newline
  "normal! o,插入下一空行normal模式下o插入下一行，并进入编辑模式
  normal! o
  "a:debuginfo表明 debuginfo是参数传递进来的
  execute setline(newline,a:debuginfo)
  "TODO 按原文件类型格式化新插入的行
  
  execute "normal ".newline."=="
  "返回原行 setpos()
  call setpos('.',oldpos)
endfunction

function InsertDebugInfoAtNextLine()
  let debuginfo = GenDebug()
  echom debuginfo
  call InsertStrNextLine(debuginfo)
endfunction

"nmap <F10> :call GetWord()<CR>
nmap \db :call InsertDebugInfoAtNextLine()<CR>

au BufRead,BufNewFile *.tpl set filetype=html

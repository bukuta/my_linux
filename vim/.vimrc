set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set nu
set autoindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=syntax
set foldmethod=indent
colorscheme github

set diffopt+=iwhite
set showmatch
set ignorecase

setlocal foldlevel=1
syntax on
let b:javascript_fold=1
let javascript_enable_domhtmlcss=1

set nocompatible               " be iMproved
filetype on                   " required!
filetype indent on
filetype plugin indent on     " required!

auto BufReadPost *.js|*.php|*.css|*.html retab! 4
auto BufNewFile *.js|*.php|*.css|*.html retab! 4
auto BufWritePre *.js|*.php|*.css|*.html retab! 4
auto BufWritePost *.js|*.php|*.css|*.html retab! 4



highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>80v.\+/



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
"Bundle 'FuzzyFinder'
Bundle 'auto_mkdir'
Bundle 'jsbeautify'
Bundle 'The-NERD-Commenter'
"Bundle 'taglist.vim'
"Bundle 'taglist-plus'
Bundle 'sessionman.vim'
Bundle 'bufexplorer.zip'
Bundle 'leshill/vim-json'
Bundle 'vim-scripts/cscope.vim'
Bundle 'walm/jshint.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
"Bundle 'drmingdrmer/xptemplate'
"Bundle 'msanders/snipmate.vim'
"Bundle 'mattn/emmet-vim'
"Bundle 'terryma/vim-multiple-cursors'
"Bundle 'majutsushi/tagbar'
"Bundle 'Shougo/vimshell.vim'
"Bundle 'Shougo/vimproc.vim'
"Bundle 'vim-scripts/mru.vim'
"Bundle 'SirVer/ultisnips'
"Bundle 'honza/vim-snippets'
"Bundle 'msanders/snipmate.vim'
"Bundle 'mattn/emmet-vim'
Bundle 'terryma/vim-expand-region'
"Bundle 'vim-scripts/closetag.vim'
Bundle 'othree/html5.vim'
"let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
"Bundle 'alvan/vim-closetag'

Bundle 'bling/vim-airline'
"Bundle 'powerline/powerline'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/vimshell.vim'
"Bundle 'terryma/vim-multiple-cursors'

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
"nunmap <leader>ff

map <leader>ff :call VGrep()<cr>
function VGrep()
    let word=expand("<cword>")
    echom word
    :execute 'vimgrep /'.word.'/ **/*'
    :cw
endfunction

function ToggleQuickfix()
    let s:buffers=buffers()
    let s:errors=getqflist() "quickfix是否为空
    "检查是否有
    for s:b in s:buffers
        "检查是否有quickfix窗口
    endfor
endfunction

function GetFiletype()
    let type = &filetype
    "echom "filetype:".type
    return type
endfunction




function GetWord()
    let word = expand('<cword>')
    "call GetFiletype()
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
    let s:debugstr=""
    if filetype == "php"
        let s:debugstr = "var_dump($".word.",__LINE__,__FILE__);"
    elseif filetype == "javascript"
        let s:debugstr = "console.log(".word.");"
    endif 
    return s:debugstr
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
function ReCtags()
    "从当前目录向上找,直到tags文件所在目录,如果找到
    let s:currentfiledir=expand("%:p:h") 
    let s:cwd=getcwd()
    echom 'current:'.s:currentfiledir
    let s:tagpath=findfile("tags",";~",1)
    echom "find:".s:tagpath
    let s:cmd=""
    if strlen(s:tagpath)!=0
        let s:prjroot=fnamemodify(s:tagpath,":h")
        let s:cmd="ctags -R -f ".s:tagpath." ".s:prjroot
    else
        let s:prjroot= s:cwd
        let s:cmd="ctags -R ".s:prjroot
    endif
    echom s:cmd
    execute "!".s:cmd
endfunction
map <F9> :call ReCtags()<CR>



"findfile
function s:FindFilesWithInProject(filename)
    "let s:filename=expand('<cfile>');
    echom "findfile(\"".a:filename."\",\"".getcwd()."/**/*\")"
    let s:files=findfile(a:filename,getcwd().'/**/*;')
    let s:rs=[]
    if type(s:files) == type("")
        call add(s:rs,s:files)
    elseif type(s:files) == type([])
        let s:rs=s:files
    endif
    return s:rs
endfunction

function FindCurrentFileEditingWithInProject()
    let s:filename=expand('%:t')
    "let s:filename=expand('<cfile>')  "当前编辑的文件,在哪些文件中有引用
    echom "find:".s:filename
    if strlen(s:filename)==0
        return
    endif
    "let s:fileslist=s:FindFilesWithInProject(s:filename)
    let s:cmd="vimgrep ".s:filename." **/*"
    echom 's:cmd:'.s:cmd
    execute "vimgrep ".s:filename." **/*"
endfunction
function FindFileUnderCursorWithInProject()
    let s:filename=expand('<cfile>')  "当前编辑的文件,在哪些文件中有引用
    echom "find:".s:filename
    if strlen(s:filename)==0
        return
    endif
    let s:fileslist=s:FindFilesWithInProject(s:filename)
    "execute "vimgrep ".s:filename." **/*"
    echom "found:".join(s:fileslist,',')
    if len(s:fileslist)==1
        "直接打开
        execute ":sp ".fnamemodify(s:fileslist[0],':p')
    elseif len(s:fileslist)>1
        echom "found:".join(s:fileslist,',')
        echom "show filelist in quickfix window"
    endif
endfunction
function FindWordWithInProject()
    let s:word=expand('<cword>')
    echom "findword:".s:word
    execute "vimgrep ".s:word." **/*"
endfunction

map <leader>sd : call FindCurrentFileEditingWithInProject()<CR>
map <leader>ss : call FindFileUnderCursorWithInProject()<CR>
map <leader>sw :call FindWordWithInProject()<CR>
map <F7> : call PrettyCode()<cr><cr>

function! s:is_js()
    return expand('%:e') == 'js'
endfunction
function! s:is_css()
    return expand('%:e') == 'css'
endfunction

function PrettyCode()
    let s:oldpos = getpos(".")
    let s:filepath=expand('%:p')
    if s:is_js()
        let s:cmd="uglifyjs ".s:filepath." -b --comments all"
    elseif s:is_css()
        let s:cmd="prettycss ".s:filepath." -b --comments all"
    endif

    if exists('s:cmd')
        echom s:cmd
        let @0=system(s:cmd)

        :g/.*/d
        :put! 0
    endif
    call setpos('.',s:oldpos)
endfunction

set laststatus=2
set t_Co=256
let g:Powerline_symbols="unicode"
"setfillchars+=stl:\,stln:\


function SaveSession()
    "let oldsessionoptions=&sessionoptions
    "sessionoptions=""
    "&sessionoptions="blank,buffers,sesdir,folds,help,options,tabpages,winsize"
    execute ":NERDTreeClose"
    execute "mksession! ./.session"
    execute "wviminfo! ./.viminfo"
    return
    redir => s:buffers
    buffers!
    redir END
    " save buffer list to .prjide section[buffers]
    let s:blist=[]
    for buf in split(s:buffers,'\n')
        let s:ps=split(buf,'"')
        echom s:ps[-1]
        let s:b={'attributes':s:ps[0],'line': substitute(s:ps[-1], '\s*', '', '')}
        s:b.line=substitue(s:b.line,'\d','','');
        let name =  bufname(str2nr(s:b.attributes))
        if stridx(name,'NERD_tree')!=-1
            continue
        endif
        let fullname = fnamemodify(name ,':p')
        let s:b['fullname']=fullname
        call add(s:blist,s:b)
        echom name.' '.fullname.'\t'.s:b.line
    endfor
    "echom s:buffers
    "echom join(s:buffers,'\n')
endfunction
function RestoreSession()
    " read buffer list from .prjide section [buffers]
    " open them if exists
    if filereadable(fnamemodify("./.session",':p'))
        execute "source ".fnamemodify("./.session",":p")
    endif
    if filereadable(fnamemodify("./.viminfo",':p'))
        execute "rviminfo! ".fnamemodify("./.viminfo",':p')
    endif

endfunction
map \tt: call SaveSession()<CR>
"autocmd VimLeavePre * call SaveSession()
"autocmd VimEnter * call RestoreSession()
function EnLargeSection()
    echom '<ctrl+.>'
endfunction
function EnSmallSection()
    echom '<ctrl+,>'
endfunction
noremap > *: call EnLargeSection()<CR>
noremap < *: call EnSmallSection()<CR>

map <c-o> :!pwd<cr>

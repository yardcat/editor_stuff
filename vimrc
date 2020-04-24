set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1

set nocompatible
set magic							            " 设置 regulation express
set cindent
set cinoptions=l1
set cinoptions+=:0
set tabstop=2
set expandtab
set showmatch                    "插入括号时，短暂地跳转到匹配的对应括号
set autoindent                    "自动对齐
set smartindent                   "智能对齐
set matchtime=2
set shiftwidth=2
set softtabstop=2

set incsearch
set noswapfile
set ignorecase

set scrolloff=3							      " 光标移动到buffer的顶部和底部时保持3行距离
set laststatus=2						      " 启动显示状态行(1),总是显示状态行(2)
set history=200 						      " 历史记录数量
set selection=inclusive           "
set backspace=indent,eol,start
set number
set cursorline
set ruler
set hlsearch
set ignorecase                    " 搜索时忽略大小写

syntax on
set pumheight=20
"set completeopt=menu,menuone
set complete=.,w,b

"------------------  color scheme --------------------------
colorscheme molokai
set t_Co=256
let g:molokai_original=1
let g:rehash256=1

autocmd FileType c,cpp set shiftwidth=2 | set expandtab

nnoremap <F1> <ESC>o<ESC>:call FunctionLog()<CR>==f$
nnoremap <F2> <ESC>o<ESC>:call FunctionLog_without_this()<CR>==f$
nnoremap <F7> <ESC>o<ESC>:call PrintBT()<CR>==
nnoremap <F8> <ESC>:vs<CR>r !make && ./test<CR>==
nnoremap ; :
map <c-p> <ESC>:reg<CR>
map <c-h> <ESC>:tabp<CR>
map <c-l> <ESC>:tabn<CR>
map <F9> <ESC>:q<CR>:q<CR>
map <F3> <ESC>:tabnew .<cr>
map <F4> <ESC><c-w>w
map <F6> <ESC>:call FunctionLogRect()<cr>
"map <F5> <ESC>:w<cr>:sp 61liuyao<cr><c-w>w<cr>r! ./<cr><c-w>w
map <F5> <ESC>:tabnew %<cr>:tabp<cr>:q<cr>:tabn<cr>
nmap <c-\> :call OpenCC()<CR>
nmap <c-]> :call SwitchCC()<CR>
nmap f <ESC>ggvG=<c-o><c-o><CR>
nmap <c-j> :!code %<cr><cr>

nnoremap <leader>w <c-w>w
nnoremap <Leader>ch :A<CR>
nnoremap <leader>ff @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

let g:tagbar_autoclose = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore = ['\.d','\.pyc','\.vcxproj*','\.sln','\.o']
noremap <Leader>t <ESC>:TagbarToggle<cr>


""""""""""""""""""""""""""""""""""Vundle"""""""""""""""""""""""""""""""""""""""""""""""
"设置包括vundle和初始化相关的运行时路径"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"启用vundle管理插件，必须"
Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'

"在此增加其他插件，安装的插件需要放在vundle#begin和vundle#end之间"
"安装github上的插件格式为 Plugin '用户名/插件仓库名'"

call vundle#end()
filetype plugin indent on      "加载vim自带和插件相应的语法和文件类型相关脚本，必须"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""Bundle settings""""""""""""""""""""""""""
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

"Bundle 'EasyMotion'
"Bundle 'synmark.vim'
"Bundle 'gmarik/vundle'
"Bundle 'majutsushi/tagbar'
"Bundle 'The-NERD-Commenter'
"Bundle 'Valloric/ListToggle'
"Bundle 'scrooloose/nerdtree'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'octol/vim-cpp-enhanced-highlight'

call pathogen#infect()
filetype plugin indent on
""""""""""""""""""""""""""""""""" Bundle END""""""""""""""""""""""""""

let g:cpp_class_scope_highlight = 1

"""""""""""""""""""""" configure for youcompleteme """"""""""""""""""""""""""""""
"let g:ycm_confirm_extra_conf=0
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_complete_in_strings = 1
"let g:ycm_use_ultisnips_completer = 1
""let g:ycm_seed_identifiers_with_syntax = 0
""let g:ycm_min_num_of_chars_for_completion = 4
"let g:ycm_collect_identifiers_from_tags_files=0
""let g:ycm_min_num_identifier_candidate_chars = 3
"let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_project_config.py'
"nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

function SwitchCC()
  let h=expand('%')
  let cc="can't switch"
  if h[strlen(h)-1] == "h"
    let cc = substitute(h,"h$","cc","")
    if filewritable(cc) == 0
      let cc = substitute(h,"h$","cpp","")
      if filewritable(cc) == 0
        let cc = substitute(h,"h$","cxx","")
        if filewritable(cc) == 0
          let cc = substitute(h,"h$","c","")
          if stridx(cc, "Public") != -1
            let cc = substitute(h,"Public","Private","")
            let cc = substitute(cc,"h$","cpp","")
          endif
        endif
      endif
    endif
  else
    let cc = substitute(h,"\.[cp]*$",".h","")
  endif
  execute "e ".cc
endfunction


function OpenCC()
  let h=expand('%')
  if h[strlen(h)-1] == "h"
    let cc = substitute(h,"h$","cc","")
    if filewritable(cc) == 0
      let cc = substitute(h,"h$","cpp","")
      if filewritable(cc) == 0
        let cc = substitute(h,"h$","cxx","")
        if filewritable(cc) == 0
          let cc = substitute(h,"h$","c","")
          if stridx(cc, "Public") != -1
            let cc = substitute(h,"Public","Private","")
            let cc = substitute(cc,"h$","cpp","")
          endif
        endif
      endif
    endif
    execute "vs ".cc
  endif
endfunction

function PrintBT()
  call setline(line("."), '#include "base/debug/stack_trace.h"$base::debug::StackTrace().Print();')
endfunction

function FunctionLog()
  call setline(line("."), 'printf("\n\x1b[47;34m >>>>> %s |%s|%s|%d pid=%d\x1b[0m\n",$, __FILE__,__FUNCTION__, __LINE__,getpid());fflush(stdout);')
endfunction

function FunctionLogRect()
  call setline(line("."), 'printf("\n\x1b[47;34m >>>>> r1: %d %d %d %d |%s|%s|%d pid=%d\x1b[0m\n",r1.x(), r1.y(), r1.width(), r1.height(), __FILE__,__FUNCTION__, __LINE__,getpid());fflush(stdout);')
endfunction


function FunctionLog_without_this()
  call setline(line("."), '{struct timeval tv;gettimeofday(&tv,NULL);printf("\n\x1b[47;34m >>>>> %s |%2ld:%ld |%s|%s|%d pid=%d \x1b[0m",$,tv.tv_sec,tv.tv_usec/1000, __FILE__,__FUNCTION__, __LINE__,getpid());fflush(stdout);}')
endfunction

"highlight WhitespaceEOL ctermbg=red guibg=red
"match WhitespaceEOL /\s\+$/

function RemoveTrailingWhitespace()
 if &ft != "diff"
  let b:curcol = col(".")
  let b:curline = line(".")
  silent! %s/\s\+$//
  call cursor(b:curline, b:curcol)
 endif
endfunction

autocmd BufWritePre * call RemoveTrailingWhitespace()

autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

nmap <C-[>a :cs add cscope.out ./<cr>
nmap <C-[>s <ESC>:vert scs find s <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>g <ESC>:vert scs find g <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>c <ESC>:vert scs find c <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>f <ESC>:vert scs find f <C-R>=expand("<cfile>")<cr><cr>
"nmap <C-[>t <ESC>:vert scs find t <C-R>=expand("<cword>")<cr><cr>
"nmap <C-[>e <ESC>:vert scs find e <C-R>=expand("<cword>")<cr><cr>
"nmap <C-[>i <ESC>:vert scs find i <C-R>=expand("<cfile>")<cr><cr>
"nmap <C-[>d <ESC>:vert scs find d <C-R>=expand("<cword>")<cr><cr>


nmap ,s <ESC>:tabnew sraf/source/core<CR>
nmap ,b <ESC>:tabnew third_party/blink/renderer/core<CR>
nmap ,v <ESC>:tabnew components/viz/service<CR>

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:move_key_modifier = 'm'

"------------------------------------------ clang format ----------------------------------------------
map <C-K> :pyf /home/SERAPHIC/liuy/sraf_73/v5.0/src/buildtools/clang_format/script/clang-format.py<cr>
imap <C-K> <c-o>:pyf /home/SERAPHIC/liuy/sraf_73/v5.0/src/buildtools/clang_format/script/clang-format.py<cr>


set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,latin1

set magic
set cindent
set cinoptions=l1
set cinoptions+=:0
set tabstop=2
set expandtab
set showmatch
set autoindent
set smartindent
set matchtime=2
set shiftwidth=2
set softtabstop=2
set incsearch
set noswapfile
set scrolloff=3
set laststatus=2
set history=1000
set selection=inclusive
set backspace=indent,eol,start
set number
set cursorline
set ruler
set hlsearch
set ignorecase
set pumheight=20
set complete=.,w,b
"set completeopt=menu,menuone
"set autochdir                    " for nerdtree and terminal.

syntax on
syntax enable
filetype plugin on
filetype indent on

"-------------------- scheme ----------------
colorscheme molokai
set t_Co=256
let g:molokai_original=1
let g:rehash256=1

"---------------- key mapping -----------
let mapleader=","
nnoremap <F1> <ESC>o<ESC>:call FunctionLog()<CR>==f$
nnoremap <F2> <ESC>o<ESC>:call FunctionLog_without_this()<CR>==f$
nnoremap <F7> <ESC>o<ESC>:call PrintBT()<CR>==
nnoremap ; :
map <BS> :tabp<CR>
map <c-l> <ESC>:tabn<CR>
map <c-h> <ESC>:
map <F9> <ESC>:q<CR>:q<CR>
map <F3> <ESC>:tabnew .<cr>
map <F4> <ESC><c-w>w
map <F6> <ESC>:call FunctionLogRect()<cr>
map <F5> <ESC>:tabnew %<cr>:tabp<cr>:q<cr>:tabn<cr>
nmap <c-p> :Files<CR>
nmap <c-\> :call OpenCC()<CR>
nmap <c-]> :call SwitchCC()<CR>
nmap <c-n> <ESC>:py vim.api.command("tabnew " + os.path.dirname(vim.current.buffer.name))<CR>
nmap ,s <ESC>:tabnew sraf/source/core<CR>
nmap ,b <ESC>:tabnew third_party/blink/renderer/core<CR>
nmap ,v <ESC>:tabnew components/viz/service<CR>

"----------key map for cscope--------
nmap <C-[>a :cs add cscope.out ./<cr>
nmap <C-[>s <ESC>:vert scs find s <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>g <ESC>:vert scs find g <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>c <ESC>:vert scs find c <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>f <ESC>:vert scs find f <C-R>=expand("<cfile>")<cr><cr>

"----------key map for termial------
nmap ,t <ESC>:py vim.api.command("cd " + os.path.dirname(vim.current.buffer.name))<CR>:tabnew<CR>:terminal<CR>:cd -<CR>
tnoremap <Esc> <C-\><C-n>

"-------- clang format -----------
map <C-K> :pyf /home/SERAPHIC/liuy/sraf_73/v5.0/src/buildtools/clang_format/script/clang-format.py<cr>
imap <C-K> <c-o>:pyf /home/SERAPHIC/liuy/sraf_73/v5.0/src/buildtools/clang_format/script/clang-format.py<cr>

"-------------------vim plugin -----------------
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'valloric/youcompleteme'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
"Plug 'zchee/deoplete-clang'
call plug#end()

"----------------- nerd tree------------
let g:tagbar_autoclose = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore = ['\.d','\.pyc','\.vcxproj*','\.sln','\.o']

"----------------- fzf ----------------
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_action = { 'enter': 'tab split'}

"---------------- ack ----------------
let g:ackprg = 'ag --nogroup --nocolor --column'
map <Leader>a :Ack<Space>

"-------------- rainbow bracket---------
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"-------------- cpp-enhanced-hightlight---------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 0
let g:cpp_posix_standard = 1

"-------------- you-complete-me ----------------
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_extra_conf_globlist=['/home/SERAPHIC/liuy/sraf_73/v5.0/.ycm_extra_conf.py']

"------------- utilsnips -------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"--------------- deoplete -----------------
let g:deoplete#enable_at_startup = 1

"---------------switch-------------------
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

"------------------ log ------------------
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

"----------- python -------------
py import vim
py import os
py import sys

"------------ auto comand ------------
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


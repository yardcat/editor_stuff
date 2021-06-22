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
"searching
set hlsearch
set ignorecase
set smartcase
set pumheight=20
set complete=.,w,b
set autoread                      " reload files changed outside vim
"set autochdir                    " for nerdtree and terminal.

syntax on
syntax enable
filetype on
filetype plugin on
filetype indent on

"for mojom, path mean chromium project path
set runtimepath+=/chromium_path/src/tools/vim/mojom

"---------------- project -----------
"set working dirctory to src
function! GoRoot()
py3 << EOF
pwd = os.path.split(vim.eval("getcwd()"))
if pwd[-1] != "src":
  pos = pwd[0].find("src")
  if pos != -1:
    vim.chdir(pwd[0][0:pos+3])
EOF
endfunction

"open file in new tab from terminal searach result
function! OpenLineFile()
py3 << EOF
curr_line = vim.current.line.split(':')
if len(curr_line) > 2:
  ln = -1
  while len(vim.current.buffer[ln]) == 0:
    ln-=1
  match_obj = re.search(".+:(.*)\$", vim.current.buffer[ln])
  if match_obj != None:
    fname = match_obj.group(1) + "/" +curr_line[0]
    fnum = curr_line[1]
    vim.command("tabnew "+fname)
    vim.command(str(fnum))
EOF
endfunction


"---------------- key mapping -----------
let mapleader=","
nnoremap <F1> <ESC>o<ESC>:call FunctionLog()<CR>==f$
nnoremap <F2> <ESC>o<ESC>:call FunctionLog_without_this()<CR>==f$
nnoremap <F7> <ESC>o<ESC>:call PrintBT()<CR>==
nnoremap ; :
map <BS> :tabp<CR>
map <c-l> <ESC>:tabn<CR>
map <c-h> <ESC>:tabp<CR>
map <F9> <ESC>:q<CR>:q<CR>
map <F3> <ESC>:call GoRoot()<CR>:tabnew .<cr>
map <F4> <ESC><c-w>w
map <F5> <ESC>:tabnew %<cr>:tabp<cr>:q<cr>:tabn<cr>
map <F6> <ESC>:py3 cl=vim.current.window.row;
nmap <c-q> :Files<CR>
nmap <c-p> :call fzf#run(fzf#wrap({'source': 'cat fzf.cache'}))<cr>
nmap <c-]> :call SwitchCC()<CR>
nmap <c-n> <ESC>:py3 vim.api.command("tabnew " + os.path.dirname(vim.current.buffer.name))<CR>
nmap ,b <ESC>:tabnew third_party/blink/renderer/core<CR>
nmap ,n <ESC><c-w>gF<cr>
nmap ,r <ESC>:call GoRoot()<cr>
nmap ,f <ESC>:call OpenLineFile()<cr>

"----------key map for cscope--------
nmap <C-[>a :cs add cscope.out ./<cr>
nmap <C-[>s <ESC>:vert scs find s <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>g <ESC>:vert scs find g <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>c <ESC>:vert scs find c <C-R>=expand("<cword>")<cr><cr>
nmap <C-[>f <ESC>:vert scs find f <C-R>=expand("<cfile>")<cr><cr>

"----------key map for termial------
nmap ,t <ESC>:py3 vim.api.command("cd " + os.path.dirname(vim.current.buffer.name))<CR>:tabnew<CR>:terminal<CR>:cd -<CR>
nmap ,s <ESC>:py3 vim.api.command("cd " + os.path.dirname(vim.current.buffer.name))<CR>:vs<CR><c-w>w:terminal<CR>:cd -<CR>
tnoremap <Esc> <C-\><C-n>

"-------- clang format -----------
map <C-K> :py3f /chromium_path/src/buildtools/clang_format/script/clang-format.py<cr>
imap <C-K> <c-o>:py3f /chromium_path/src/buildtools/clang_format/script/clang-format.py<cr>
function Formatonsave()
  let l:lines="all"
  pyf /chromium_path/src/buildtools/clang_format/script/clang-format.py
endfunction
nmap ,k :call Formatonsave()<cr>
"autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

"------ key map for a switch -----
nnoremap <c-]> :A<CR>
nnoremap <c-\> :AV<CR>

"-------------------vim plugin -----------------
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'valloric/youcompleteme'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'vim-scripts/a.vim'
"Plug 'bbchung/Clamp'
Plug 'mhinz/vim-startify'
Plug 'myusuf3/numbers.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-peekaboo'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
Plug 'wellle/targets.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'voldikss/vim-floaterm' "浮动终端
"Plug 'xuyuanp/scrollbar.nvim'

"color schemes
Plug 'yartdcat/my_vim_color_scheme'
Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
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
let g:fzf_layout = { 'down': '~30%' }

"---------------- ack ----------------
let g:ackprg = 'ag --nogroup --nocolor --column'
map <Leader>a :Ack<Space>

"---------------- peekaboo ----------------
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:peekaboo_window = 'call CreateCenteredFloatingWindow()'


"-------------- rainbow bracket---------
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [233, 234, 225]
augroup rainbow_lisp
  autocmd!
  autocmd FileType c,cpp,cc,h,hpp RainbowParentheses
augroup END

"-------------- cpp-enhanced-hightlight---------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 0
let g:cpp_posix_standard = 1

"-------------- you-complete-me ----------------
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_extra_conf_globlist=['/chromium_path/src/.ycm_extra_conf.py']

"------------- utilsnips -------------------
let g:UltiSnipsExpandTrigger="<tab>"

"--------------- deoplete -----------------
let g:deoplete#enable_at_startup = 0

"----------- deoplete clang ---------------
let g:deoplete#sources#clang#libclang_path = "/llvm_path/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/llvm_path/llvm/10.0.0_7/lib/clang"

"------------ coc ----------------


"----------- a switch ------------------

"----------- Clamp ---------------
let g:clamp_autostart = 1
let g:clamp_libclang_file = '/llvm_path/10.0.0_7/lib/libclang.so'
let g:clamp_highlight_mode = 1

"--------- easy motion ------------
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
hi EasyMotionTarget ctermfg=9 guifg=red
hi EasyMotionTarget2First ctermfg=9 guifg=red
hi EasyMotionTarget2Second ctermfg=9 guifg=lightred
hi link EasyMotionShade Comment
nmap <Leader>d <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)

"--------- airline --------------
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_tab_count = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"----------------- startify ----------------
command! -nargs=1 CD cd <args> | Startify
autocmd User Startified setlocal cursorline
let g:startify_enable_special         = 1
let g:startify_files_number           = 16
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 0
let g:startify_update_oldfiles        = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 1
highlight StartifyFooter  ctermfg=240

"------------ session ----------------
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"------------ floaterm ----------------
nmap <leader>m <esc>:FloatermToggle<cr>
let g:floaterm_winblend = 0

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

"-------------------- scheme ----------------
colorscheme molokai
set t_Co=256

"------------abreavation----------
iab wiht with
iab whit with
iab ture true
iab flase false
iab wieght weight
iab hieght height
iab tihs this
iab mian main
iab funciton function
iab funcition function

"----------- python -------------
py3 import vim
py3 import os
py3 import sys

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
autocmd InsertLeave * if pumvisible() == 0|pclose|endif         "for close preview window

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

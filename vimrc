let mapleader = " "
syntax on
filetype plugin indent on

""" General
set nocompatible
set backspace=indent,eol,start
set autoread
set hidden
set ttimeoutlen=500
set gdefault
set wildmenu wildmode=list:longest,list:full
set complete=.,w,b,t,kspell
set completeopt=longest,menuone,preview
set dictionary+=/usr/share/dict/words
" set clipboard^=unnamed

""" UI
set formatoptions+=j
set lazyredraw
set linebreak
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:•,trail:•
set nofoldenable
set nojoinspaces
set number
set showcmd showbreak=↪
set splitbelow splitright
set textwidth=80 colorcolumn=+1
set laststatus=2
set scrolloff=8

""" Search
set hlsearch incsearch
set ignorecase smartcase
set showmatch matchtime=2

""" Indention
set autoindent smartindent
set expandtab smarttab
set shiftwidth=2 softtabstop=2 tabstop=2

""" Backups, undo, history
set history=200
set noswapfile
set backup
set undofile

""" Autocommands
" Resize splits after window resize
autocmd VimResized * exe "normal! \<c-w>="

autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorline
autocmd FileType gitcommit setlocal textwidth=72 spell colorcolumn=50
autocmd FileType tmux setlocal nowrap commentstring=#\ %s
autocmd FileType ruby let b:match_words = '\<do\>:\<end\>'
autocmd BufRead,BufNewFile *.md setlocal ft=markdown textwidth=80 spell
autocmd BufRead,BufNewFile *.hamlc setlocal ft=haml
autocmd BufRead,BufNewFile *.jbuilder setlocal ft=ruby

" When editing a file, always jump to the last known cursor position
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --nogroup --nocolor --column'
  set grepprg=ag\ --hidden\ --vimgrep grepformat^=%f:%l:%c:%m
else
  let &grepprg = 'grep -rn $* *'
endif
" command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen
" autocmd! FileType qf nnoremap <buffer> <leader>o <c-w><cr><c-w>L

" " Tab completion
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
" inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <S-Tab> <c-n>

command! Chomp silent! normal! :%s/\s\+$//<cr>                          " :Chomp

let g:html_indent_tags = 'li\|p'   " Treat <li> and <p> tags like the block tags

""" Mappings
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap j gj
nnoremap k gk

" Auto center searching, n - always forward, N - always backward
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <expr> n  'Nn'[v:searchforward].'zvzz'
nnoremap <expr> N  'nN'[v:searchforward].'zvzz'

imap § <esc>
nmap § <esc>
vmap § <esc>
cmap § <esc>
inoremap jk <esc>
nnoremap <leader><leader> :w<cr>
nnoremap <leader>c :cd %:p:h<cr>:pwd<cr>         " cd to the current file's path
nnoremap <leader>e :e!<cr>
nnoremap <leader>f :vsp <cr>:exec("tag ".expand("<cword>"))<cr>  " tag in vsplit
nnoremap <leader>g :Ack<Space>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>i :bnext<cr>
nnoremap <leader>o :bprev<cr>
nnoremap <leader>r :RainbowToggle<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vs ~/.vimrc<cr>/Mappings<cr>3}:nohl<cr>
nnoremap <leader>T :!ctags -R --exclude=.git --exclude=log .<cr>
nnoremap <leader>W :Chomp<cr>

nnoremap K i<cr><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w         " Split lines
nnoremap Y y$                                   " Y acts consistent with C and D
nmap Q @q                                            " qq to record, Q to replay
cnoremap <c-p> <up>
cnoremap <c-n> <down>
set pastetoggle=<F12>

""" Plugins
runtime macros/matchit.vim
call plug#begin('~/.vim/bundle')
Plug 'ajh17/Spacegray.vim'
Plug 'ajh17/VimCompletesMe'
  " let g:vcm_direction = 'p'
Plug 'ctrlpvim/ctrlp.vim'
  nnoremap \ :CtrlP<cr>
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'junegunn/vim-after-object'
  autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', '.')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'othree/javascript-libraries-syntax.vim'
  let g:used_javascript_libs = 'underscore,backbone,jquery,react'
Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 0
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
Plug 'luochen1990/rainbow'
  let g:rainbow_active = 0
  if exists(':RainbowToggleOn') | exe "RainbowToggleOn" | endif
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
  let g:airline_detect_modified=0
  let g:airline_left_sep =''
  let g:airline_right_sep=''
Plug 'tpope/vim-rails'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
  let g:syntastic_ruby_checkers = ['rubocop', 'mri']
  let g:syntastic_javascript_checkers = ['eslint']
  " let g:syntastic_coffescript_checkers = ['coffee']
  " let g:syntastic_haml_checkers = ['haml']
" Plug 'junegunn/vim-easy-align'
"   xmap ga <Plug>(EasyAlign)
"   nmap ga <Plug>(EasyAlign)
" Plug 'tpope/vim-fugitive'
" Plug 'ConradIrwin/vim-bracketed-paste'
" Plug 'keith/rspec.vim'
" Plug 'christoomey/vim-tmux-navigator'
call plug#end()

set t_Co=256
color Spacegray

abbr bpr binding.pry
abbr bananas console.log('bananas')
abbr iser user
abbr Teh the
abbr teh the

let mapleader = " "
syntax on
filetype plugin indent on

""" General
set nocompatible
set hidden
set autoread
set gdefault
set ttimeoutlen=500
set backspace=indent,eol,start
set wildmenu wildmode=list:longest,list:full
set complete=.,w,b,t
set completeopt=menuone,preview
set dictionary+=/usr/share/dict/words

""" UI
set lazyredraw
set linebreak
set nofoldenable
set nojoinspaces
set number
set scrolloff=8
set splitbelow splitright
set formatoptions+=j1
set laststatus=2
set showcmd showbreak=↪
set textwidth=80 colorcolumn=+1
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:•,trail:•

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
set backup backupdir=~/.vim/backup
set undofile undodir=~/.vim/undo
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), "p") | endif
if !isdirectory(expand(&undodir)) | call mkdir(expand(&undodir), "p") | endif

""" Mappings
nmap § <esc>
vnoremap § <esc>
cnoremap § <esc>
inoremap § <esc>
inoremap jk <esc>

cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap w!! w !sudo tee % >/dev/null                           " save with sudo

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap j gj
nnoremap k gk

nnoremap Y y$                                   " Y acts consistent with C and D
nnoremap K i<cr><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w         " split lines
nnoremap <CR> :wa<CR>:!!<CR>
nnoremap <leader><leader> :w<cr>

nnoremap <leader>c :cd %:p:h<cr>:pwd<cr>         " cd to the current file's path
nnoremap <leader>e :e!<cr>
nnoremap <leader>f :vsp <cr>:exec("tag ".expand("<cword>"))<cr>  " tag in vsplit
nnoremap <leader>g :Ack<Space>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>i :bprev<cr>
nnoremap <leader>n :setlocal number!<cr>
nnoremap <leader>o :bnext<cr>
nnoremap <leader>p :set paste!<cr>
nnoremap <leader>r :RainbowToggle<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>/Mappings<cr>5}:nohl<cr>
nnoremap <leader>T :!ctags -R --exclude=.git --exclude=log .<cr>
nnoremap <leader>W :%s/\s\+$//<cr>                           " Remove whitespace

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

inoremap <c-]> <c-x><c-]>
inoremap <c-f> <c-x><c-f>
inoremap <c-l> <c-x><c-l>
inoremap <c-k> <c-x><c-p>
inoremap <c-j> <c-x><c-n>

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-P>"
   endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
inoremap <S-Tab> <c-n>

""" Autocommands
augroup vimrcEx
  autocmd!

  autocmd VimResized * exe "normal! \<c-w>="

  autocmd FileType gitcommit setlocal textwidth=72 spell colorcolumn=50
  autocmd FileType javascript inoremap lg console.log();<left><left>

  autocmd BufRead,BufNewFile *.md setlocal ft=markdown textwidth=80 spell
  autocmd BufRead,BufNewFile *.hamlc setlocal ft=haml
  autocmd BufRead,BufNewFile *.jbuilder setlocal ft=ruby

  autocmd BufWritePre *.html :normal gg=G

  " When editing a file, always jump to the last known cursor position
  au BufReadPost * if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --smart-case --nogroup --nocolor --column'
  set grepprg=ag\ --hidden\ --vimgrep grepformat^=%f:%l:%c:%m
else
  let &grepprg = 'grep -rn $* *'
endif
" command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen
" autocmd! FileType qf nnoremap <buffer> <leader>o <c-w><cr><c-w>L

""" Plugins
runtime macros/matchit.vim
call plug#begin('~/.vim/bundle')
Plug 'ajh17/Spacegray.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
  nnoremap \ :CtrlP<cr>
Plug 'junegunn/vim-after-object'
  autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', '.')
Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

Plug 'justinmk/vim-sneak'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'junegunn/vim-peekaboo'
Plug 'sheerun/vim-polyglot'
  let g:jsx_ext_required = 0
Plug 'othree/javascript-libraries-syntax.vim'
  let g:used_javascript_libs = 'underscore,react'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
  let g:easytags_async = 1
Plug 'majutsushi/tagbar'
  nnoremap tt :TagbarToggle<cr><c-w>=
Plug 'luochen1990/rainbow'
  let g:rainbow_active = 0
  if exists(':RainbowToggleOn') | exe "silent! RainbowToggleOn" | endif
Plug 'bling/vim-airline'
  let g:airline_detect_modified=0
  let g:airline_left_sep =''
  let g:airline_right_sep=''
Plug 'tpope/vim-rails'
  nnoremap rt  :AS<cr>
  nnoremap rtt :AV<cr>
  nnoremap rrr :AV<cr>
  nnoremap rs  :Sschema<cr>
  nnoremap rss :Vschema<cr>
  nnoremap rc  :Scontroller<space>
  nnoremap rcc :Vcontroller<space>
  nnoremap rm  :Smodel<space>
  nnoremap rmm :Vmodel<space>
  nnoremap rg  :Smigration<space>
  nnoremap rgg :Vmigration<space>
  nnoremap rl  :Slib<space>
  nnoremap rll :Vlib<space>
Plug 'scrooloose/syntastic'
  let g:syntastic_ruby_checkers = ['rubocop', 'mri']
  let g:syntastic_javascript_checkers = ['eslint']
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  nnoremap mm :NERDTreeToggle<cr><c-w>=
Plug 'djoshea/vim-autoread'
Plug 'ternjs/tern_for_vim'
call plug#end()

set t_Co=256
color Spacegray

" viming very hard here
set mouse=a

abbr bpr binding.pry
abbr iser user
abbr Teh the
abbr teh the

let g:netrw_liststyle=3

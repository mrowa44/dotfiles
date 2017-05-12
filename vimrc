""" General
let g:mapleader = ' '
syntax on
filetype plugin indent on
set hidden
set gdefault
set backspace=indent,eol,start
set wildmenu
set complete-=t
set visualbell
let g:netrw_liststyle=3

""" UI
set linebreak
set nofoldenable
set nojoinspaces
set scrolloff=8
set splitbelow splitright
set formatoptions+=j1
set textwidth=80
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set showcmd laststatus=2 ruler
set guioptions= guicursor+=a:blinkon0 guifont=Menlo:h12

""" Search
set hlsearch incsearch
set ignorecase smartcase
set showmatch matchtime=2

""" Indention
set autoindent smartindent
set expandtab smarttab
set shiftwidth=2 softtabstop=2 tabstop=2

""" Backups, undo
set noswapfile
set backup backupdir=~/.vim/backup
set undofile undodir=~/.vim/undo
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), 'p') | endif
if !isdirectory(expand(&undodir))   | call mkdir(expand(&undodir), 'p')   | endif

""" Mappings
nmap     §  <esc>
vnoremap §  <esc>
cnoremap §  <esc>
inoremap §  <esc>

cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-b> <s-left>
cnoremap w!! w !sudo tee %

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <left>  <c-w>H
nnoremap <down>  <c-w>J
nnoremap <up>    <c-w>K
nnoremap <right> <c-w>L
nnoremap <expr> n (v:searchforward ? 'n:call Flash()<cr>' : 'N:call Flash()<cr>')
nnoremap <expr> N (v:searchforward ? 'N:call Flash()<cr>' : 'n:call Flash()<cr>')
nnoremap <c-o> <c-o>zz:call Flash()<cr>
nnoremap <c-i> <c-i>zz:call Flash()<cr>
nnoremap * *zz:call Flash()<cr>
nnoremap # #zz:call Flash()<cr>
nnoremap j gj
nnoremap k gk
nnoremap Q @q
nnoremap - $
nnoremap Y y$
nnoremap K i<cr><esc>k$
nnoremap 99 :q<cr>
nnoremap <bs> `[V`]
nnoremap <leader><leader> :wa<cr>

nnoremap <leader>"  :s/'/"<cr>:nohl<cr>
nnoremap <leader>'  :s/"/'<cr>:nohl<cr>
nnoremap <leader>W  :%s/\s\+$//<cr>
nnoremap <leader>c  :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>e  :edit!<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>g  :Ag<cr>
nnoremap <leader>h  :nohlsearch<cr>
nnoremap <leader>i  :source $MYVIMRC<cr>:PlugInstall<cr>
nnoremap <leader>n  :setlocal number!<cr>
nnoremap <leader>p  o<esc>"+p
nnoremap <leader>ss :source Session.vim<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>y  "+y

inoremap <tab>   <c-r>=CleverTab()<cr>
inoremap <s-tab> <c-n>
inoremap <c-k>   <c-x><c-p>
inoremap <c-j>   <c-x><c-n>
inoremap <c-l>   <c-x><c-l>
inoremap <c-f>   <c-x><c-f>

inoremap <c-b> <c-w>

""" Custom functions
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~# '^\s*$'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

function! Flash()
  set cursorline
  redraw
  sleep 110m
  set nocursorline
endfunction

""" Autocommands
augroup vimrcEx
  autocmd!
  autocmd BufLeave * setlocal colorcolumn=
  " autocmd BufEnter * let &colorcolumn=join(range(&textwidth+1,999),",")
  autocmd BufEnter * let &colorcolumn=(&textwidth+1)
  autocmd BufEnter *.md setlocal colorcolumn=
  autocmd BufRead,BufNewFile *.md        setlocal ft=markdown spell
  autocmd BufRead,BufNewFile *.hamlc     setlocal ft=haml
  autocmd BufRead,BufNewFile *.jbuilder  setlocal ft=ruby
  autocmd BufRead,BufNewFile Dockerfile* setlocal ft=dockerfile
  " When editing a file, always jump to the last known cursor position
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft != 'gitcommit' |
        \   exe "normal! g`\"" |
        \ endif
  autocmd FileType gitcommit      setlocal textwidth=72 spell
  autocmd FileType cs             setlocal textwidth=130
  autocmd FileType html           setlocal textwidth=130
  autocmd FileType javascript,jsx setlocal textwidth=100
  autocmd FileType javascript,jsx inoremap lg console.log();<left><left>
  autocmd FileType javascript,jsx inoremap dg debugger;
  autocmd FileType javascript,jsx nnoremap so vi{:sort<cr><c-o>
  autocmd FileType javascript,jsx nnoremap sfs /\vconsole.log\|debugger\|console.table\|console.dir\|console.trace<cr>
  autocmd InsertLeave * silent! write
  autocmd InsertLeave * silent! set nopaste
  autocmd VimResized * execute "normal! \<c-w>="
  autocmd VimLeave   * execute "mksession!"
augroup END

""" Plugins
runtime macros/matchit.vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')
Plug 'vim-scripts/bclear'
Plug 'w0ng/vim-hybrid'
Plug 'ajh17/Spacegray.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
  nnoremap <c-p> :Files<cr>
  let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  xma  ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap gaa <Plug>(EasyAlign)ip
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'svg'] }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'chemzqm/vim-jsx-improve', { 'for': ['js', 'jsx'] }

Plug 'terryma/vim-smooth-scroll'
  noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 12, 3)<CR>
  noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 12, 3)<CR>
call plug#end()

""" Colors
set termguicolors background=light
color bclear

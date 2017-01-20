let mapleader = " "
syntax on
filetype plugin indent on

""" General
set hidden
set gdefault
set backspace=indent,eol,start
set wildmenu wildmode=list:longest,list:full
set clipboard=unnamed
set complete-=t
set visualbell

""" UI
set lazyredraw
set linebreak
set nofoldenable
set nojoinspaces
set scrolloff=8
set splitbelow splitright
set formatoptions+=j1
set textwidth=80
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:•,trail:• showbreak=↪
set showcmd laststatus=2 ruler

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
if !isdirectory(expand(&undodir))   | call mkdir(expand(&undodir), "p")   | endif

""" Mappings
nmap     §  <esc>
vnoremap §  <esc>
cnoremap §  <esc>
inoremap §  <esc>:echo "~~~~~ Use jj ~~~~~~"<cr>
inoremap jj <esc>

cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-b> <s-left>
" cnoremap <c-w> <s-right>
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
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

nnoremap Q @q
nnoremap - $
nnoremap Y y$
nnoremap K i<cr><esc>k$
nnoremap 99 :q<cr>
nnoremap <bs> `[V`]
nnoremap <leader> <Nop>
nnoremap <leader><leader> :wa<cr>

nnoremap <leader>c  :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>d  :Ack <c-r>/<cr>
nnoremap <leader>e  :edit!<cr>
nnoremap <leader>g  :Ack<Space>
nnoremap <leader>h  :nohlsearch<cr>
nnoremap <leader>n  :setlocal number!<cr>
nnoremap <leader>p  :set paste!<cr>
nnoremap <leader>q  :quit<cr>
nnoremap <leader>u  :vs#<cr>
nnoremap <leader>w  :write<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>ms :mksession!<cr>
nnoremap <leader>ss :source Session.vim<cr>
nnoremap <leader>W  :%s/\s\+$//<cr>
nnoremap <leader>"  :s/'/"<cr>:nohl<cr>
nnoremap <leader>'  :s/"/'<cr>:nohl<cr>

inoremap <tab>   <c-r>=CleverTab()<cr>
inoremap <s-tab> <c-n>
inoremap <c-k>   <c-x><c-p>
inoremap <c-j>   <c-x><c-n>
inoremap <c-l>   <c-x><c-l>
inoremap <c-f>   <c-x><c-f>

inoremap <c-b> <c-w>

function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
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
  " When editing a file, always jump to the last known cursor position
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft != 'gitcommit' |
    \   exe "normal! g`\"" |
    \ endif
  autocmd BufLeave * setlocal colorcolumn=
  autocmd BufEnter * let &colorcolumn=join(range(&textwidth,999),",")
  autocmd BufRead,BufNewFile *.md       setlocal ft=markdown spell
  autocmd BufRead,BufNewFile *.hamlc    setlocal ft=haml
  autocmd BufRead,BufNewFile *.jbuilder setlocal ft=ruby
  autocmd BufEnter * if &ft ==# 'gitcommit' | :3 | endif
  autocmd FileType gitcommit      setlocal textwidth=72 spell
  autocmd FileType html           setlocal textwidth=130
  autocmd FileType sql            setlocal textwidth=120
  autocmd FileType javascript     setlocal textwidth=100
  autocmd FileType javascript     inoremap lg console.log();<left><left>
  autocmd FileType javascript     nnoremap so vi{:sort<cr><c-o>
  autocmd FileType javascript     nnoremap sr G?render<cr>:nohl<cr>
  autocmd FileType javascript     nnoremap sfs /\vconsole.log\|debugger\|console.table\|console.dir\|console.trace<cr>
  autocmd FileType ruby           inoremap bp binding.pry
  autocmd FileType qf             nnoremap <buffer> <c-l> <C-w><Enter><C-w>L
  autocmd FileChangedShell * echo "Warning: File changed outside of vim"
  autocmd InsertLeave * silent! write
  autocmd InsertLeave * silent! set nopaste
  autocmd VimResized * execute "normal! \<c-w>="
  autocmd VimLeave   * execute "mksession!"
augroup END

""" Plugins
runtime macros/matchit.vim
call plug#begin('~/.vim/bundle')
Plug 'altercation/vim-colors-solarized'
Plug 'croaky/vim-colors-github'
Plug 'reedes/vim-colors-pencil'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'wincent/ferret'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'stardiviner/AutoSQLUpperCase.vim', { 'for': 'sql' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  xma ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap gaa <Plug>(EasyAlign)ip
Plug 'chemzqm/vim-jsx-improve'
" Plug 'sheerun/vim-polyglot' " turn off for js
call plug#end()

""" Colors
set termguicolors
color pencil
" highlight ColorColumn ctermbg=gray guibg=gray93
highlight jsThis ctermfg=blue guifg=darkgray
" highlight jsString ctermfg=darkcyan guifg=darkcyan

""" Typos
iabbr iser user
iabbr Teh the
iabbr teh the
iabbr cosnt const
iabbr rpors props
iabbr reutrn return
iabbr treu true
iabbr thus this
iabbr porps props

set guioptions=
set guicursor+=a:blinkon0
set guifont=Menlo:h12

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
endif

let g:netrw_liststyle=3

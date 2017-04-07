""" General
let g:mapleader = ' '
syntax on
filetype plugin indent on
set hidden
set gdefault
set backspace=indent,eol,start
set wildmenu " wildmode=list:longest,list:full
set complete-=t
set visualbell
set nottimeout
let g:netrw_liststyle=3

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
inoremap jj <esc>

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

nnoremap <leader>"  :s/'/"<cr>:nohl<cr>
nnoremap <leader>'  :s/"/'<cr>:nohl<cr>
nnoremap <leader>W  :%s/\s\+$//<cr>
nnoremap <leader>c  :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>e  :edit!<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>g  :Ag<cr>
nnoremap <leader>h  :nohlsearch<cr>
nnoremap <leader>i  :PlugInstall<cr>
nnoremap <leader>ms :mksession!<cr>
nnoremap <leader>n  :setlocal number!<cr>
nnoremap <leader>p  o<esc>"+p
nnoremap <leader>q  :quit<cr>
nnoremap <leader>ss :source Session.vim<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>t  :call ToggleTheme()<cr>
nnoremap <leader>u  :vs#<cr>
nnoremap <leader>w  :write<cr>
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

function! ToggleTheme()
  if (g:colors_name ==? 'bclear')
    color hybrid
    set background=dark
  else
    color bclear
    set background=light
  endif
endfunction

""" Autocommands
augroup vimrcEx
  autocmd!
  autocmd BufEnter * let &colorcolumn=join(range(&textwidth,999),",")
  autocmd BufLeave * setlocal colorcolumn=
  autocmd BufRead,BufNewFile *.md       setlocal ft=markdown spell
  autocmd BufRead,BufNewFile *.hamlc    setlocal ft=haml
  autocmd BufRead,BufNewFile *.jbuilder setlocal ft=ruby
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  autocmd BufWritePost $HOME/dotfiles/vimrc source $HOME/dotfiles/vimrc
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
  autocmd FileType ruby           inoremap bp binding.pry
  autocmd FileChangedShell * echo "Warning: File changed outside of vim"
  autocmd InsertLeave * silent! write
  autocmd InsertLeave * silent! set nopaste
  autocmd VimResized * execute "normal! \<c-w>="
  autocmd VimLeave   * execute "mksession!"
augroup END

""" Plugins
runtime macros/matchit.vim
call plug#begin('~/.vim/bundle')
Plug 'w0ng/vim-hybrid'
Plug 'vim-scripts/bclear'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
  nnoremap <c-p> :GFiles<cr>
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  xma  ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap gaa <Plug>(EasyAlign)ip
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'chemzqm/vim-jsx-improve', { 'for': ['js', 'jsx'] }
Plug 'Yggdroot/indentLine'

Plug 'terryma/vim-expand-region'
Plug 'OrangeT/vim-csharp'
" Plug 'wincent/ferret'
call plug#end()

""" Colors
set termguicolors background=light
color bclear

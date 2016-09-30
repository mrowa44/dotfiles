let mapleader = " "
syntax on
filetype plugin indent on

""" General
set hidden
set gdefault
set backspace=indent,eol,start
set wildmenu wildmode=list:longest,list:full

""" UI
set lazyredraw
set linebreak
set nofoldenable
set nojoinspaces
set scrolloff=8
set splitbelow splitright
set formatoptions+=j1
set showcmd
set textwidth=80
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:•,trail:• showbreak=↪
set laststatus=2
set statusline=\ %f\ %y%m%r%h%q%=
set statusline+=[%P]\ %l\ :\ %c\ 
let &colorcolumn=&textwidth

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
inoremap §  <esc>
" inoremap jk <esc>

cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-b> <s-left>
cnoremap <c-w> <s-right>
cnoremap w!! w !sudo tee %

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <left>  <c-w>H
nnoremap <down>  <c-w>J
nnoremap <up>    <c-w>K
nnoremap <right> <c-w>L
nnoremap <expr> n (v:searchforward ? 'nzz' : 'Nzz')
nnoremap <expr> N (v:searchforward ? 'Nzz' : 'nzz')
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz
nnoremap * *zz
nnoremap # #zz
nnoremap j gj
nnoremap k gk
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

nnoremap Q @q
xnoremap . :norm.<cr>
xnoremap @ :norm@
nnoremap - $
nnoremap Y y$
nnoremap K i<cr><esc>k$
nnoremap <bs> `[V`]
nnoremap <cr> :wa<cr>
nnoremap <leader><leader> :w<cr>
nnoremap <leader> <Nop>

nnoremap <leader>a  :silent !atom %<cr>
nnoremap <leader>c  :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>e  :e!<cr>
nnoremap <leader>g  :Ack<Space>
nnoremap <leader>h  :nohlsearch<cr>
nnoremap <leader>n  :setlocal number!<cr>
nnoremap <leader>p  :set paste!<cr>
nnoremap <leader>q  :q<cr>
nnoremap <leader>u  :vs#<cr>
nnoremap <leader>w  :w<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>ms :mksession!<cr>
nnoremap <leader>ss :source Session.vim<cr>
nnoremap <leader>W  :%s/\s\+$//<cr>
nnoremap <leader>"  :s/'/"<cr>:nohl<cr>
nnoremap <leader>'  :s/"/'<cr>:nohl<cr>

inoremap <c-]>   <c-x><c-]>
inoremap <c-f>   <c-x><c-f>
inoremap <c-l>   <c-x><c-l>
inoremap <c-k>   <c-x><c-p>
inoremap <c-j>   <c-x><c-n>
inoremap <tab>   <c-r>=CleverTab()<cr>
inoremap <s-tab> <c-n>
inoremap <c-b>   <c-w>

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<tab>"
   else
      return "\<c-p>"
   endif
endfunction

""" Autocommands
augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft != 'gitcommit' |
    \   exe "normal! g`\"" |
    \ endif

  autocmd BufEnter * let &colorcolumn=&textwidth
  autocmd BufLeave * setlocal colorcolumn=

  autocmd BufRead,BufNewFile *.md setlocal ft=markdown spell
  autocmd BufRead,BufNewFile *.hamlc setlocal ft=haml
  autocmd BufRead,BufNewFile *.jbuilder setlocal ft=ruby

  autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout
  " autocmd BufWritePre *.html normal gg=G

  autocmd FileType gitcommit  setlocal textwidth=72 spell
  autocmd FileType javascript setlocal textwidth=120
  autocmd FileType javascript inoremap lg console.log();<left><left>
  autocmd FileType javascript nnoremap so vi{:sort<cr><c-o>
  " autocmd FileType javascript nnoremap <c-p> ^dt($xds(
  autocmd FileType ruby       inoremap bp binding.pry
  autocmd FileType scss       inoremap ttt @include theme();<left><left>

  autocmd FileChangedShell * echo "Warning: File changed outside of vim"
  autocmd InsertLeave      * silent! write
  autocmd InsertLeave      * silent! set nopaste
  autocmd VimResized       * execute "normal! \<c-w>="
augroup END

""" Plugins
runtime macros/matchit.vim
call plug#begin('~/.vim/bundle')
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'wincent/ferret', { 'branch': 'autojump' }
  let g:FerretAutojump = 1
Plug 'ctrlpvim/ctrlp.vim'
 nnoremap \ :CtrlP<cr>
Plug 'vim-scripts/SearchComplete'
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'stardiviner/AutoSQLUpperCase.vim', { 'for': 'sql' }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap gaa <Plug>(EasyAlign)ip
call plug#end()

color solarized

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
endif

" viming very hard here
set mouse=a

nnoremap sfs /\vconsole.log\|debugger\|console.table\|console.dir<cr>
nnoremap sr G?render<cr>:nohl<cr>
iabbr iser user
iabbr Teh the
iabbr teh the

let g:netrw_liststyle=3

" highlight Comment cterm=italic
set guioptions=
set guicursor+=a:blinkon0

" augroup filetypeRuby
"   autocmd!
"   autocmd FileType ruby nnoremap rt  :AS<cr>
"   autocmd FileType ruby nnoremap rtt :AV<cr>
"   autocmd FileType ruby nnoremap rrr :AV<cr>
"   autocmd FileType ruby nnoremap rs  :Sschema<cr>
"   autocmd FileType ruby nnoremap rss :Vschema<cr>
"   autocmd FileType ruby nnoremap rc  :Scontroller<space>
"   autocmd FileType ruby nnoremap rcc :Vcontroller<space>
"   autocmd FileType ruby nnoremap rm  :Smodel<space>
"   autocmd FileType ruby nnoremap rmm :Vmodel<space>
"   autocmd FileType ruby nnoremap rg  :Smigration<space>
"   autocmd FileType ruby nnoremap rgg :Vmigration<space>
"   autocmd FileType ruby nnoremap rl  :Slib<space>
"   autocmd FileType ruby nnoremap rll :Vlib<space>
" augroup END

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
set noendofline

""" UI
set lazyredraw
set linebreak
set nofoldenable
set nojoinspaces
set number
set scrolloff=8
set splitbelow splitright
set formatoptions+=j1
set showcmd showbreak=↪
set textwidth=80 colorcolumn=+1
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:•,trail:•
set laststatus=2
set statusline=\ %f\ %y%m%r%h%q\ %{fugitive#head()}%=
set statusline+=[%{strlen(&fenc)?&fenc:'none'}]\ [%P]\ %l\ :\ %c\ 

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
cnoremap w!! w !sudo tee %

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <left>  <c-w>H
nnoremap <down>  <c-w>J
nnoremap <up>    <c-w>K
nnoremap <right> <c-w>L
nnoremap j gj
nnoremap k gk
nnoremap n nzz
nnoremap N Nzz
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
"        ]c next git chunk
"        [c prev git chunk

nnoremap Y y$
nnoremap K i<cr><esc>k$
nnoremap <leader><leader> :w<cr>
nnoremap Q @q
" nnoremap <cr> :wa<cr>:!!<cr>

nnoremap <leader>b  :let &background = (&background == "dark" ? "light" : "dark")<cr>
nnoremap <leader>c  :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>e  :e!<cr>
nnoremap <leader>f  :vsp <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <leader>g  :Ack<Space>
nnoremap <leader>h  :nohlsearch<cr>
nnoremap <leader>n  :setlocal number!<cr>
nnoremap <leader>p  :set paste!<cr>
nnoremap <leader>q  :q<cr>
nnoremap <leader>r  :RainbowToggle<cr>
nnoremap <leader>w  :w<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>/Mappings<cr>5}:nohl<cr>
nnoremap <leader>T  :!ctags -R --exclude=.git --exclude=log .<cr>
nnoremap <leader>W  :%s/\s\+$//<cr>

inoremap <c-]> <c-x><c-]>
inoremap <c-f> <c-x><c-f>
inoremap <c-l> <c-x><c-l>
inoremap <c-k> <c-x><c-p>
inoremap <c-j> <c-x><c-n>

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<tab>"
   else
      return "\<c-p>"
   endif
endfunction
inoremap <tab> <c-r>=CleverTab()<cr>
inoremap <s-tab> <c-n>

""" Autocommands
augroup vimrcEx
  autocmd!

  autocmd VimResized * exe "normal! \<c-w>="

  " autocmd VimLeave * mksession!
  " autocmd VimEnter * silent! source Session.vim

  " autocmd WinLeave * setlocal nocursorline
  " autocmd WinEnter * setlocal cursorline
  " autocmd VimEnter * setlocal cursorline

  autocmd FileType gitcommit setlocal textwidth=72 spell colorcolumn=50
  autocmd FileType javascript inoremap lg console.log();<left><left>

  autocmd BufWritePre *.html :normal gg=G

  autocmd BufRead,BufNewFile *.md setlocal ft=markdown textwidth=80 spell
  autocmd BufRead,BufNewFile *.hamlc setlocal ft=haml
  autocmd BufRead,BufNewFile *.jbuilder setlocal ft=ruby

  autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout

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

""" Plugins
runtime macros/matchit.vim
call plug#begin('~/.vim/bundle')
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'rstacruz/vim-closer'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
  nnoremap \ :CtrlP<cr>
Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-peekaboo'
Plug 'luochen1990/rainbow', { 'on': 'RainbowToggleOn' }
  let g:rainbow_active = 0
  if exists(':RainbowToggleOn') | exe "silent! RainbowToggleOn" | endif
Plug 'mileszs/ack.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
  augroup filetypeRuby
    autocmd!
    autocmd FileType ruby nnoremap rt  :AS<cr>
    autocmd FileType ruby nnoremap rtt :AV<cr>
    autocmd FileType ruby nnoremap rrr :AV<cr>
    autocmd FileType ruby nnoremap rs  :Sschema<cr>
    autocmd FileType ruby nnoremap rss :Vschema<cr>
    autocmd FileType ruby nnoremap rc  :Scontroller<space>
    autocmd FileType ruby nnoremap rcc :Vcontroller<space>
    autocmd FileType ruby nnoremap rm  :Smodel<space>
    autocmd FileType ruby nnoremap rmm :Vmodel<space>
    autocmd FileType ruby nnoremap rg  :Smigration<space>
    autocmd FileType ruby nnoremap rgg :Vmigration<space>
    autocmd FileType ruby nnoremap rl  :Slib<space>
    autocmd FileType ruby nnoremap rll :Vlib<space>
  augroup END

Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
  let g:easytags_async = 1
Plug 'majutsushi/tagbar'
  nnoremap tt :TagbarToggle<cr><c-w>=
Plug 'junegunn/vim-after-object'
  autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', '.')
Plug 'AndrewRadev/switch.vim'
  nnoremap <cr> :Switch<cr>

" Plug 'wincent/ferret'
" Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
" Plug 'scrooloose/syntastic'
"   let g:syntastic_ruby_checkers = ['rubocop', 'mri']
"   let g:syntastic_javascript_checkers = ['eslint']
" Plug 'ternjs/tern_for_vim'
" Plug 'AndrewRadev/splitjoin.vim'
call plug#end()

color base16-ocean

" viming very hard here
set mouse=a

abbr bpr binding.pry
abbr iser user
abbr Teh the
abbr teh the

let g:netrw_liststyle=3

let mapleader = " "
syntax on
filetype plugin indent on

set backspace=indent,eol,start
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite
set nocompatible
set autoread
set linebreak
set ignorecase
set smartcase
set hlsearch
set visualbell
set cursorline
set showmatch
set undofile
set wildmenu
set hidden
set gdefault
set noshowmode
set scrolloff=8
set encoding=utf-8
set lazyredraw
set formatoptions+=j
set nojoinspaces
set tabstop=2
set expandtab
set shiftwidth=2
set shiftround
set textwidth=80
set wrap
set colorcolumn=+1
set numberwidth=5
set number
set relativenumber
set splitbelow
set splitright
set autoindent
set smartindent
set nofoldenable
set list listchars=tab:▸·,trail:•
set omnifunc=syntaxcomplete#Complete

" Auto resize splits after window resize
autocmd! VimResized * exe "normal! \<c-w>="

autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorline

" Save on lost focus
au FocusLost * :wa

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nmap j gj
nmap k gk

" Auto center searching, n - always forward, N - always backward
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <expr> n  'Nn'[v:searchforward].'zvzz'
nnoremap <expr> N  'nN'[v:searchforward].'zvzz'

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --nogroup --nocolor --column'
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
nnoremap <Leader>g :Ack<Space>
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" Tab completion
" will insert tab at beginning of line, will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

""" Keys
imap § <Esc>
nmap § <Esc>
vmap § <Esc>
cmap § <Esc>
imap jk <Esc>
nnoremap <Leader><Leader> :w<cr>
nnoremap <c-w> :w<cr>
nnoremap <Leader>H :nohlsearch<cr>
nnoremap <Leader>h :nohlsearch<cr>
nnoremap K i<cr><esc>k$                 " Split lines
nnoremap Y y$                           " Y
map Q <Nop>
nmap Q @q                               " qq to record, Q to replay
imap hh ,
imap jj .
imap kk ?
set pastetoggle=<F12>
nmap dad $F.D                           " Delete after dot
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>e :e!<cr>
" nnoremap <leader>w <C-w>v<C-w>l
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>
set clipboard^=unnamed
set ttimeoutlen=50

" Automatically wrap at 80 characters for Markdown, enable spellchecking
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd FileType markdown setlocal spell

" Automatically wrap at 72 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal colorcolumn=50

au! BufRead,BufNewFile *.hamlc set ft=haml
au! BufRead,BufNewFile *.jbuilder set ft=ruby
au! BufRead,BufNewFile *.md set ft=markdown

" :Chomp
command! Chomp silent! normal! :%s/\s\+$//<cr>
nnoremap <leader>W :Chomp<cr>

""" Plugins
" set shell=bash
call plug#begin('~/.vim/bundle')
Plug 'ctrlpvim/ctrlp.vim'
  nmap \ <C-p>
  nnoremap <leader>t :CtrlPTag<cr>
  nnoremap <leader>l :CtrlPLine<cr>
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
  " autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  map <C-n> :NERDTreeToggle<CR>
  map <C-m> :NERDTreeFind<cr>
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bling/vim-airline'
  let g:airline_detect_modified=0
  let g:airline_detect_paste=1
  let g:airline_powerline_fonts =1
  let g:airline_exclude_preview=1
  let g:airline#extensions#syntastic#enabled = 1
Plug 'edkolev/tmuxline.vim'
  let g:tmuxline_preset = {
    \'b'       : '#h',
    \'c'       : '#S',
    \'win'     : '#I #W',
    \'cwin'    : '#I #W',
    \'x'       : '%H:%M',
    \'y'       : '%Y-%m-%d',
    \'options' : {'status-justify' : 'centre'}}
  "     
  let g:tmuxline_separators = {
      \ 'left' : '',
      \ 'left_alt': '',
      \ 'right' : '',
      \ 'right_alt' : '',
      \ 'space' : ' '}
Plug 'christoomey/vim-tmux-navigator'
Plug 'sjl/vitality.vim'
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_sign_column_always = 1
  " let g:gitgutter_map_keys = 0
  " let g:gitgutter_override_sign_column_highlight = 0
Plug 'scrooloose/syntastic'
  let g:syntastic_enable_signs= 1
  let g:syntastic_check_on_open=1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_enable_highlighting = 0
  let g:syntastic_echo_current_error = 1
  let g:syntastic_ruby_checkers = ['rubocop', 'mri']
  let g:syntastic_coffescript_checkers = ['coffee']
  let g:syntastic_haml_checkers = ['haml']
  let g:syntastic_javascript_checkers = ['eslint']
Plug 'kien/rainbow_parentheses.vim'
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/SearchComplete'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/matchit.zip'
  autocmd FileType ruby let b:match_words = '\<do\>:\<end\>'
Plug 'justinmk/vim-sneak'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-rails'
  map <leader>m :Rmodel<cr>
  map <leader>v :Rview<cr>
  map <leader>c :Rcontroller<cr>
  map <leader>r :Rmigration<cr>
Plug 'keith/rspec.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 0
Plug 'othree/javascript-libraries-syntax.vim'
  let g:used_javascript_libs = 'underscore,backbone,jquery,react'
Plug 'skammer/vim-css-color', { 'for': ['css', 'scss'] }
Plug 'ajh17/Spacegray.vim'
Plug 'gosukiwi/vim-atom-dark'
call plug#end()

set t_Co=256
set background=dark
color Spacegray
" color atom-dark-256

map <leader>f :vsp <CR>:exec("tag ".expand("<cword>"))<CR> " Open the tag in a new vsplit
nnoremap <silent> <leader>T :!ctags -R --exclude=.git --exclude=log --exclude=vendor .<cr>

abbr bpr binding.pry
abbr iser user
abbr bananas console.log('bananas')

" " Colors
" hi StatusLine                cterm=NONE  ctermfg=60
" hi StatusLineNC              cterm=NONE  ctermfg=61
" hi LineNr                    ctermfg=246 ctermbg=None cterm=NONE
" hi ColorColumn               ctermbg=60
" hi VertSplit                 ctermfg=234 ctermbg=234

" " Don't lose selection when shifting sidewards
" xnoremap <  <gv
" xnoremap >  >gv

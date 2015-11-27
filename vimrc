syntax on
filetype on
filetype plugin on
filetype indent on

set nocompatible                " Vim rather than Vi settings
set number                      " Lines numbers
set showmode                    " Show which mode
set ruler                       " Lines info at the bottom
set autoread                    " If file changed outside of vim autoload
set noswapfile                  " No swap files
set linebreak                   " Wrap lines at convenient point
set incsearch                   " Incremental searching
set ignorecase                  " Ignore case when searching
set smartcase                   " ^ Unless you type a capital letter
set hlsearch                    " Search highlighting
set visualbell                  " Shut the fuck up
set cursorline                  " Highlight current line
set showmatch                   " Highlight matching [{()}]
set autoindent                  " Auto indention
set smartindent                 " Smart indent
set splitbelow                  " More logical splitting
set splitright                  " Same as above
set undofile                    " Save undos, after quit vim
set lazyredraw                  " Redraw only when we need to
set wildmenu                    " Visual autocomplete
set expandtab                   " Turns tabs into spaces
set tabstop=2                   " 2 spaces to be exact
set scrolloff=8                 " Always show 8 lines below and above
set shiftwidth=2                " Indention
set laststatus=2                " Always leave status line
set encoding=utf-8              " Encoding
set backspace=indent,eol,start  " Working backspace
set wildmode=longest:full,full
set list listchars=tab:»·,trail:·,nbsp:·

execute pathogen#infect()
" colorscheme dracula

""" Status line
hi StatusLine                cterm=NONE
hi StatusLineNC              cterm=NONE

set stl=%F\ \ \                     " Full path to the file
set stl+=%y                         " Filetype
set stl+=%=                         " Right align
set stl+=Line:\ %l/%L\ [\ %p%%\ ]   " Lines info

""" Keys
let mapleader = "\<Space>"
imap § <Esc>
nmap § <Esc>
vmap § <Esc>
nmap <Leader><Leader> :w<cr>
nmap \ <C-p>
nmap <Leader>H :nohlsearch<cr>      " Turn off annoying search highlighting

""" Movement
nmap j gj
nmap k gk
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

""" Other
" Smart tab - if at the bol <tab>, else autocompletion.
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

" Auto resize splits after window resize
autocmd! VimResized * exe "normal! \<c-w>="

" Show 80th column
if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn ctermbg=60
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages or when the position is invalid
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Automatically wrap at 80 characters for Markdown, enable spellchecking
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd FileType markdown setlocal spell
" Automatically wrap at 72 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal colorcolumn=50
" Filetype specific
au BufRead,BufNewFile *.hamlc set ft=haml
autocmd filetype crontab setlocal nobackup nowritebackup

""" Plugin specific
" Always show sign column (git-gutter)
let g:gitgutter_sign_column_always = 1
" Don't set any git-gutter mappings
let g:gitgutter_map_keys = 0
" Same column color
" let g:gitgutter_override_sign_column_highlight = 0

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'
nnoremap <Leader>g :Ack<Space>
if executable('ag')
  let g:ackprg = 'ag'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" hamlc syntax
au! BufRead,BufNewFile *.hamlc set ft=haml

" Reload .vimrc with every save
autocmd bufwritepost .vimrc source $MYVIMRC

abbr kurwa console.log('banany')
abbr cll console.log()

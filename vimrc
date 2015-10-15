set nocompatible                " Vim rather than Vi settings
syntax on
filetype on
filetype plugin on
filetype indent on

execute pathogen#infect()

set number                      " Lines numbers
set showmode                    " Show which mode
set ruler                       " Lines info at the bottom
set expandtab                   " Turns tabs into spaces
set tabstop=2                   " 2 spaces to be exact
set shiftwidth=2                " Indention
set backspace=indent,eol,start  " Working backspace
set autoread                    " If file changed outside of vim autoload
set noswapfile                  " No swap files
set linebreak                   " Wrap lines at convenient point
set incsearch                   " Incremental searching
set ignorecase                  " Ignore case when searching
set smartcase                   " ^ Unless you type a capital letter
set hlsearch                    " Search highlighting
set visualbell                  " Shut the fuck up
set cursorline                  " Highlight current line
set wildmenu                    " Visual autocomplete for command menu
set showmatch                   " Highlight matching [{()}]
set laststatus=2                " Always leave status line
set autoindent                  " Auto indention
set smartindent                 " Smart indent
set scrolloff=8                 " Always show 8 lines below and above
set splitbelow                  " More logical splitting
set splitright                  " Same as above
set undofile                    " Save undos, after quit vim
set lazyredraw                  " Redraw only when we need to
set encoding=utf-8

" Status line
" set stl=%F\                     " Full path to the file
" set stl+=%y                     " Filetype
" set stl+=%=                     " Right align
" set stl+=Line:\ %l/%L\ [%p%%]   " Lines info
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Colors
" set background=dark
colorscheme molokai

" Leader, escape (escape key on mac is too small)
" Long lines
let mapleader = " "
imap § <Esc>
nmap § <Esc>
vmap § <Esc>
nmap <Leader><Leader> :w<cr>
nmap \ <C-p>
nmap j gj
nmap k gk
" Turn off annoying search highlighting
nnoremap <Leader>H :nohlsearch<cr>

" Quicker window movement
nmap <Leader>h <C-w>h
nmap <Leader>j <C-w>j
nmap <Leader>k <C-w>k
nmap <Leader>l <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Reload .vimrc with every save
" autocmd bufwritepost .vimrc source ~/.vimrc

" Always show sign column (git-gutter)
let g:gitgutter_sign_column_always = 1
" Don't set any git-gutter mappings
let g:gitgutter_map_keys = 0
" Same column color
let g:gitgutter_override_sign_column_highlight = 0

" Smart tab - if at the bol <tab>, else autocompletion.
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

" Auto resize splits after window resize
augroup Misc
    autocmd!
    autocmd VimResized * exe "normal! \<c-w>="
augroup END

" Show 80th column
if exists('+colorcolumn')
    set colorcolumn=80
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
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

" Strip all whitespace in a file with leader-s
function! StripWhitespace ()
    exec ':%s/ \+$//g'
endfunction
map <leader>s :call StripWhitespace ()<CR>

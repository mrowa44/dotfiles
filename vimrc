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
set hidden                      " Causes files to be hidden instead of closed
set gdefault                    " Use :%s/foo/bar/ instead of :%s/foo/bar/g
set tabstop=2                   " 2 spaces to be exact
set scrolloff=8                 " Always show 8 lines below and above
set shiftwidth=2                " Indention
set laststatus=2                " Always leave status line
set encoding=utf-8              " Encoding
set backspace=indent,eol,start  " Working backspace
set wildmode=longest:full,full
set list listchars=tab:»·,trail:·,nbsp:·

execute pathogen#infect()

" Colors
hi StatusLine                cterm=NONE  ctermfg=60
hi StatusLineNC              cterm=NONE  ctermfg=60
hi LineNr                    ctermfg=60
hi ColorColumn               ctermbg=60

""" Status line
" set stl=%F\ \ \                     " Full path to the file
" set stl+=%y                         " Filetype
" set stl+=%=                         " Right align
" set stl+=Line:\ %l/%L\ [\ %p%%\ ]   " Lines info

""" Keys
let mapleader = "\<Space>"
imap § <Esc>
nmap § <Esc>
vmap § <Esc>
cmap § <Esc>
nnoremap <Leader><Leader> :w<cr>
nmap \ <C-p>
nnoremap <Leader>H :nohlsearch<cr>      " Turn off annoying search highlighting
nnoremap K i<cr><esc>k$                 " Split lines
nnoremap Y y$                           " Y
map Q <Nop>
nmap Q @q                               " qq to record, Q to replay
set pastetoggle=<F2>                    " Toggle paste with f2

""" Movement
nmap j gj
nmap k gk
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Auto center searching
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz


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

autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorline

" Show 80th column
if exists('+colorcolumn')
  set colorcolumn=81
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages or when the position is invalid
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" :Chomp
command! Chomp silent! normal! :%s/\s\+$//<cr>


" Filetypes
" Automatically wrap at 80 characters for Markdown, enable spellchecking
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd FileType markdown setlocal spell

" Automatically wrap at 72 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal colorcolumn=50

au! BufRead,BufNewFile *.hamlc set ft=haml
au! BufRead,BufNewFile *.jbuilder set ft=ruby
autocmd filetype crontab setlocal nobackup nowritebackup


""" Plugins
let g:gitgutter_sign_column_always = 1
let g:gitgutter_map_keys = 0
" let g:gitgutter_override_sign_column_highlight = 0

" let g:AutoPairsFlyMode = 1

let g:airline_theme='powerlineish'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline#extensions#syntastic#enabled = 1

let g:tmuxline_theme = 'powerline'
let g:tmuxline_preset = {
      \'c'    : '#h',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : ['%H:%M'],
      \'y'    : ['%Y-%m-%d'],
      \'options': {'status-bg': 'colour233', 'statud-fg': 'colour60'} }
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '}

let g:syntastic_enable_signs=1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_echo_current_error = 0
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_coffescript_checkers = ['coffee']
let g:syntastic_haml_checkers = ['haml']
let g:syntastic_javascript_checkers = ['standard']

map <leader>f :vsp <CR>:exec("tag ".expand("<cword>"))<CR> " Open the tag in a new vsplit
nnoremap <leader>T :!ctags -R --exclude=.git --exclude=log --exclude=vendor *<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>l :CtrlPLine<cr>
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:55,results:25'
nnoremap <Leader>g :Ack<Space>
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
  let &grepprg = 'ag --nogroup --nocolor --column'
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore-dir=shared --ignore-dir=vendor --ignore-dir=public -g ""'
  let g:ctrlp_use_caching = 0
else
  let &grepprg = 'grep -rn $* *'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" Reload .vimrc with every save
" autocmd bufwritepost .vimrc source $MYVIMRC

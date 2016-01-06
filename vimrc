" Leader
let mapleader = " "

set backspace=indent,eol,start  " Working backspace
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " jump to search word as you type
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:▸·,trail:•

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --nogroup --nocolor --column'
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif

nnoremap <Leader>g :Ack<Space>
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

set textwidth=80
set colorcolumn=+1

set numberwidth=5
set number
set relativenumber

let g:gitgutter_sign_column_always = 1
" let g:gitgutter_map_keys = 0
" let g:gitgutter_override_sign_column_highlight = 0

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
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

" " Switch between the last two files
" nnoremap <leader><leader> <c-^>

" " vim-rspec mappings
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>

" " Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

set splitbelow
set splitright

" Auto resize splits after window resize
autocmd! VimResized * exe "normal! \<c-w>="

autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorline

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nmap j gj
nmap k gk

" Auto center searching
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

""" Keys
imap § <Esc>
nmap § <Esc>
vmap § <Esc>
cmap § <Esc>
imap jk <Esc>
nnoremap <Leader><Leader> :w<cr>
nmap \ <C-p>
nnoremap <Leader>H :nohlsearch<cr>      " Turn off annoying search highlighting
nnoremap <Leader>h :nohlsearch<cr>
nnoremap K i<cr><esc>k$                 " Split lines
nnoremap Y y$                           " Y
map Q <Nop>
nmap Q @q                               " qq to record, Q to replay
imap hh ,
imap jj .
imap kk ?
set pastetoggle=<F12>                    " Toggle paste with f12
nmap dad $F.D                           " Delete after dot
nnoremap <leader>so :source $MYVIMRC<CR>
nnoremap <Leader>e :e!<cr>


set nocompatible                " Vim rather than Vi settings
set autoread                    " If file changed outside of vim autoload
set linebreak                   " Wrap lines at convenient point
set ignorecase                  " Ignore case when searching
set smartcase                   " ^ Unless you type a capital letter
set hlsearch                    " Search highlighting
set visualbell                  " Shut the fuck up
set cursorline                  " Highlight current line
set showmatch                   " Highlight matching [{()}]
set undofile                    " Save undos, after quit vim
set wildmenu                    " Visual autocomplete
set hidden                      " Causes files to be hidden instead of closed
set gdefault                    " Use :%s/foo/bar/ instead of :%s/foo/bar/g
set noshowmode                  " Don't show default modes indicators
set scrolloff=8                 " Always show 8 lines below and above
set encoding=utf-8              " Encoding
set lazyredraw                  " Redraw only when we need to

execute pathogen#infect()

" Colors
" hi StatusLine                cterm=NONE  ctermfg=60
" hi StatusLineNC              cterm=NONE  ctermfg=61
hi LineNr                    ctermfg=60
hi ColorColumn               ctermbg=60
hi VertSplit                 ctermfg=234 ctermbg=234

""" Status line
" set stl=%F\ \ \                     " Full path to the file
" set stl+=%y                         " Filetype
" set stl+=%=                         " Right align
" set stl+=Line:\ %l/%L\ [\ %p%%\ ]   " Lines info

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

""" Plugins
let g:airline_detect_modified=0
let g:airline_detect_paste=1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_powerline_fonts =1
let g:airline_exclude_preview=1
" let g:airline_theme='powerlineish'

let g:tmuxline_preset = {
    \'b'       : '#h',
    \'c'       : '#S',
    \'win'     : '#I #W',
    \'cwin'    : '#I #W',
    \'x'       : '%H:%M',
    \'y'       : '%Y-%m-%d',
    \'options' : {'status-justify' : 'centre'}}

" let g:tmuxline_separators = {
"     \ 'left' : '',
"     \ 'left_alt': '',
"     \ 'right' : '',
"     \ 'right_alt' : '',
"     \ 'space' : ' '}

let g:syntastic_enable_signs= 1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_highlighting = 0
let g:syntastic_echo_current_error = 1
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_coffescript_checkers = ['coffee']
let g:syntastic_haml_checkers = ['haml']
let g:syntastic_javascript_checkers = ['eslint']

let g:jsx_ext_required = 0

map <leader>f :vsp <CR>:exec("tag ".expand("<cword>"))<CR> " Open the tag in a new vsplit
nnoremap <silent> <leader>T :!ctags -R --exclude=.git --exclude=log --exclude=vendor .<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>l :CtrlPLine<cr>

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif


" Reload .vimrc with every save
" autocmd bufwritepost .vimrc source $MYVIMRC

set autoindent                  " Auto indention
set smartindent                 " Smart indent

" :Chomp
command! Chomp silent! normal! :%s/\s\+$//<cr>

abbr bpr binding.pry
abbr iser user
set omnifunc=syntaxcomplete#Complete

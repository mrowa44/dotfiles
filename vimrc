""" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')
Plug 'endel/vim-github-colorscheme'
Plug 'rakr/vim-two-firewatch'
Plug 'atelierbram/Base2Tone-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'farmergreg/vim-lastplace'
Plug 'wincent/ferret'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
  nnoremap <c-p> :Files<cr>
  let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  nmap gaa <Plug>(EasyAlign)ip
Plug 'sheerun/vim-polyglot'
Plug 'lilydjwg/colorizer', { 'for': ['scss', 'css'] }
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['js', 'jsx'] }
  let g:vim_jsx_pretty_colorful_config = 1
Plug 'chemzqm/vim-jsx-improve', { 'for': ['js', 'jsx'] }
" Plug 'rstacruz/vim-closer'
" Plug 'kshenoy/vim-signature'
" Plug 'tpope/vim-repeat'
" Plug 'junegunn/vim-slash'
"   noremap <expr> <plug>(slash-after) 'zz'.slash#blink(3, 110)
call plug#end()

""" General
let g:mapleader = ' '
set hidden
set gdefault
set lazyredraw
set smartindent expandtab shiftwidth=2 softtabstop=2 tabstop=2

""" UI
set splitbelow splitright breakindent textwidth=80
set showcmd visualbell list
set hlsearch ignorecase smartcase showmatch
set termguicolors
" color Base2Tone_SeaDark
color two-firewatch

""" Backups, undo
set noswapfile backup backupdir=~/.vim/backup undofile undodir=~/.vim/undo
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), 'p') | endif
if !isdirectory(expand(&undodir))   | call mkdir(expand(&undodir), 'p')   | endif

""" Mappings
inoremap jj <esc>
inoremap kk <esc>:w<cr>
inoremap jk <esc>dd
nnoremap \ :q<cr>
nnoremap <cr> :w<cr>

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
nnoremap j gj
nnoremap k gk
nnoremap Q @q
nnoremap - $
nnoremap Y y$
nnoremap K i<cr><esc>k$
nnoremap <bs> `[V`]
nnoremap <leader><leader> :wa<cr>

nnoremap <leader>"  :s/'/"<cr>:nohl<cr>
nnoremap <leader>'  :s/"/'<cr>:nohl<cr>
nnoremap <leader>W  :%s/\s\+$//<cr>
nnoremap <leader>e  :edit!<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>g  :Ag<cr>
nnoremap <leader>h  :nohlsearch<cr>
nnoremap <leader>i  :source $MYVIMRC<cr>:PlugInstall<cr>
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

""" Autocommands
augroup vimrcEx
  autocmd!
  autocmd BufLeave * setlocal colorcolumn=
  autocmd BufEnter * let &colorcolumn=join(range(&textwidth+1,240), ',')
  autocmd BufRead,BufNewFile,BufEnter *.md setlocal ft=markdown spell colorcolumn=
  autocmd BufRead,BufNewFile Dockerfile* setlocal ft=dockerfile
  autocmd FileType gitcommit      setlocal textwidth=72 spell
  autocmd FileType cs             setlocal textwidth=130
  autocmd FileType html           setlocal textwidth=130
  autocmd FileType javascript,jsx setlocal textwidth=100
  autocmd FileType javascript,jsx inoremap lg console.log('dupa', );<left><left>
  autocmd FileType ruby inoremap lg binding.pry
  autocmd FileType ruby nnoremap sfs /binding.pry<cr>
  autocmd FileType javascript,jsx,json nnoremap so vi{:sort<cr><c-o>
  autocmd FileType javascript,jsx nnoremap sfs /\vconsole.log\|debugger\|console.table\|console.dir\|console.trace<cr>
  autocmd FileType javascript,jsx nnoremap sr G?render<cr>
  autocmd FileType qf unmap <cr>
  autocmd TextChanged,InsertLeave,FocusLost * wall
  autocmd FocusGained,BufEnter,BufRead,CursorHold * checktime
  autocmd VimResized * execute "normal! \<c-w>="
  autocmd VimLeave   * execute "mksession!"
augroup END

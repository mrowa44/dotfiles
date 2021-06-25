""" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'farmergreg/vim-lastplace'
  Plug 'kshenoy/vim-signature'
  Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsFlyMode = 0
    let g:AutoPairs = {'(':')', '[':']', '{':'}', '```':'```'}
    let g:AutoPairsMoveCharacter = ""
  Plug 'airblade/vim-gitgutter'
    set updatetime=100
    let g:gitgutter_override_sign_column_highlight = 0
    nmap ga <Plug>(GitGutterStageHunk)
  Plug 'dense-analysis/ale'
    let b:ale_fixers = {'javascript': ['eslint']}
    let g:ale_fix_on_save = 1
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign
    nmap <silent> [e <Plug>(ale_previous_wrap)
    nmap <silent> ]e <Plug>(ale_next_wrap)
  Plug 'SirVer/ultisnips'
    set rtp^=$HOME/dotfiles
    let g:UltiSnipsSnippetsDir='~dotfiles/vim_snippets'
    let g:UltiSnipsSnippetDirectories=["vim_snippets"]
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  Plug 'ervandew/supertab'
    set completeopt+=menuone,preview
    let g:SuperTabLongestHighlight = 1
  Plug 'wincent/ferret'
    let g:FerretHlsearch=0
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
   nnoremap <c-p> :Files<cr>
   imap <c-f> <plug>(fzf-complete-file-ag)
   let $FZF_DEFAULT_COMMAND = 'ag --hidden --vimgrep --literal -g ""'
   let g:fzf_layout = { 'down': '~30%' }
   " https://github.com/junegunn/fzf.vim/issues/346
   command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
   " Files command with preview window
   command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Statement'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
  Plug 'sheerun/vim-polyglot'
    let g:javascript_plugin_flow = 0
  Plug 'lilydjwg/colorizer', { 'for': ['scss', 'css'] }
  Plug 'vim-scripts/svg.vim'
  Plug 'atelierbram/Base2Tone-vim'
  " Plug 'endel/vim-github-colorscheme'
  " Plug 'junegunn/vim-slash'
  "   noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 110)
  Plug 'itchyny/lightline.vim'
    set noshowmode
    let g:lightline = {
          \ 'colorscheme': 'one',
          \ 'component_function': {
          \   'filename': 'FilenameForLightline'
          \ }
          \ }
    function! FilenameForLightline()
      return expand('%:p')
    endfunction
  " Plug 'TaDaa/vimade'
call plug#end()

""" General
let g:mapleader = ' '
set hidden
set gdefault
set lazyredraw
set smartindent expandtab shiftwidth=2 softtabstop=2 tabstop=2
set backspace=indent,eol,start
lang en_US
filetype plugin indent on

" """ UI
set splitbelow splitright breakindent textwidth=80 nofoldenable
set ruler noshowcmd nolist visualbell title
set hlsearch incsearch ignorecase smartcase showmatch
set wildmenu wildmode=longest,list,full
set laststatus=2
set scroll=20

set background=dark
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" set colorcolumn=
color Base2Tone_EveningDark
" color Base2Tone_SeaDark
" color Base2Tone_SpaceDark
hi VertSplit ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE guifg=bg
" GitGutter doesn't change sign bg color
highlight GitGutterAdd    guibg=NONE ctermbg=NONE
highlight GitGutterChange guibg=NONE ctermbg=NONE
highlight GitGutterDelete guibg=NONE ctermbg=NONE
highlight GitGutterChangeDelete guibg=NONE ctermbg=NONE
highlight ALEWarningSign ctermfg=yellow guifg=Orange
highlight ALEErrorSign ctermfg=red guifg=Red
set fillchars+=vert:\ 

""" Backups, undo
set noswapfile backup backupdir=~/.vim/backup undofile undodir=~/.vim/undo
if !isdirectory(expand(&backupdir)) | call mkdir(expand(&backupdir), 'p') | endif
if !isdirectory(expand(&undodir))   | call mkdir(expand(&undodir), 'p')   | endif

""" Mappings
inoremap jj <esc>
inoremap kk <esc>:w<cr>
inoremap jk <esc>dd
map § <esc>
imap § <esc>
nmap § <esc>
cmap § <esc>
vmap § <esc>
nnoremap \ :q<cr>
" cnoremap \ :q<cr>
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
" nnoremap J Jx
nnoremap K i<cr><esc>k$
nnoremap <leader><leader> :wa<cr>
nnoremap <bs> `[V`]

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
vnoremap <leader>y  "+y
nnoremap <leader>/  :BLines<cr>
nnoremap <leader>c :set cursorcolumn!<cr>
nnoremap n nzz
nnoremap N Nzz
nnoremap <c-i> <c-i>zz
nnoremap <c-o> <c-o>zz
nnoremap * *zz
nnoremap # #zz

inoremap <c-k>   <c-x><c-p>
inoremap <c-j>   <c-x><c-n>
" inoremap <c-l>   <c-x><c-l>

inoremap <c-b> <c-w>

""" Autocommands
augroup vimrcEx
  autocmd!
  autocmd InsertLeave,FocusLost,CursorHold,TextYankPost * wall
  autocmd FocusGained,BufEnter,BufRead,CursorHold * checktime
  autocmd VimResized * execute "normal! \<c-w>="
  autocmd VimLeave   * execute "mksession!"
  " autocmd BufLeave * set colorcolumn=
  " autocmd BufEnter * let &colorcolumn=join(range(&textwidth+1,500),",")
  " autocmd BufEnter * let &colorcolumn=&textwidth+1
  autocmd BufRead,BufReadPost,BufNewFile,BufEnter,InsertEnter * nohlsearch
  autocmd BufRead,BufNewFile,BufEnter *.md setlocal ft=markdown spell
  autocmd BufRead,BufNewFile Dockerfile* setlocal ft=dockerfile
  autocmd BufRead,BufNewFile *.applescript setlocal ft=applescript
  autocmd BufRead,BufEnter vimrc setlocal ft=vim
  autocmd FileType gitcommit      setlocal textwidth=72 spell
  autocmd FileType gitcommit      :normal A
  autocmd FileType cs             setlocal textwidth=130
  autocmd FileType html           setlocal textwidth=130
  autocmd FileType javascript,jsx,typescript setlocal textwidth=100
  autocmd FileType javascript,jsx,typescript nnoremap sfs /\vconsole.log\|debugger\|console.table\|console.dir\|console.trace\|dupa<cr>
  autocmd FileType javascript,jsx,json,typescript nnoremap so vi{:sort<cr><c-o>
  autocmd FileType ruby inoremap lg binding.pry
  autocmd FileType ruby nnoremap sfs /binding.pry<cr>
  " autocmd FileType qf unmap <cr>
  autocmd FileType crontab setlocal nowritebackup
augroup END

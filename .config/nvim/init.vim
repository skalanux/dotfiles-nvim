"""""" Plugin management stuff """""""
set nocompatible
filetype off
set shell=bash

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'

" Custom plugins...
" EasyMotion - Allows <leader><leader>(b|e) to jump to (b)eginning or (end)
" of words.
Plugin 'easymotion/vim-easymotion'
" Ctrl-P - Fuzzy file search
Plugin 'kien/ctrlp.vim'
" Neomake build tool (mapped below to <c-b>)
Plugin 'benekastah/neomake'
" Autocomplete for python
Plugin 'davidhalter/jedi-vim'
" Remove extraneous whitespace when edit mode is exited
Plugin 'thirtythreeforty/lessspace.vim'

" Screen splitter.  Cool, but doesn't work with nvim.
"Plugin 'ervandew/screen'

" LaTeX editing
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Status bar mods
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'

" Tab completion
Plugin 'ervandew/supertab'


" After all plugins...
call vundle#end()
filetype plugin indent on

""""""" Jedi-VIM """""""
" Don't mess up undo history
let g:jedi#show_call_signatures = "0"


""""""" SuperTab configuration """""""
"let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
function! Completefunc(findstart, base)
    return "\<c-x>\<c-p>"
endfunction

"call SuperTabChain(Completefunc, '<c-n>')

"let g:SuperTabCompletionContexts = ['g:ContextText2']


""""""" General coding stuff """""""
" Highlight 80th column
set colorcolumn=80
" Always show status bar
set laststatus=2
" Let plugins show effects after 500ms, not 4s
set updatetime=500
" Disable mouse click to go to position
set mouse-=a
" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

" If your terminal's background is white (light theme), uncomment the following
" to make EasyMotion's cues much easier to read.
" hi link EasyMotionTarget String
" hi link EasyMotionShade Comment
" hi link EasyMotionTarget2First String
" hi link EasyMotionTarget2Second Statement


""""""" Python stuff """""""
syntax enable
set number showmatch
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
let python_highlight_all = 1


""""""" Keybindings """""""
" Set up leaders
let mapleader=","
let maplocalleader="\\"

" Mac OS X option-left / right
noremap â b
noremap æ e
inoremap â <C-o>b
inoremap æ <C-o>e<right>
" Note - this required binding in preferences (Cmd-,) option+backspace to
" escape+z.
" Why this one is complicated - <C-o> at end of line moves cursor by one
" character, which means a trailing character could be left.
inoremap <expr> ú col('.')>1 ? 'T<Left><C-o>db<Delete>' : '<Backspace>T<Left><c-o>db<Delete>'
" Requires binding option+forward delete to escape
inoremap ø <C-o>dw

" Linux / windows ctrl+backspace ctrl+delete
" Note that ctrl+backspace doesn't work in Linux, so ctrl+\ is also available
imap <C-backspace> ú
imap <C-\> ú
imap <C-delete> ø

" Arrow keys up/down move visually up and down rather than by whole lines.  In
" other words, wrapped lines will take longer to scroll through, but better
" control in long bodies of text.
" NOTE - Disabled since <leader><leader>w|e|b works well with easymotion
"noremap <up> gk
"noremap <down> gj

" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>

autocmd BufNewFile,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r !make<cr>:setlocal buftype=nofile<cr>:setlocal bufhidden=hide<cr>:setlocal noswapfile<cr>
autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>

" Custom configuration  starts here

Plugin 'vim-scripts/indentpython.vim'

syntax on
set nu


Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline-themes'

let g:airline_powerline_fonts = 1
" Para poder ver el statusbar siempre, no solo para splits
set laststatus=2 

set background=dark
colorscheme solarized

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

let g:airline_theme = 'solarized'

set colorcolumn=79
highlight ColorColumn ctermbg=23
"set mouse=i
set mouse=a

highlight ExtraWhitespace ctermbg=23 guibg=23
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" save as sudo
ca w!! w !sudo tee "%"

" better backup, swap and undos storage
set directory=~/.nvim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.nvim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.nvim/dirs/undos
set viminfo+=n~/.nvim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.nvim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif
"
" don't change working directory
let g:ctrlp_working_path_mode = 0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

"Bundle 'klen/python-mode'
"
" Automatically sort python imports
Bundle 'fisadev/vim-isort'
"
"
:let mapleader = ","

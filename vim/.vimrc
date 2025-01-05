set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"disable the arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>


"highlight search match
set incsearch
set nohlsearch
nnoremap <c-h> :set hlsearch!<cr>


set laststatus=2
set t_Co=256
set bg=dark
set nohlsearch
set clipboard=unnamedplus
set autoindent
set fileformat=unix
set completeopt=menuone,longest
nnoremap c "_c
set nocompatible
syntax on
set encoding=utf-8

set number relativenumber

set wildmode=longest,list,full
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
" Emmet Shortcuts
let g:user_emmet_mode='n'   "Only enable normal mode functions.
let g:user_emmet_leader_key=','

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P
"Newtab with ctrl+t
	nnoremap <silent> <C-t> :tabnew<CR>
"Paste from system clipboard with ctrl+i instead of shift insert
	map <S-Insert> <C-i>

"Automatically deletes all trailing whitespace on save.
       autocmd BufWritePre * %s/\s\+$//e

"Navigating with guides
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l
inoremap jj <ESC>



" Enable filetype detection
filetype plugin indent on

" Set spaces for Python files
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" Set tabs for C files
autocmd FileType c setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzzzv
nnoremap N Nzzzv
hi Normal guibg=NONE ctermbg=NONE
colorscheme gruvbox

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

nnoremap <C-p> :Files<CR>


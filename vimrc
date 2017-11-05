
set nocompatible

filetype plugin on
set omnifunc=syntaxcomplete#Complete

call pathogen#infect()
call pathogen#helptags()

syntax enable
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

set encoding=utf-8
set mouse=a
set ai
set nu
set cc=80
set t_Co=256

set cursorline
set whichwrap+=<,>,h,l,[,]

set splitright
set autochdir

set background=dark
set backspace=indent,eol,start

set undofile		" keep an undo file (undo changes after closing)
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" enable mode mouse, allow selection of block and resizing the workflow
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" An autocommand is a command that is executed automatically in response to
" some event, such as a file being read or written or a buffer change.
" autocmd always enable on moden terminal
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

" Display the number of each line
set number

" 4 spaces tabulation
set tabstop=4
set shiftwidth=4

" insert tabs on the start of a line according to
" shiftwidth, not tabstop
set smarttab

set foldenable

" highlight matching [{()}])
set showmatch

"keep 4 lines off the edges when scrolling
set scrolloff=4

let mapleader = ","

nnoremap <leader>v 			<C-w>v
nnoremap <leader>h 			<C-w>s
nnoremap <leader>c 			:Gcommit<Cr>
nnoremap <leader>s 			:Gstatus<Cr>
nnoremap <leader>d 			:Gdiff<Cr>
nnoremap <leader>, 			<C-w>w
nnoremap <leader><space> 	:nohlsearch<CR>
nnoremap <leader>r 			:source ~/.vimrc<CR>
nnoremap <leader>q 			:q<Cr>

" Ctrl keymap
noremap <C-u>				<C-r>
noremap <C-n>				:!norminette **/*.{c,h}<CR>
noremap <C-q>				:wq<Cr>
noremap <C-s>				:w!<Cr>
noremap <silent>	<C-q>	:qa<CR>
map 	<C-h> 				:NERDTreeFind<Cr>
map		<C-g>				:NERDTreeToggle<CR>

" Shift Keymap
noremap <S-Right>			<C-w><Right>
noremap <S-Left>			<C-w><Left>
noremap <S-Up>				<C-w><Up>
noremap <S-Down>			<C-w><Down>

"set statusline=%{fugitive#statusline()}
"set statusline+=%f
"set statusline+=%=
"set statusline+=%l
"set statusline+=/
"set statusline+=%L

" NerdTree
"  How can I open a NERDTree automatically when vim starts up if no files were
"  specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"  How can I open NERDTree automatically when vim starts up on opening a
"  directory?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"  How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowHidden=1

"autocmd VimEnter * call s:openNERDTree()
"autocmd BufCreate * call s:openNERDTree()
"function! s:openNERDTree()
"	NERDTree
"	NERDTreeToggle
"endfunction

" Syntastic
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall -Werror -Wextra'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_remove_include_errors=1
let g:syntastic_c_remove_include_errors=1
let g:syntastic_c_include_dirs = ['../../../include', '../../include','../include','./include']

let g:syntastic_c_checkers=['syntastic-c-gcc']

let g:airline#extensions#tabline#enabled=1

" display indentation guides
set list listchars=tab:\|\ ,trail:·,precedes:←,extends:→,nbsp:␣

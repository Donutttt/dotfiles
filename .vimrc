" all system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"========================================================================================

"vundle options
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


"turn on line numbers
set number

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd " Show (partial) command in status line.
set autowrite " Automatically save before commands like :next and :make
set hidden " Hide buffers when they are abandoned
set mouse=a " Enable mouse usage (all modes)
set cmdheight=2 " height of the command line (?)

" misc?
set clipboard=unnamedplus
set backspace=eol,start,indent

" don't want swap files clogging things up
set directory=$HOME/.vim/swapfiles

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"utf encoding
set encoding=utf-8

"line numbers
set ruler
set number

"search options
set hlsearch
set incsearch
set ignorecase " Do case insensitive matching
set smartcase " Do smart case matching
set incsearch " Incremental search
nnoremap <leader><space> :nohlsearch<cr>

"spaces and tabs
set tabstop=4 " number of visual spaces per tab
set softtabstop=4 " number of spaces in tab when editing
set expandtab " tabs are spaces
set sw=1 " to prevent > from going too far

"ui options
set cursorline
filetype indent on " load filetype-specific indent files
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{[]}]

"fold options
set foldenable " enable folding
set foldlevelstart=10 " show most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level

"wrapping
set nowrap

"color schemes
set t_Co=256
syntax enable
colo slate
colorscheme jellybeans

"gvim toolbar options
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" language syntax
let python_highlight_all=1

"shortcuts
let mapleader=","
nmap <leader>nt :NERDTreeToggle<cr>
nmap <leader>mv :tabnew $HOME/.vimrc<cr>
inoremap jk <esc>
nmap <leader>ns <C-w>w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nmap <leader>px :tabclose<cr>

"plugin options
let g:javascript_plugin_jsdoc = 1
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap <F8> :TagbarToggle<cr>
nmap <Leader>pt :CtrlPTag<cr>
nmap <Leader>st :SyntasticToggleMode<cr>


" syntax checking
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['jshint']

" close ycm window
let g:ycm_autoclose_preview_window_after_completion=1

" enable ctrlp caching
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

" allow fugitive to display in statusline
if has('statusline')
 set laststatus=2
 " Broken down into easily includeable segments
 set statusline=%<%f\    " Filename
 set statusline+=%w%h%m%r " Options
 set statusline+=%{fugitive#statusline()} "  Git Hotness
 set statusline+=\ [%{&ff}/%Y]            " filetype
 set statusline+=\ [%{getcwd()}]          " current dir
 set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*
 let g:syntastic_enable_signs=1
 set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right
endif

" typescript options
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd BufNewFile,BufRead *.ts set syntax=typescript 

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

"rainbow parentheses
let g:rainbow_active = 1

"plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'leafgarland/typescript-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'godlygeek/tabular' 
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'flazz/vim-colorschemes'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'
Plugin 'godlygeek/csapprox'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'

"nerdtree settings
let NERDTreeIgnore = ['\.pyc$']

"ctrlp settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

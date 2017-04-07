set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
behave mswin

let $JS_CMD='node'

set swapfile
set backupdir=~/vim_backup,$VIMRUNTIME
set undodir=~/vim_undo,$VIM_RUNTIME
set directory=~/vim_backup,$VIMRUNTIME

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set nocompatible              " be iMproved, required
filetype off                  " required

set tags+=tags;

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/vim_install/Vim/vimfiles/bundle/Vundle.vim
call vundle#begin('$USERPROFILE/vimfiles/bundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number

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
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd " Show (partial) command in status line.
set autowrite " Automatically save before commands like :next and :make
set hidden " Hide buffers when they are abandoned
set mouse=a " Enable mouse usage (all modes)
set cmdheight=2 " height of the command line (?)

" misc?
set clipboard=unnamed
set backspace=eol,start,indent

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

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
set sw=1 " so that > only indents 1, can be repeated

"ui options
set cursorline
filetype indent on " load filetype-specific indent files
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{[]}]

"fold optionS
set foldenable " enable folding
set foldlevelstart=10 " show most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level

"wrapping
set nowrap

"color schemes
set t_Co=256
syntax enable
" colo slate
" colorscheme jellybeans
" colorscheme molokai
" colorscheme gruvbox
" colorscheme solarized
colorscheme base16-default-dark

set guifont=Inconsolata\ for\ Powerline:h12
"set guifont=Fira\ Mono\ Medium\ for\ Powerline:h9

"gvim toolbar options
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

"shortcuts
let mapleader=","
nmap <leader>nt :NERDTreeToggle<cr>
nmap <leader>mv :tabnew C:\Users\Radinio\vim_install\Vim\_vimrc<cr>
inoremap jk <esc>
nmap <leader>ns <C-w>w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nmap <leader>px :tabclose<cr>
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
" no more arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
" resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" plugin options
let g:javascript_plugin_jsdoc = 1
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

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
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" aiming to speed up ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ 
\ }

" enable ctrlp caching
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

" enable nerdtree line numbers
let NERDTreeShowLineNumbers=1

" air-line
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

set encoding=utf-8 

" rainbow parentheses
let g:rainbow_active = 1

" stop stupid spelling mistakes
ab voucher voucher
ab hte the
ab teh the

"plugins
Plugin 'leafgarland/typescript-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

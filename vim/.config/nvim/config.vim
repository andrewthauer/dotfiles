" ======== General Config ================

set nocompatible                " Disable compatibility with vi
set history=1000                " Store lots of :cmdline history

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" ======== UI Config ================

set number                      " Line numbers are good
set ruler                       " Show row/col number
set backspace=indent,eol,start  " Allow backspace in insert mode
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set showmatch                   " Highlight matching [{()}]
set cursorline                  " Highlight current line
" set cursorcolumn                " Highlight cursor column vertically
set visualbell                  " No sounds
set autoread                    " Reload files changed outside vim
set lazyredraw                  " Redraw only when we need to

" ======== Visual Appearance ================

" Turn on syntax highlighting
syntax on

" Set the color scheme
colorscheme zenburn

" ======== Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ======== Persistent Undo ================
" Keep undo history across sessions, by storing in file
" if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
"   silent !mkdir ~/.vim/backups > /dev/null 2>&1
"   set undodir=~/.vim/backups
"   set undofile
" endif

" ======== Indentation ================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype on
filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
" set list listchars=tab:\ \ ,trail:·

" ======== Text Wrapping ================

set nowrap                      " Don't wrap lines
set linebreak                   " Wrap lines at convenient points

" Set color column guide
set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

" ======== Folds ================

set foldmethod=syntax            " fold based on syntax
set foldnestmax=3                " deepest fold is 3 levels
set nofoldenable                 " dont fold by default

" ======== Completion ================

set wildmenu                     " Enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=longest:list,full   " Wildmenu automcomplete behaviour
" set wildignore=                " Stuff to ignore when tab completing (e.g. *.jpg,*.png,*.gif,*.pdf,*.pyc)

" ======== Scrolling ================

set scrolloff=8                  " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ======== Search ================

set incsearch                    " Find the next match as we type the search
set hlsearch                     " Highlight searches by default
set ignorecase                   " Ignore case when searching...
set smartcase                    " ...unless we type a capital

" ======== File Types ================

augroup filetype_gitcommit
  autocmd!
  autocmd FileType gitcommit set textwidth=72  " Word wrap long git messages
augroup END

augroup filetype_json
  autocmd!
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

augroup filetype_markdown
  autocmd!
  autocmd FileType markdown set wrap linebreak
augroup END

" ======== Split Panes ================

" So instead of ctrl-w then j, it’s just ctrl-j:
nnoremap <C-H> <C-W><C-H>       " Navigate pane left
nnoremap <C-J> <C-W><C-J>       " Navigate pane down
nnoremap <C-K> <C-W><C-K>       " Navigate pane up
nnoremap <C-L> <C-W><C-L>       " Navigate pane right

" More natural split opening
set splitbelow
set splitright

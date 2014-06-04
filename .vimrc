" vi: set ft=vim:

" Not compatible with vi (naturally)
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nobackup            " disable file backups - no one likes junkfiles
set nowrap              " disable line wrap
set smartindent         " intelligently indent while user types
set laststatus=2        " always show status line
set shiftwidth=4        " spaces for [auto]indent
set softtabstop=4       " spaces 1 tab equals
set expandtab           " expand those filthy tabs into proper spaces
set ignorecase          " case insensitivity in searches
set smartcase           " ... unless it looks like I don't want that
set shortmess+=I        " Start screen is distracting
set omnifunc=syntaxcomplete#Complete " Fancy completion

" Proper swap file dirs instead of pooping them out in the pwd
" and yes I know Windows huhu but my job takes me everywhere
if has("win32") || has("win64")
    set dir=$TEMP
else
    set dir=/tmp
endif

" Useful modeline containing filetype, encoding, etc.
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" Theme, syntax highlighting, and highlighted search for color terms
if &t_Co > 2 || has("gui_running")
  colorscheme elflord
  syntax on
  set hlsearch
endif

" GUI specific stuff
if has("gui_running")

  " None of that toolbar, menu and scrollbar nonsense.
  set guioptions-=T
  set guioptions-=r
  set guioptions-=m

  " Nice defaults for positions and size
  set lines=50
  set columns=142
  winpos 390 130

  " Consolas separates numerics well. Deal with it.
  if has("gui_win32")
    set guifont=Consolas:h9:cDEFAULT
  endif

  " Use clipboard register in any yank/put operations with * prefix
  set clipboard=unnamed

endif

" I hear this 'mouse' thing is useful sometimes
if has("mouse")
    set mouse=a
endif

" If autocmd was compiled in
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Group up autocmds
  augroup laggrc
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Jump to last line cursor was on if valid and not first line
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " For dot (graphviz) files that use .gv
  autocmd BufRead,BufNewFile *.gv set filetype=dot

  " For systemd and mysql files
  autocmd BufRead,BufNewFile *.service,*.socket,*.target,my.cnf,.my.cnf,*.network,*.link set filetype=dosini

  " Markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  augroup END

else

  " Force autoindent
  set autoindent

endif
